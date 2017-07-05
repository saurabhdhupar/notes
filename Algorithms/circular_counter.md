## 描述
一群人围一个圈，然后每3个人就把他干出去，剩下的人仍然是一个圈，继续上面那个过程，直到所有人都GG了

## 例子
Input: 123456789

Output: 369485271

## 代码
```go
package main

import "fmt"

func josepheus(inputList []int, skip int) {
	skip = skip - 1 // 因为下标从0开始，所以下标2表示第3个数
	idx := 0
	var outputList []int
	for len(inputList) > 0 {
		idx = (skip + idx) % len(inputList)
		outputList = append(outputList, inputList[idx])
		inputList = append(inputList[:idx], inputList[idx+1:]...)
	}

	fmt.Printf("%+v", outputList)

}

func main() {
	input := []int{1, 2, 3, 4, 5, 6, 7, 8, 9}
	josepheus(input, 3)
	// [3 6 9 4 8 5 2 7 1] 
}
```

## 其他
`idx = (skip + idx) % len(inputList)`应该是 `idx = (skip + idx - 1) % len(inputList - 1)`，也就是从当前位置 `+skip`，但是因为 `inputList`减少一个，故 `inputList`和 `skip`同时减一

下面是流程：
```
INPUT
int_list = 123456789
skip = 3
While Iteration:
int_list = 123456789
len(int_list) = 9
skip = 2 # as int_list starts from 0
idx = (0 + 2) % 9 #here previous index was 0
so 3rd element which is 3 in this case eliminated
int_list = 12456789
len(int_list) = 8
idx = (2 + 2) % 8 #here previous index was 2
so 3rd element starting from 4th person which is 6 would be deleted.
and so on
The reason why we have to do this way is I am not putting the people who escape at the back of list so ideally in 2 while iteration the list should have been
45678912 and then no hashing needed to be done, which means you can directly remove the third element
```