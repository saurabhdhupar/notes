Package builtin provides documentation for Go's predeclared identifiers. The items documented here are not actually in package builtin but their descriptions here allow godoc to present documentation for the language's special identifiers

## Constants

```go
const (
    true  = 0 == 0 // Untyped bool.
    false = 0 != 0 // Untyped bool.

    iota = 0 // Untyped int.
)
```

## Variables
```go
var nil Type // Type must be a pointer（指针）, channel, func（函数）, interface（接口）, map（字典）, or slice（切片） type
```

## Function

### func append(slice []Type, elems ...Type) []Type
special case :
```go
slice = append([]byte("hello "), "world"...)
```
return `[104 101 108 108 111 32 119 111 114 108 100]`

### func cap(v Type) int
```
`Array`: 即`len(v)`.
`Pointer to array`: 即`len(v)`
`Slice`: slice底层数组的长度，如果是`nil`，则为0
`Channel`: the channel buffer capacity, in units of elements;if v is nil, cap(v) is zero.
```
### func close(c chan<- Type)
关闭一个channel（双向的 bidirectional 或者只发 send-only）
只能从接受方 sender 被关闭

### func complex(r, i FloatType) ComplexType
复数

实部和虚部类型要一致（float32 or float64）

然后返回的结果分别是 (complex64 for float32, complex128 for float64)

### func copy(dst, src []Type) int
从一个slice拷贝到另一个slice

或者，从string拷贝bytes到a slice of bytes

结果是拷贝的长度，即dst, src的最小长度值

### func delete(m map[Type]Type1, key Type)

干掉map的一个key，如果key不存在，没有关系

### func imag(c ComplexType) FloatType

返回复数的虚部

### func len(v Type) int
```
Array: 含有元素的个数.
Pointer to array: 含有元素的个数，如果是nil，返回0
Slice, or map: 含有元素的个数，如果是nil，返回0
String: []byte(str))含有的元素的个数
Channel: the number of elements queued (unread) in the channel buffer; if v is nil, len(v) is zero.
```
### func make(Type, size IntegerType) Type

对三种类型 slice, map, or chan 进行分配和初始化

与new相同的在于 第一个参数是一个类型，而不是一个值

与new不同的在于 返回值和输入参数（这个参数本身是一个类型） 是同一个类型 ， 而不是指向这个类型的指针

#### Slice
```go
m := make([]int, 10)
m // [0 0 0 0 0 0 0 0 0 0]
len(m) // 10
cap(m) // 10

m = make([]int, 10, 20)
m // [0 0 0 0 0 0 0 0 0 0]
len(m) // 10
cap(m) // 20
```

#### Map
创建一个空的map来hold数据，长度可省略

#### Channel
创建指定长度的缓冲的通道

如果长度为0或者省略，那么这个通道就是非缓冲的（有数据就发出？？？）

### `func new(Type) *Type`

参数是类型，分配内存

返回指向这个内存的类型为参数类型的指针

### func panic(v interface{})

直接使用就立即停止 goroutine

使用refer，会有一个错误栈？？？？可以被内置函数recover恢复？？？

### func print(args ...Type)

### func println(args ...Type)

### func real(c ComplexType) FloatType

返回复数的实部

### func recover() interface{}

管理 behavior of a panicking goroutine

## Type

### 只用于文档：
```go
type ComplexType // complex64 or complex128

type FloatType //float32 or float64

type IntegerType // any integer type: int, uint, int8 etc

type Type // any Go type

type Type1 // any Go type
```

### 其他
```go
type bool // true or false

type byte // uint8 alias, 用以区分byte和8位无符号整数

type complex128 // 由 float64 产生的 复数

type complex64 // 由 float32 产生的 复数

type error

type float32 // 32位浮点数

type float64 // 64位浮点数

// intn [2^(n-1), 2^(n-1) - 1]

type int // 不同的机器可能会有不同 int32或者int64，即至少 int32

type int16 // 16位有符号整数  -32768 through 32767

type int32 // -2147483648 through 2147483647

type int64 // -9223372036854775808 through 9223372036854775807

type int8 // -128 through 127.

type rune // int32 alias，用以区分character 和 integer

type string // 8字节字符串，不可变，通常是UTF-8，但不一定一定是这个编码

// uint [0, 2^n - 1]

type uint // 无符号整数

type uint16 //

type uint32 //

type uint64 //

type uint8 //

type uintptr // integer类型，足够大 ，达到可以hold任何指针指向的

```
