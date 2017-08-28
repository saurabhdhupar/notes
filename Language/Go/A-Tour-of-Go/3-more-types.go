package main

import (
	"fmt"
	//"golang.org/x/tour/pic"
	//"golang.org/x/tour/wc"
	"strings"
)

//Pointers 指针
//类型`*T`是一个指向类型`T`的值的指针，它的零值是`nil`
//`*`取出指针所指向的值
//`&`取出值的指针
//不像C,Go没有指针运算
func pointer() {
	i, j := 42, 2701

	p := &i         // point to i
	fmt.Println(*p) // read i through the pointer
	*p = 21         // set i through the pointer
	fmt.Println(i)  // see the new value of i

	p = &j         // point to j
	*p = *p / 37   // divide j through the pointer
	fmt.Println(j) // see the new value of j
}

//Structs，结构体
//注意它的声明，调用
//用`.`取值
//结构体变量指针
func structs() {
	type Vertex struct {
		X int
		Y int
	}

	v := Vertex{1, 2}
	fmt.Println(v.X) //v.X

	p := &v
	fmt.Println(p.X) //实际上p.x是(*p).X的简写

	var (
		v1 = Vertex{1, 2}  // type : Vertex
		v2 = Vertex{X: 1}  // 默认Y=0
		v3 = Vertex{}      // 默认X=0,Y=0
		p2 = &Vertex{1, 2} //type : *Vertex
	)
	fmt.Println(v1, v2, v3, p2)
}

//Arrays,数组
//`[n]T`指有n个类型为T的值的数组
//数组的长度n是数组类型的一部分，所以不能更改它的长度
//不过Go提供了一个方式解决他，别担心
func arrays() {
	var a [2]string
	a[0] = "Hello"
	a[1] = "World"
	fmt.Println(a[0], a[1])
	fmt.Println(a)

	primes := [6]int{2, 3, 5, 7, 11, 13} //定义并初始化数组
	fmt.Println(primes)
}

//Slices，切片（实际上，Slices比Arrays更常见）
//`[]T`是一个类型为T的slice
func sleces() {
	primes := [6]int{2, 3, 5, 7, 11, 13}

	var s []int = primes[1:4]
	fmt.Println(s)

	fmt.Println([]bool{true, true, false}) //直接定义slice

	fmt.Println(s[1:4])
	fmt.Println(s[:2]) //可以省略切片的上限或下限，就变成了0或者其长度
	fmt.Println(s[1:])

	var ns []int           // s, len(s), cap(s) is [], 0, 0
	fmt.Println(ns == nil) // true

	//make函数创建slice
	//使用第三个参数指定cap
	a := make([]int, 5)    // len(a)=5, cap(a)=5
	b := make([]int, 0, 5) // len(b)=0, cap(b)=5
	fmt.Println(a, b)

	//slice可以包含任何类型，包括slice
	board := [][]string{
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
		[]string{"_", "_", "_"},
	}
	fmt.Println(board)

	// slice append
	var d []int            // len=0 cap=0 []
	d = append(d, 1)       //len=1 cap=1 [1]
	d = append(d, 2, 3, 4) //4 4 [1 2 3 4 ]

}

// slice就像数组一样，它不存储数据，只是描述一个潜在的数组的一部分
// 改变一个slice会改变底层的数组，那么共享这些数组的slice会接受到这些变化
func slice_array() {
	names := [4]string{
		"John",
		"Paul",
		"George",
		"Ringo",
	}
	fmt.Println(names)

	a := names[0:2]
	b := names[1:3]
	fmt.Println(a, b)

	b[0] = "XXX"
	fmt.Println(a, b)
	fmt.Println(names)

	//length of slice 是slice的长度
	//capacity of slice是底层数组的长度
	fmt.Println(len(a)) // length of slice
	fmt.Println(cap(a)) // capacity of slice
}

//Range
//返回两个值，index和value
func rangee() {
	pow := []string{"china", "python", "ocaml", "golang"}
	for index, value := range pow {
		fmt.Printf("第 %d 个是 %v \n", index, value)
	}
	//range循环丢弃值，只需要索引，只用`index`
	for index := range pow {
		fmt.Printf("第 %d 个 \n", index)
	}
	//丢弃索引，只要值，使用 `_, value`
	for _, value := range pow {
		fmt.Printf("是 %v \n", value)
	}
}

//Exercise: Slices
func Pic(dx, dy int) [][]uint8 {
	var s [][]uint8
	for i := 0; i < dx; i++ {
		var d []uint8
		for j := 0; j < dy; j++ {
			d = append(d, uint8((i+j)/2))
		}
		s = append(s, d)
	}
	return s
}

//Maps
//A map maps keys to values
func maps() {
	type Vertex struct {
		Lat, Long float64
	}
	var m map[string]Vertex // m=map[], m == nil
	//这里不能添加数据到空map：m["Bell Labs"] = Vertex{40.68433, -74.39967, }
	m = make(map[string]Vertex) //用make创建map，并且可以添加数据了
	m["Bell Labs"] = Vertex{
		40.68433,
		-74.39967,
	}
	fmt.Println(m["Bell Labs"])

	//Map literals 就像 struct literals, 但是需要key
	var n = map[string]Vertex{
		"Bell Labs": Vertex{
			40.68433, -74.39967,
		},
		"Google": Vertex{
			37.42202, -122.08408,
		},
	}
	fmt.Println(n) //map[Bell Labs:{40.68433 -74.39967} Google:{37.42202 -122.08408}]

	//如果顶层类型只是一个类型名字的话，可以去掉他（类型推断？？）
	var o = map[string]Vertex{
		"Bell Labs": {40.68433, -74.39967},
		"Google":    {37.42202, -122.08408},
	}
	fmt.Println(o) //map[Bell Labs:{40.68433 -74.39967} Google:{37.42202 -122.08408}]

	//Mutating Maps
	//m[key] = elem 插入
	//elem = m[key] 取值
	//delete(m, key) 删除

	//nb点的：
	//如果key在m里面，那么ok就是`true`，否则是`false`
	//如果key不在m里面，elem是map的类型的零值
	//elem, ok = m[key]
	//注意：如果elem或者ok没有声明，那么，可以写成下面这个形式
	//elem, ok := m[key]
}

//Exercise: Maps https://tour.golang.org/moretypes/23
func WordCount(s string) map[string]int {
	sList := strings.Split(s, " ")
	//var sMap map[string]int
	sMap := make(map[string]int)
	for _, value := range sList {
		sMap[value] += 1
	}
	return sMap
}

//Function values
//函数也是值，可以作为函数参数，函数返回值

//Function closures  闭包函数
//这个函数后面的func(int) int的意思是第一次调用返回func(int)，再调用一次返回int，这次需要加上参数int
func adder() func(int) int {
	sum := 0 //变量sum绑定到下面这个函数内了
	return func(x int) int {
		sum += x
		return sum
	}
}

//Exercise: Fibonacci closure https://tour.golang.org/moretypes/26
func fibonacci() func() int {
	m, n := 0, 1
	f := -1
	return func() int {
		f++
		if f < 2 {
			return f
		} else {
			tmp := m
			m = n
			n = tmp + n
			return n
		}

	}
}

func main() {
	//pic.Show(Pic)
	//wc.Test(WordCount)
}
