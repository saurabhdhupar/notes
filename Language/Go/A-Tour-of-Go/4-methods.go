package main

import (
	"math"
	"fmt"
	"strings"
	"io"
)

// Methods
// Go没有类class，但是，可以在type上定义方法method
// 先定义type
type Vertex struct {
	X, Y float64
}

// var v = Vertex{3, 4}

// method仅仅是特殊的方法
func (v Vertex) Abs() float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

// fmt.Println(v.Abs())

// 所以，可以先定义正常的函数，然后包装在type上
func Abs(v Vertex) float64 {
	return math.Sqrt(v.X*v.X + v.Y*v.Y)
}

// fmt.Println(Abs(v))

// 也可以在non-struct types上定义method
// 只能在相同的package内定义的type上定义method，其余的不行，包括内建类型（如int）
type MyFloat float64

func (f MyFloat) Abs() float64 {
	if f < 0 {
		return float64(-f)
	}
	return float64(f)
}

// Pointer receivers
// 可以使用pointer作为receivers定义method
// 指针method可以修改指针指向的值，如果你需要这样，考虑指针方法吧
// v.Scale(5)  // OK    --> 实际上是这样的：(&v).Scale(5) ---> 在上面那个v.Abs()是一样的情况
// p := &v ; p.Scale(10) // OK
func (v *Vertex) Scale(f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

// 将指针方法修改为正常的函数写法
// Scale(v)  // Compile error!
// Scale(&v) // OK
func Scale(v *Vertex, f float64) {
	v.X = v.X * f
	v.Y = v.Y * f
}

// v.Scale(10)

// 有两个原因，去使用指针receiver
// 1.可以修改值
// 2.避免每次函数调用的时候复制数据（尤其在大数据时候）(但是使用指针会有GC)

// Interfaces 接口
// 接口类型被定义为 a set of method signatures
// 任何实现了这个接口的类型，都是这个接口类型
type Abser interface {
	Abs() float64
	Abser() MyFloat
}

// 接口是隐式实现的
// 一个type通过method声明一个接口，但是没有显示地声明
// 只要实现了这个接口的所有方法，那么，就是实现了这个接口
type I interface {
	M()
}

func (v Vertex) M() {
	fmt.Println(v.X, v.Y)
}

// var v I = Vertex{1, 2} (%v, %T) = ({1 2} main.Vertex)
// v.M()
// 接口可能是`nil`

// Nil interface values
// nil的接口值既没有value也没有type，都是nil。不能调用其method，会报错
// var v I //(%v, %T) =(<nil>, <nil>)

// The empty interface
// 定义0个method的接口是空接口（empty interface）
// 空接口可以包含任何类型的值（因为每一个type都至少有0个method）
// 空接口在处理未知类型的时候使用，例如，`fmt.Print`可以接受任意数量的类型为interface{}的值

func empty_interface() {
	var i interface{} //(%v, %T) = (<nil>, <nil>)
	i = 42            //(%v, %T) = (42, int)
	i = "hello"       //(%v, %T) = (hello, string)
	fmt.Println(i)
}

// Type assertions  类型断言
// `t := i.(T)` 如果i不是类型T,引发一个panic
// `t, ok := i.(T)` ok是true/false，t是值或者T类型的0值

// Type switches
/*
switch v := i.(type) {
case T:
    // here v has type T
case S:
    // here v has type S
default:
    // no match; here v has the same type as i
}
 */

// Stringers 相当于python的 __str__
/*
type Stringer interface {
    String() string
}
 */
type Person struct {
	Name string
	Age  int
}

func (p Person) String() string {
	return fmt.Sprintf("%v (%v years)", p.Name, p.Age)
}

// Readers
// func (T) Read(b []byte) (n int, err error)

// Images
/*
package image

type Image interface {
    ColorModel() color.Model
    Bounds() Rectangle
    At(x, y int) color.Color
}
 */
