> https://leetcode.com/problems/pascals-triangle-ii/description/

Given an index k, return the k`th row of the Pascal's triangle.

For example, given k = 3,
Return `[1,3,3,1]`.

Note:
Could you optimize your algorithm to use only O(k) extra space?

- 和118差不多
- 为了只使用O(k)的空间，需要使用[第26题](./26-remove-duplicates-from-sorted-array.md)的技巧：从后往前填充数据

```go
package main

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func getRow(rowIndex int) []int {
	t := make([]int, rowIndex+1)
	t[0] = 1

	for i := 0; i <= rowIndex; i++ {
		for j := i; j >= 1; j-- {
			if i == j {
				t[j] = 1
			} else {
				t[j] = t[j-1] + t[j]
			}
		}
	}

	return t
}
```