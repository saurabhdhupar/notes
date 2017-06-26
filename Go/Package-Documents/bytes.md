## Overview

用以处理 byte slices ，类似 strings

## Constants
```go
    const MinRead = 512
```

## Variables
当超过分配的内存的时候
```go
var ErrTooLarge = errors.New("bytes.Buffer: too large")
```

## Functions
```go
func Compare(a, b []byte) int
/*
参数为nil就等于slice为空
The result will be 0 if a==b, -1 if a < b, and +1 if a > b
即是 a - b

使用 bytes.Equal 代替判读等于的情况
*/

func Contains(b, subslice []byte) bool
/*
b 是否包含 subslice
*/

func ContainsAny(b []byte, chars string) bool
/*
UTF-8编码的字符串 chars 是否包含在 b 中
*/

func ContainsRune(b []byte, r rune) bool
/*
Unicode code point r 在不在 b中
*/

func Count(s, sep []byte) int
/*
计算 s 中出现了 sep 多少次（非重叠）
如果 sep 是空的slice，那么结果是s所含的 Unicode code的数量+1
*/

func Equal(a, b []byte) bool
/*
判断 a b 是否相等
nil视为空slice
*/

func EqualFold(s, t []byte) bool
/*
使用 case-folding （大小写折叠，包括不同语言）来判断 a b 是否相等

Go == go
ς == σ == Σ
*/

func Fields(s []byte) [][]byte
/*
用空格分割

"  foo bar  baz   " => ["foo" "bar" "baz"]
*/

func FieldsFunc(s []byte, f func(rune) bool) [][]byte
/*
自己编写函数 f 来对 s 进行分割
如果 f 对 s 的所有元素都返回 true / 或者 s 长度为 0 ，返回空的slice

注意，同一个f 对 s 的结果必须是一致的（true和false一致），因为其实非有序的，所以如果不一致可能会有错误
*/

func HasPrefix(s, prefix []byte) bool
/*
判断是否有前缀

bytes.HasPrefix([]byte("Gopher"), []byte("")) => true
*/

func HasSuffix(s, suffix []byte) bool
/*
有后缀
*/

func Index(s, sep []byte) int
/*
如果 sep 在 s 里面，返回 sep 第一个元素在 s 中的下标
如果不在，返回 -1
*/

func IndexAny(s []byte, chars string) int
/*
对字符串 chars 的所有元素是否在 s 中进行检查，返回 最小下标
如果一个都没有，返回 -1
*/

func IndexByte(s []byte, c byte) int
/*
对单个 byte 进行查找
*/

func IndexFunc(s []byte, f func(r rune) bool) int
/*
使用自定义函数 f 进行查找
*/

func IndexRune(s []byte, r rune) int
/*
对单一 rune 进行查找
*/

func Join(s [][]byte, sep []byte) []byte
/*
拼接
*/

func LastIndex(s, sep []byte) int
/*
最后一次出现的 第一个 byte 的 下标
*/

func LastIndexAny(s []byte, chars string) int
/*
见  IndexAny
*/

func LastIndexByte(s []byte, c byte) int
/*
见 IndexByte
*/

func LastIndexFunc(s []byte, f func(r rune) bool) int
/*
见 IndexFunc
*/

func Map(mapping func(r rune) rune, s []byte) []byte
/*
使用函数 mapping 对 s 进行转换
*/

func Repeat(b []byte, count int) []byte
/*
返回 b 重复 count 次
如果 count 是负数 或者 内存溢出，会 panic
*/

func Replace(s, old, new []byte, n int) []byte
/*
将 s 中 old 替换为 new，数目为 n
如果 n 是 -1 ，替换所有
如果 old 为空，那么对 每个片段 替换为 n+1个

bytes.Replace([]byte("a xx"), []byte(""), []byte("moo"), -1) => mooamooa mooxmooxmoo （长度是 1+1 2+1）
*/

func Runes(s []byte) []rune
/*

*/

func Split(s, sep []byte) [][]byte
/*
分割
如果 sep 是空，完全分割
*/

func SplitAfter(s, sep []byte) [][]byte
/*
将 sep 跟在 返回的结果的每一项的后面
当然了，最后一下肯定没有sep啊
*/

func SplitAfterN(s, sep []byte, n int) [][]byte
/*
如果 n == 0，返回空
如果 n < 0，和 SplitAfter 一致
如果 n > 0，那么会返回 n 个元素的结果，并且把剩下的元素拼接在最后一个元素的后面
*/

func SplitN(s, sep []byte, n int) [][]byte
/*
分割，同 SplitAfterN ，如果 n >0 ，会把后面的组合起来
*/

func Title(s []byte) []byte
/*
将首字母大写
*/

func ToLower(s []byte) []byte
/*
将所有字母变小写
*/

func ToLowerSpecial(c unicode.SpecialCase, s []byte) []byte
/*

*/

func ToTitle(s []byte) []byte
/*
所有字母变大写
*/

func ToTitleSpecial(c unicode.SpecialCase, s []byte) []byte
/*

*/

func ToUpper(s []byte) []byte
/*
所有字母变大写
*/

func ToUpperSpecial(c unicode.SpecialCase, s []byte) []byte
/*

*/

func Trim(s []byte, cutset string) []byte
/*
将 s 前 和 后 ， 出现的 cutset 中的字符 去除
*/

func TrimFunc(s []byte, f func(r rune) bool) []byte
/*
用函数 f 做 Trim
*/

func TrimLeft(s []byte, cutset string) []byte
/*
左边 Trim
*/

func TrimLeftFunc(s []byte, f func(r rune) bool) []byte
/*
用函数 f 做 左边 Trim
*/

func TrimPrefix(s, prefix []byte) []byte
/*
将 prefix 做前缀 和 s 做比对，去除重叠部分

var b = []byte("Goodbye,, world!")
b = bytes.TrimPrefix(b, []byte("Goodbye,"))   `Goodbye,`重叠，剩下`, world!`
b = bytes.TrimPrefix(b, []byte(","))          `,`重叠，剩下` world!`
fmt.Printf("Hello%s", b)                      输出`Hello world!`
*/

func TrimRight(s []byte, cutset string) []byte
/*

*/

func TrimRightFunc(s []byte, f func(r rune) bool) []byte
/*

*/

func TrimSpace(s []byte) []byte
/*
去除前后 space

" \t\n a lone gopher \n\t\r\n" => "a lone gopher"
*/

func TrimSuffix(s, suffix []byte) []byte
/*
见 TrimPrefix
*/

type Buffer
    /*
    大部分情况下， new(Buffer) 声明一个变量，已经足够使用了
     */

    func NewBuffer(buf []byte) *Buffer
    /*
    初始化 一个 Buffer 来 读写数据
    */

    func NewBufferString(s string) *Buffer
    /*
    同上
    */

    func (b *Buffer) Bytes() []byte
    /*

    */

    func (b *Buffer) Cap() int
    /*
    buffer 的底层数据长度，也就是 分配给他的总空间的大小
    */

    func (b *Buffer) Grow(n int)
    /*
    如果 n < 0，panic
    如果没有空间来施展这个函数，panic with ErrTooLarge
    给 b 增加 n 个 byte 的空间
    */

    func (b *Buffer) Len() int
    /*
    未读部分长度
    b.Len() == len(b.Bytes()).
    */

    func (b *Buffer) Next(n int) []byte
    /*
    从 buffer 中 获取 n 个 byte 的数据
    如果已有数据小于 n，返回所有
    */

    func (b *Buffer) Read(p []byte) (n int, err error)
    /*
    从 b 中读取 p的长度的 数据
    如果 p的长度大于 b的长度，那么返回 b的所有数据
    */

    func (b *Buffer) ReadByte() (byte, error)
    /*
    从 b中读取 byte，如果没有数据了，返回  io.EOF
    */

    func (b *Buffer) ReadBytes(delim byte) (line []byte, err error)
    /*
    delim是哨兵
    会不停的从 b中取数据，直到遇上 delim
    当且只当 b中含有 delim时候，err!=nil
    */

    func (b *Buffer) ReadFrom(r io.Reader) (n int64, err error)
    /*
    不断的从 r中读取数据到 b， n bytes的数量
    s在读取到数据的时候，除了io.EOF的任何错误都会（允许）发生
    如果 b太大了，那么会引发 ErrTooLarge panic
    */

    func (b *Buffer) ReadRune() (r rune, size int, err error)
    /*

    */

    func (b *Buffer) ReadString(delim byte) (line string, err error)
    /*

    */

    func (b *Buffer) Reset()
    /*

    */

    func (b *Buffer) String() string
    /*

    */

    func (b *Buffer) Truncate(n int)
    /*

    */

    func (b *Buffer) UnreadByte() error
    /*

    */

    func (b *Buffer) UnreadRune() error
    /*

    */

    func (b *Buffer) Write(p []byte) (n int, err error)
    /*

    */

    func (b *Buffer) WriteByte(c byte) error
    /*

    */

    func (b *Buffer) WriteRune(r rune) (n int, err error)
    /*

    */

    func (b *Buffer) WriteString(s string) (n int, err error)
    /*

    */

    func (b *Buffer) WriteTo(w io.Writer) (n int64, err error)
    /*

    */

type Reader

    func NewReader(b []byte) *Reader
    /*

    */

    func (r *Reader) Len() int
    /*

    */

    func (r *Reader) Read(b []byte) (n int, err error)
    /*

    */

    func (r *Reader) ReadAt(b []byte, off int64) (n int, err error)
    /*

    */

    func (r *Reader) ReadByte() (byte, error)
    /*

    */

    func (r *Reader) ReadRune() (ch rune, size int, err error)
    /*

    */

    func (r *Reader) Reset(b []byte)
    /*

    */

    func (r *Reader) Seek(offset int64, whence int) (int64, error)
    /*

    */

    func (r *Reader) Size() int64
    /*

    */

    func (r *Reader) UnreadByte() error
    /*

    */

    func (r *Reader) UnreadRune() error
    /*

    */

    func (r *Reader) WriteTo(w io.Writer) (n int64, err error)
    /*

    */

```
