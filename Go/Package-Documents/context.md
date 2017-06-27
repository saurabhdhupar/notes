## Overview
Context 上下文，包括deadline，取消信号，一季其他的请求变量，在api和进程间通信

不要在struct中是使用 Context，一般使用 ctx作为名字，放在函数的第一个参数，显示的传递
```go
func DoSomething(ctx context.Context, arg Arg) error {
	// ... use ctx ...
}
```
即使语法允许，也不要传递一个 nil 给 context，如果你不确定他是什么值，请使用 context.TODO

可以在 goroutines 间使用 Context，这是进程间安全的

[在这，看更多的例子](https://blog.golang.org/context)

## Variables
```go
var Canceled = errors.New("context canceled") // when the context is canceled

var DeadlineExceeded error = deadlineExceededError{} // when the context's deadline passes
```

## Type and Function
```go
type CancelFunc
/*

*/
```

```go
type Context
/*

*/
```

```go
    func Background() Context
    /*
    Background 返回一个 非nil值，但是是一个空Context
    它不会被cancel，没有value，没有deadline
    经常被用在主函数，初始化，测试，和作为 incoming requests 的父 Context
    */
```

```go
    func TODO() Context
    /*
    和上面那个差不多，主要用在你不知道用啥的时候？？？？？
    */
```

```go
    func WithCancel(parent Context) (ctx Context, cancel CancelFunc)
    /*
    返回一个带有「Done channel」的父节点的拷贝ctx和一个函数「cancel CancelFunc」
    当函数「cancel」执行或者父节点的「Done channel」被关闭的时候，这个「Done channel」被关闭
    「cancel」是释放资源的，所以应该尽快执行
    */
```
```go
				package main

				import (
					"context"
					"fmt"
				)

				func main() {
					// gen generates integers in a separate goroutine and
					// sends them to the returned channel.
					// The callers of gen need to cancel the context once
					// they are done consuming generated integers not to leak
					// the internal goroutine started by gen.
					gen := func(ctx context.Context) <-chan int {
						dst := make(chan int)
						n := 1
						go func() {
							for {
								select {
								case <-ctx.Done():
									return // returning not to leak the goroutine
								case dst <- n:
									n++
								}
							}
						}()
						return dst
					}

					ctx, cancel := context.WithCancel(context.Background())
					defer cancel() // cancel when we are finished consuming integers

					for n := range gen(ctx) {
						fmt.Println(n)
						if n == 5 {
							break
						}
					}
				}
```
```go
    func WithDeadline(parent Context, deadline time.Time) (Context, CancelFunc)
    /*
		WithDeadline returns a copy of the parent context with the deadline adjusted to be no later than d. If the parent's deadline is already earlier than d, WithDeadline(parent, d) is semantically equivalent to parent. The returned context's Done channel is closed when the deadline expires, when the returned cancel function is called, or when the parent context's Done channel is closed, whichever happens first.

		Canceling this context releases resources associated with it, so code should call cancel as soon as the operations running in this Context complete.
    */
```
```go
				package main

				import (
					"context"
					"fmt"
					"time"
				)

				func main() {
					d := time.Now().Add(50 * time.Millisecond)
					ctx, cancel := context.WithDeadline(context.Background(), d)

					// Even though ctx will be expired, it is good practice to call its
					// cancelation function in any case. Failure to do so may keep the
					// context and its parent alive longer than necessary.
					defer cancel()

					select {
					case <-time.After(1 * time.Second):
						fmt.Println("overslept")
					case <-ctx.Done():
						fmt.Println(ctx.Err())
					}

				}
```

```go
    func WithTimeout(parent Context, timeout time.Duration) (Context, CancelFunc)
    /*
		WithTimeout returns WithDeadline(parent, time.Now().Add(timeout)).

		Canceling this context releases resources associated with it, so code should call cancel as soon as the operations running in this Context complete:
    */
```
```go
				func slowOperationWithTimeout(ctx context.Context) (Result, error) {
					ctx, cancel := context.WithTimeout(ctx, 100*time.Millisecond)
					defer cancel()  // releases resources if slowOperation completes before timeout elapses
					return slowOperation(ctx)
				}
```

```go
				package main

				import (
					"context"
					"fmt"
					"time"
				)

				func main() {
					// Pass a context with a timeout to tell a blocking function that it
					// should abandon its work after the timeout elapses.
					ctx, cancel := context.WithTimeout(context.Background(), 50*time.Millisecond)
					defer cancel()

					select {
					case <-time.After(1 * time.Second):
						fmt.Println("overslept")
					case <-ctx.Done():
						fmt.Println(ctx.Err()) // prints "context deadline exceeded"
					}

				}
```

```go
    func WithValue(parent Context, key, val interface{}) Context
    /*
		WithValue returns a copy of parent in which the value associated with key is val.

		Use context Values only for request-scoped data that transits processes and APIs, not for passing optional parameters to functions.

		The provided key must be comparable and should not be of type string or any other built-in type to avoid collisions between packages using context. Users of WithValue should define their own types for keys. To avoid allocating when assigning to an interface{}, context keys often have concrete type struct{}. Alternatively, exported context key variables' static type should be a pointer or interface.
    */
```
```go
package main

import (
	"context"
	"fmt"
)

func main() {
	type favContextKey string

	f := func(ctx context.Context, k favContextKey) {
		if v := ctx.Value(k); v != nil {
			fmt.Println("found value:", v)
			return
		}
		fmt.Println("key not found:", k)
	}

	k := favContextKey("language")
	ctx := context.WithValue(context.Background(), k, "Go")

	f(ctx, k)
	f(ctx, favContextKey("color"))

}
```
