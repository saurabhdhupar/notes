package main

import (
	"fmt"
	"math"
	"runtime"
	"time"
)

//练习：循环和函数
func Sqrt(x float64) float64 {
	z := 1.0
	for i := 0; i < 20; i++ {
		z = z - (math.Pow(z, 2)-x)/(2*z)
	}
	return z
}

func func_switch() {
	fmt.Print("Go runs on ")
	//顺序判断，判中，后面的case 不会执行
	//switch会自动结束，除非有fallthrough，就会顺序往下一个case执行.break
	switch os := runtime.GOOS; os {
	case "darwin":
		//break
		fmt.Println("OS X.")
		//fallthrough
	case "linux":
		fmt.Println("Linux.")
	default:
		// freebsd, openbsd,
		// plan9, windows...
		fmt.Printf("%s.", os)
	}
}

//没有条件语句的switch，可以作为写长if-then-else语句的清晰的方式
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

//defer语句不会立即执行,直到周围的其他函数已经返回
func defer_statement() {
	defer fmt.Println("world")
	fmt.Println("hello")
}
//将结果push到堆栈，然后按照堆栈的出栈顺序计算
func stacking_defer() {
	fmt.Println("counting")

	for i := 0; i < 10; i++ {
		defer fmt.Println(i)
	}

	fmt.Println("done")
}
func main() {
	sum := 0
	// 没有( )对for声明括起来
	// { }是必需的
	//都是可省的 ： for ;; { do something... }
	for i := 0; i < 10; i++ {
		sum += i
	}
	//fmt.Println(sum)

	//没有分号的时候，for就是while
	for sum < 1000 {
		sum += sum
	}
	//fmt.Println(i) 这句话错的，没有声明
	//fmt.Println(sum)

	//死循环的简写
	//for {
	// do something...
	//}

	//if和for一样，不需要 ( )，但是需要{ }
	//可以在if语句中;前面插入初始化变量语句
	//if else 分句都可以使用这个变量，但是之后就用不了
	if p := math.Pi; p < 5 {
		//fmt.Printf("%g < 5", p)
	} else {
		//fmt.Printf("%g < 5", p)
	}

	//fmt.Println(Sqrt(2))

	stacking_defer()
}
