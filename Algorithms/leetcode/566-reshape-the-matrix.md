> https://leetcode.com/problems/reshape-the-matrix/description/

In MATLAB, there is a very useful function called 'reshape', which can reshape a matrix into a new one with different size but keep its original data.

You're given a matrix represented by a two-dimensional array, and two positive integers r and c representing the row number and column number of the wanted reshaped matrix, respectively.

The reshaped matrix need to be filled with all the elements of the original matrix in the same row-traversing order as they were.

If the 'reshape' operation with given parameters is possible and legal, output the new reshaped matrix; Otherwise, output the original matrix.

Example 1:
```
Input: 
nums = 
[[1,2],
 [3,4]]
r = 1, c = 4
Output: 
[[1,2,3,4]]
Explanation:
The row-traversing of nums is [1,2,3,4]. The new reshaped matrix is a 1 * 4 matrix, fill it row by row by using the previous list.
```
Example 2:
```
Input: 
nums = 
[[1,2],
 [3,4]]
r = 2, c = 4
Output: 
[[1,2],
 [3,4]]
Explanation:
There is no way to reshape a 2 * 2 matrix to a 2 * 4 matrix. So output the original matrix.
```
Note:
- The height and width of the given matrix is in range [1, 100].
- The given r and c are all positive.

- 一直循环第一个数组就行，不断将数据添加到新的数组
- 因为要换行，所以搞一个cNow记录新数组一行是否满了
- 注意数组初始化
- 注意两个数组的数据容量是一致的，所以不一致直接返回原数组

```go
package main

import (
	"fmt"
)

func matrixReshape(nums [][]int, r int, c int) [][]int {
	if r*c != len(nums)*len(nums[0]) {
		return nums
	}

	newNums := [][]int{}
	rNow := 0
	cNow := 0

	for _, v1 := range nums {
		for _, v2 := range v1 {
			if len(newNums) <= rNow {
				newNums = append(newNums, []int{})
			}
			println(newNums[rNow])
			newNums[rNow] = append(newNums[rNow], v2)
			cNow++
			if cNow == c {
				cNow = 0
				rNow++
			}
		}
	}

	return newNums
}

func main() {
	fmt.Printf("[%+v]\n", matrixReshape([][]int{{1, 2}, {3, 4}}, 1, 4)) // [[1 2 3 4]]
	fmt.Printf("[%+v]\n", matrixReshape([][]int{{1, 2}, {3, 4}}, 2, 4)) // [[1 2] [3 4]
}
```