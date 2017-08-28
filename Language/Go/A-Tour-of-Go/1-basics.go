package main //所有的程序从main开始

//best style of import
import (
	"fmt"

	"math/cmplx"
	"math"
)

//也可以这样
//import "fmt"
//import "math/rand"

//函数
func add(x int, y int) int {
	return x + y
}

//如果变量类型连续一直，只需要在最后一个后面加上
func add2(x, y int) int {
	return x + y
}

//返回多个值
func swap(x, y string) (string, string) {
	return y, x
}

//在函数定义的时候，如果定了函数的返回值，那么return不带参数，就会返回这些已经定义的值
//这个在短函数中使用，在长函数中使用会造成迷惑
func split(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return
}

//var语句声明变量，可以在包和函数级别
/*
var c, python, java bool

func main() {
	var i int
	fmt.Println(i, c, python, java)
}
 */
//var声明且初始化
var i, j int = 2, 3
var c, python = 0, "False"

//在函数内部，可以使用`:=`来声明并初始化变量
func var_equal() {
	i := 1
	fmt.Println(i)
}

//一些数据类型
func print_some_var() {
	var (
		ToBe   bool       = false
		MaxInt uint64     = 1<<64 - 1
		z      complex128 = cmplx.Sqrt(-5 + 12i)
	)
	fmt.Printf("Type: %T Value: %v\n", ToBe, ToBe)
	fmt.Printf("Type: %T Value: %v\n", MaxInt, MaxInt)
	fmt.Printf("Type: %T Value: %v\n", z, z)
}

//没有给出值的定义的变量将会是零值
//零值有：
//数字类型：0
//布尔：false
//字符串：""（空串）
func zero_value() {
	var i int
	var f float64
	var b bool
	var s string
	fmt.Printf("%v %v %v %q\n", i, f, b, s)
}

//类型转换T(v)，将值v变成类型T
func type_conversions() {
	var i int = 42
	var f float64 = float64(i)
	var u uint = uint(f)
	print(i, f, u)
}

//更简单的类型转换
func type_conversions_2() {
	i := 42
	f := float64(i)
	u := uint(f)
	print(i, f, u)
}

func type_inference() {
	var i int
	j := i // j is an int
	print(j)
}

//常量定义，不能使用`:=`语法
const Pi = 3.14

//https://tour.golang.org/basics/16
const (
	// Create a huge number by shifting a 1 bit left 100 places.
	// In other words, the binary number that is 1 followed by 100 zeroes.
	Big = 1 << 100
	// Shift it right again 99 places, so we end up with 1<<1, or 2.
	Small = Big >> 99
)

func needInt(x int) int {
	return x*10 + 1
}
func needFloat(x float64) float64 {
	return x * 0.1
}

func main() {
	fmt.Println(needInt(Small))
	fmt.Println(needFloat(Small))
	fmt.Println(needFloat(Big))
	fmt.Println(math.Pi) //只有大写开头的变量才会被导出

}
