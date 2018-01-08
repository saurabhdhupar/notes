package main

import (
	"fmt"
	"time"
)

// Goroutines
// goroutine 是一个通过 Go runtime 管理的轻量级的并发线程
// 运行在相同的address space（地址空间），所以必须使用synchronized（同步）来访问共享内存
// `sync`包可以做到这一点，不过一般有别的方法做这个事情
// `go f(x, y, z)`

// Channels
// 使用操作符`<-`发送并接受数据
// ch <- v    // 发送
// v := <-ch  // 接受
// 和map和slice一样，channel必须在使用之前先创建：ch := make(chan int)
// 默认发送接受阻塞，知道对方准备好了，这允许goroutine同步而不需要显示的锁或者条件变量
func sum(s []int, c chan int) {
	sum := 0
	for _, v := range s {
		sum += v
	}
	c <- sum // send sum to c
}

func sum_chan() {
	s := []int{7, 2, 8, -9, 4, 0}

	c := make(chan int)
	go sum(s[:len(s)/2], c)
	go sum(s[len(s)/2:], c)
	x, y := <-c, <-c // receive from c

	fmt.Println(x, y, x+y)
}

// Buffered Channels
// Channels can be buffered. 提供 buffer 长度作为第二个参数来初始化一个 buffered channel: ch := make(chan int, 100)
// Sends to a buffered channel block only when the buffer is full. Receives block when the buffer is empty

// Range and Close
// 如果没有数据，一个发送者sender可以关闭通道。只有sender可以发送关闭通道。往一个关闭的通道发送数据会造成panic
// 一个接受者可以检测是否已经关闭
// channel不像通道，你通常不需要关闭它，除非你需要告诉接受者没有数据了，或者结束下面那个循环

//通过下面的语法：
/*
v, ok := <-ch
 */

//或者使用下面的语法：
/*
for i := range c
 */

//Select
//The select statement lets a goroutine wait on multiple communication operations
func fibonacci(c chan int, quit chan string) {
	x, y := 0, 1
	for {
		select {
		case c <- x:
			x, y = y, x+y
		case <-quit:
			fmt.Println("quit")
			return
		}
	}
}

func selects() {
	c := make(chan int)
	quit := make(chan string)
	go func() {
		for i := 0; i < 10; i++ {
			fmt.Println(<-c)
		}
		quit <- "anything"
	}()
	fibonacci(c, quit)
}

//The default case in a select is run if no other case is ready
func select_default() {
	tick := time.Tick(100 * time.Millisecond)
	boom := time.After(500 * time.Millisecond)
	for {
		select {
		case <-tick:
			fmt.Println("tick.")
		case <-boom:
			fmt.Println("BOOM!")
			return
		default:
			fmt.Println("    .")
			time.Sleep(50 * time.Millisecond)
		}
	}
}

//Exercise: Equivalent Binary Trees
//https://tour.golang.org/concurrency/7 and https://tour.golang.org/concurrency/8

//sync.Mutex
//我们已经看到了怎么在 goroutines 之间进行通信
//但是，我们如果不像通信怎么办，如果在同一时间我们只想要一个 goroutines 能够访问变量，避免死锁
//Go 的标准库 通过 sync.Mutex 提供了互斥，并有两个方法：
/*
Lock
Unlock
 */
/*

// SafeCounter is safe to use concurrently.
//将数据和sync.Mutex定义在一个type内
type SafeCounter struct {
	v   map[string]int
	mux sync.Mutex
}

// Inc increments the counter for the given key.
//对数据操作前后进行Lock和Unlock
func (c *SafeCounter) Inc(key string) {
	c.mux.Lock()
	// Lock so only one goroutine at a time can access the map c.v.
	c.v[key]++
	c.mux.Unlock()
}

// Value returns the current value of the counter for the given key.
//取数据的时候，用defer配合Unlock，这样就可以直接return数据
func (c *SafeCounter) Value(key string) int {
	c.mux.Lock()
	// Lock so only one goroutine at a time can access the map c.v.
	defer c.mux.Unlock()
	return c.v[key]
}

func main() {
	c := SafeCounter{v: make(map[string]int)}
	for i := 0; i < 1000; i++ {
		go c.Inc("somekey")
	}

	time.Sleep(time.Second)
	fmt.Println(c.Value("somekey"))
}
 */

//Exercise: Web Crawler
//https://tour.golang.org/concurrency/10

func main() {
	fmt.Println("")
}
