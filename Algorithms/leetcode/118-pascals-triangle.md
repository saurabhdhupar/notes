> https://leetcode.com/problems/pascals-triangle/description/


Given numRows, generate the first numRows of Pascal's triangle.

For example, given numRows = 5,
Return
```
[
     [1],
    [1,1],
   [1,2,1],
  [1,3,3,1],
 [1,4,6,4,1]
]
```

- 每一行第一个元素是1
- 最后一个元素是1（行数和列数相等的时候）
- 中间的元素i是上一行的元素i-1与i的数据和

```go
package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func generate(numRows int) [][]int {
	var d [][]int
	for i := 0; i < numRows; i++ {
		t := []int{1}

		for j := 1; j <= i; j++ {
			if i == j {
				t = append(t, 1)
			} else {
				t = append(t, d[i-1][j-1]+d[i-1][j])
			}
		}

		d = append(d, t)
	}

	return d
}
```