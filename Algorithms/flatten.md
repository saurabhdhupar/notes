## 描述
实现 Flatten Arrays 的功能：将数组（可以包含数字，或数组，数组的数组。。。）展开为一层
## 例子
Input: var input = [2, 1, [3, [4, 5], 6], 7, [8]];

Output: [2, 1, 3, 4, 5, 6, 7, 8]

## 代码
```go
package main

import (
	"reflect"
	"fmt"
)

func listFlatten(inputList []interface{}, intList *[]int) {
	for _, value := range inputList {
		if reflect.TypeOf(value).Kind() == reflect.Int {
			value, _ := value.(int)
			*intList = append(*intList, value)
		} else {
			if value2, ok := value.([]interface{}); ok {
				listFlatten(value2, intList)
			} else if value2, ok := value.([]int); ok {
				*intList = append(*intList, value2...)
			}
		}
	}
}

func main() {
	a := []int{}
	inputList := []interface{}{2, 1, []interface{}{3, []int{4, 5}, 6}, 7, []int{8}}
	listFlatten(inputList, &a)
	fmt.Printf("last intList is %v\n", a)
	// last intList is [2 1 3 4 5 6 7 8]
}

```

## 其他
使用递归函数处理数据

定义一个变量存储结果，关键是这个变量在递归的过程中需要全局访问

所以可以：

定义全局变量

在递归函数中使用指针（Go）,如果是python，可以使用列表（因为其是引用，不是值传递）
