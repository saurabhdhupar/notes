## Overview
io 提供了对 `I/O primitives` 的接口，它的主要功能是对现有的接口（例如 `os`）进行一些包装，提供公共的函数什么的

因为这些包装是在较低的层面上，所以如果不是另有说明，不能认为他们是 `safe for parallel execution`（线程安全）

## Constants
```go
const (
        SeekStart   = 0 // seek relative to the origin of the file
        SeekCurrent = 1 // seek relative to the current offset
        SeekEnd     = 2 // seek relative to the end
)
```

## Variables
EOF当且只当没有更多input的时候返回
```go
var EOF = errors.New("EOF")
```

试图在已经关闭的pipe上读写数据的时候
```go
var ErrClosedPipe = errors.New("io: read/write on closed pipe")
```

```go
var ErrNoProgress = errors.New("multiple Read calls return no data or error")
```

```go
var ErrShortBuffer = errors.New("short buffer")
```

```go
var ErrShortWrite = errors.New("short write")
```


```go
var ErrUnexpectedEOF = errors.New("unexpected EOF")
```

## Functions
```go

func Copy(dst Writer, src Reader) (written int64, err error)
/**
 * Copy 从 src 复制 数据 到 dst，直到：EOF 或者 error 发生
 * 返回复制的 number of bytes 和第一个发生的 error(如果有)
 *
 * 一个成功的复制返回 err == nil 而不是 err == EOF，因为 Copy 定义的时候就没想搞到 EOF
 *
 * 如果 src 定义了 WriterTo interface，那么 Copy 就相当于 src.WriteTo(dst)
 * 如果 dst 定义了 ReaderFrom interface，那么 Copy 就相当于 dst.ReadFrom(src)
**/
```
Example
```go
package main

import (
	"io"
	"log"
	"os"
	"strings"
)

func main() {
	r := strings.NewReader("some io.Reader stream to be read\n")

	if _, err := io.Copy(os.Stdout, r); err != nil {
		log.Fatal(err)
	}

}
```

```go
func CopyBuffer(dst Writer, src Reader, buf []byte) (written int64, err error)
/**
 * CopyBuffer 和 Copy 是一样的，除了需要提供一个 buffer，而不是自己生成一个临时的
 *
 * 如果这个 buffer 是 nil，就会生成一个，如果 buffer 长度是0，panic
**/
```

Example
```go
package main

import (
	"io"
	"log"
	"os"
	"strings"
)

func main() {
	r1 := strings.NewReader("first reader\n")
	r2 := strings.NewReader("second reader\n")
	buf := make([]byte, 8)

	// buf is used here...
	if _, err := io.CopyBuffer(os.Stdout, r1, buf); err != nil {
		log.Fatal(err)
	}

	// ... reused here also. No need to allocate an extra buffer.
	if _, err := io.CopyBuffer(os.Stdout, r2, buf); err != nil {
		log.Fatal(err)
	}

}
```

```go
func CopyN(dst Writer, src Reader, n int64) (written int64, err error)
/**
 * CopyN 从 src 往 dst 复制 n 个 byte 的数据
 * 返回复制的 byte 的 number 和 error
 * 当且只当 err == nil 的时候，written == n
 *
 * 如果 dst 实现了 ReaderFrom 接口，那么函数就用这个实现
**/
```

Example
```go
package main

import (
	"io"
	"log"
	"os"
	"strings"
)

func main() {
	r := strings.NewReader("some io.Reader stream to be read")

	if _, err := io.CopyN(os.Stdout, r, 5); err != nil {
		log.Fatal(err)
	}

}
```

```go
func ReadAtLeast(r Reader, buf []byte, min int) (n int, err error)
/**
 * ReadAtLeast 从 r 中读数据到 buf 中（至少 min 个 byte）
 *
 * 返回读取的 byte 的 number，和 error（如果 读取个数小于 min 的话）
 * 如果 没有 byte 读取到，返回 EOF
 * 如果 数据都读完了，n 还是小于 min 的话，返回 ErrUnexpectedEOF
 * 如果 min 比 buf 的长度还长（即永远读不满min个），返回 ErrShortBuffer
 *
 * 当且只当 err == nil 的时候 返回的 n > min
**/
```

Example
```go
package main

import (
	"fmt"
	"io"
	"log"
	"strings"
)

func main() {
	r := strings.NewReader("some io.Reader stream to be read\n")

	buf := make([]byte, 33)
	if _, err := io.ReadAtLeast(r, buf, 4); err != nil {
		log.Fatal(err)
	}
	fmt.Printf("%s\n", buf)

	// buffer smaller than minimal read size.
	shortBuf := make([]byte, 3)
	if _, err := io.ReadAtLeast(r, shortBuf, 4); err != nil {
		fmt.Println("error:", err)
	}

	// minimal read size bigger than io.Reader stream
	longBuf := make([]byte, 64)
	if _, err := io.ReadAtLeast(r, longBuf, 64); err != nil {
		fmt.Println("error:", err)
	}

}
```

```go
func ReadFull(r Reader, buf []byte) (n int, err error)
/**
 * 和上面一个函数一样，不过这回， buf 有多长就读多长
 *
 * 返回复制的数据长度和错误（如果长度小于 buf的长度）
 * error 是 EOF：没有数据读到
 * error 是 ErrUnexpectedEOF：读了一点，但是没有搞满 buf
 * 当且只当 err == nil 的时候返回 n，这个时候 n == len(buf)
**/
```
Example
```go
package main

import (
	"fmt"
	"io"
	"log"
	"strings"
)

func main() {
	r := strings.NewReader("some io.Reader stream to be read\n")

	buf := make([]byte, 4)
	if _, err := io.ReadFull(r, buf); err != nil {
		log.Fatal(err)
	}
	fmt.Printf("%s\n", buf)

	// minimal read size bigger than io.Reader stream
	longBuf := make([]byte, 64)
	if _, err := io.ReadFull(r, longBuf); err != nil {
		fmt.Println("error:", err)
	}
}
```

```go
func WriteString(w Writer, s string) (n int, err error)
/**
 * WriteString 从 s 向 w 写数据
 *
 * 如果 w 实现了 WriteString  方法，那么就调用这个方法，否则调用 w.Write
**/
```
Example
```go
package main

import (
	"io"
	"os"
)

func main() {
	io.WriteString(os.Stdout, "Hello World")

}
```


```go
type ByteReader

type ByteReader interface {
        ReadByte() (byte, error)
}
/**
 * ByteReader 是包装了 ReadByte 方法的接口
 *
 * 它从 input 中读取并返回下一个 byte
**/
```

```go
type ByteScanner

type ByteScanner interface {
        ByteReader
        UnreadByte() error
}
/**
 * ByteScanner 是一个在 ReadByte 基础上添加了 UnreadByte 方法的接口
 *
 * UnreadByte causes the next call to ReadByte to return the same byte as the previous call to ReadByte. It may be an error to call UnreadByte twice without an intervening call to ReadByte
 * ？？？？
**/
```

```go
type ByteWriter

type ByteWriter interface {
        WriteByte(c byte) error
}
/**
 * ByteWriter 是一个包装了 WriteByte 方法的接口
**/
```

```go
type Closer

type Closer interface {
        Close() error
}
/**
 * Closer 是一个包装了基础的 Close 方法的接口
 *
 * 调用一次之后 Close 就失效了，具体的行为是通过这个方法的 owner 决定的
**/
```

```go
type LimitedReader

type LimitedReader struct {
        R Reader // underlying reader
        N int64  // max bytes remaining
}
/**
 * LimitedReader 从 R 中读取数据，但是限制返回数据的最大数量是 N 个 byte
 * 每次调用都会更新 N 的大小，以反映新的剩余数据的大小
 * 当 N < 0 或者 R的底层返回 EOF 的时候返回 EOF
**/
```

```go
    func (l *LimitedReader) Read(p []byte) (n int, err error)
    /**
    **/
```

```go
type PipeReader

type PipeReader struct {
        // contains filtered or unexported fields
}
/**
 * PipeReader 是 读的管道
**/
```

```go
    func Pipe() (*PipeReader, *PipeWriter)
    /**
     * Pipe 创建了一个 synchronous in-memory pipe （内存中同步管道？？？？）
     * 他用来 connect 两个 io.Reader 和 io.Writer
     *
     * pipe 上的 Reads and Writes 是一一对应的，除非 一个 Write 需要 多个 Read
     * 向 PipeWriter blocks 中写数据，直到：写满了 或者 完全消费完数据（没数据了）
     * 数据会直接从 Write 中拷贝到 Read 中，没有中间缓冲过程
     *
     * It is safe to call Read and Write in parallel with each other or with Close.
     * Parallel calls to Read and parallel calls to Write are also safe: the individual calls will be gated sequentially
     * 并行安全？？？
    **/
```

```go
    func (r *PipeReader) Close() error
    /**
     * Close 关闭了 reader，随后往 pipe 的写的那一半写数据会导致 error ErrClosedPipe
    **/
```

```go
    func (r *PipeReader) CloseWithError(err error) error
    /**
     * CloseWithError 和上面那个函数是一样的，只不过最后返回 error 的时候，这个函数会返回输入的参数那个error
    **/
```

```go
    func (r *PipeReader) Read(data []byte) (n int, err error)
    /**
     * Read 实现  标准的 Read 接口：
     * 他从 pipe 中读取数据，阻塞，等待一个 writer 的到来 或者 write 端关闭
     *
     * 如果 write 应发 error err并关闭，那么本函数返回的 error 就是这个 error
     * 否则返回的是 EOF
    **/
```

```go
type PipeWriter

type PipeWriter struct {
        // contains filtered or unexported fields
}
/**
 * A PipeWriter is the write half of a pipe
**/
```

```go
    func (w *PipeWriter) Close() error
    /**
     * 关闭 writer，随后 read 会返回 no bytes 和 EOF
    **/
```

```go
    func (w *PipeWriter) CloseWithError(err error) error
    /**
     * 同上
    **/
```

```go
    func (w *PipeWriter) Write(data []byte) (n int, err error)
    /**
     * 同上面的 Read ，把那个错误替换为 ErrClosedPipe 就可以了
    **/
```

```go
type ReadCloser

type ReadCloser interface {
        Reader
        Closer
}
/**
 * ReadCloser 是一个把基础的 Read 和 Close 方法包起来的接口
**/
```

```go
type ReadSeeker

type ReadSeeker interface {
        Reader
        Seeker
}
/**
 * 同
**/
```

```go
type ReadWriteCloser

type ReadWriteCloser interface {
        Reader
        Writer
        Closer
}
/**
 * 同
**/
```

```go
type ReadWriteSeeker

type ReadWriteSeeker interface {
        Reader
        Writer
        Seeker
}
/**
 * 同
**/
```

```go
type ReadWriter

type ReadWriter interface {
        Reader
        Writer
}
/**
**/
```

```go
type Reader

type Reader interface {
        Read(p []byte) (n int, err error)
}
/**
 * Reader 是包装了基础 Read 方法的接口
 *
 * Read 读取 len(p) 的数据到 p 中
 * 他返回读取的 byte 的 number（0 <= n <= len(p)）和任何可能发生的错误
 * 即使他读到的数据 n < len(p) ，也有可能用掉 p 的全部空间 （？？？？？）
 * 如果数据是可获得的，但是呢，长度又没有 len(p)，会直接返回可获取的数据，而不是继续等待下去
 *
 * 当 Read 遇到一个 error 或者 读到 n > 0 的数据之后碰见了数据读完了哈哈哈哈，他会返回已经读到的数据的数量
 * 他可能返回 (non-nil) error 从相同的调用中？？？？？？，如果再调用一次，就会返回 error 和 n == 0
 * 一般情况下，Reader 读完数据的时候（at the end of the input stream）会返回读到的数据的长度（a non-zero number of bytes）和 err， err 是 EOF 和 nil 二者之一
 * 下一次调用返回 0，EOF
 *
 * 调用者永远需要先处理获取的数据，再考虑错误
 * 这么做会正确的处理 I/O 错误，这样也会允许 EOF 行为
 *
 * 除非 len(p) == 0，否则不要返回 0 和 nil
 * 调用者应该返回 0 和 nil，当什么都没有发生的时候，不包括 EOF的情况
**/
```

```go
    func LimitReader(r Reader, n int64) Reader
    /**
     * ????
    **/
```
    Example
```go
    package main

    import (
    	"io"
    	"log"
    	"os"
    	"strings"
    )

    func main() {
    	r := strings.NewReader("some io.Reader stream to be read\n")
    	lr := io.LimitReader(r, 4)

    	if _, err := io.Copy(os.Stdout, lr); err != nil {
    		log.Fatal(err)
    	}

    }

```

```go
    func MultiReader(readers ...Reader) Reader
    /**
     * ??????
    **/
```
```go
    package main

    import (
    	"io"
    	"log"
    	"os"
    	"strings"
    )

    func main() {
    	r1 := strings.NewReader("first reader ")
    	r2 := strings.NewReader("second reader ")
    	r3 := strings.NewReader("third reader\n")
    	r := io.MultiReader(r1, r2, r3)

    	if _, err := io.Copy(os.Stdout, r); err != nil {
    		log.Fatal(err)
    	}

    }
```

```go
    func TeeReader(r Reader, w Writer) Reader
    /**
    **/
```

```go
type ReaderAt
/**
**/
```

```go
type ReaderFrom
/**
**/
```

```go
type RuneReader
/**
**/
```

```go
type RuneScanner
/**
**/
```

```go
type SectionReader
/**
**/
```

```go
    func NewSectionReader(r ReaderAt, off int64, n int64) *SectionReader
    /**
    **/
```

```go
    func (s *SectionReader) Read(p []byte) (n int, err error)
    /**
    **/
```

```go
    func (s *SectionReader) ReadAt(p []byte, off int64) (n int, err error)
    /**
    **/
```

```go
    func (s *SectionReader) Seek(offset int64, whence int) (int64, error)
    /**
    **/
```

```go
    func (s *SectionReader) Size() int64
    /**
    **/
```

```go
type Seeker
/**
**/
```

```go
type WriteCloser
/**
**/
```

```go
type WriteSeeker
/**
**/
```

```go
type Writer
/**
**/
```

```go
    func MultiWriter(writers ...Writer) Writer
    /**
    **/
```

```go
type WriterAt
/**
**/
```

```go
type WriterTo
/**
**/
```
