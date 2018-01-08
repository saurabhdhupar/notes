package main

import (
	"fmt"
	"math"
	"runtime"
	"time"
)

// 循环和函数
func Sqrt(x float64) float64 {
	z := 1.0
	for i := 0; i < 20; i++ {
		z = z - (math.Pow(z, 2)-x)/(2*z)
	}
	return z
}

func func_switch() {
	fmt.Print("Go runs on ")
	// 命中的case会执行，后面的case不会执行，也就是说不需要break
	// switch会自动结束，除非有fallthrough，就会顺序往下一个case执行
	switch os := runtime.GOOS; os {
	case "darwin":
		fmt.Println("OS X.")
		// fallthrough
	case "linux":
		fmt.Println("Linux.")
	default:
		fmt.Printf("%s.", os) // freebsd, openbsd, plan9, windows...
	}
}

// 没有条件语句的switch，可以作为写长if-then-else语句的清晰的方式
func switch_no_condition() {
	t := time.Now()
	switch {
	case t.Hour() < 12:
		fmt.Println("Good morning!")
	case t.Hour() < 17:
		fmt.Println("Good afternoon.")
	default:
		fmt.Println("Good evening.")
	}
}

// defer语句不会立即执行, 会在return之前执行
func defer_statement() {
	defer fmt.Println("world")
	fmt.Println("hello")
}

// 将结果push到堆栈，然后按照堆栈的出栈顺序计算
// 也就是说defer是现进后出的
func stacking_defer() {
	fmt.Println("counting")

	for i := 0; i < 10; i++ {
		defer fmt.Println(i)
	}

	fmt.Println("done")
}

func main() {
	sum := 0
	// go里面的for循环不需要（ ）
	// { }是必需的
	// 三个参数都是可省的 ： for ;; { do something... }
	for i := 0; i < 10; i++ {
		sum += i
	}

	// 没有分号的时候，for就是while
	for sum < 1000 {
		sum += sum
	}

	// 死循环的简写
	// for {
	//   do something...
	// }

	// if和for一样，不需要 ( )，但是需要{ }
	// 可以在if语句中;前面插入初始化变量语句
	// if else 分句都可以使用这个变量，但是之后就用不了
	if p := math.Pi; p < 5 {

	} else {

	}

	stacking_defer()
}
