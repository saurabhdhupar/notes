> https://leetcode.com/problems/maximum-depth-of-binary-tree/description/


Given a binary tree, find its maximum depth.

The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.

- 递归
- 树的问题可以分解为左右子树的问题

```go
// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func maxDepth(root *TreeNode) int {
	if root == nil {
		return 0
	}
	leftDep := maxDepth(root.Left)
	rightDep := maxDepth(root.Right)

	if leftDep > rightDep {
		return 1 + leftDep
	}

	return 1 + rightDep
}
```