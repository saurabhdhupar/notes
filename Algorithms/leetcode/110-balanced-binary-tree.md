··> https://leetcode.com/problems/balanced-binary-tree/description/


Given a binary tree, determine if it is height-balanced.

For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two subtrees of every node never differ by more than 1.

- 判断二叉树是不是平衡二叉树（左右节点高度差不超过1）
- 依然是左右子树分开，计算左右子树的高度的较大值，如果大于1，就不是
- 但是注意一点，有可能下游的高度差大于1，上游的会小于1，所以一旦遇见高度差大于1的就标记为已经不是平衡二叉树了（用-1表示）
- 然后在所有的判断里，先看看左右子树是不是已经不是平衡二叉树了，再比较高度差


```go
package main

import (
	"math"
)

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

// 高度差 / 是平衡树
func check(p *TreeNode) (int, bool) {
	if p == nil {
		return 0, true
	}

	leftHigh, leftOK := check(p.Left)
	if !leftOK {
		return 0, false
	}

	rightHigh, rightOK := check(p.Right)
	if !rightOK {
		return 0, false
	}

	cha := int(math.Abs(float64(leftHigh - rightHigh)))
	if cha > 1 {
		return 0, false
	}

	return 1 + int(math.Max(float64(leftHigh), float64(rightHigh))), true
}

func isBalanced(root *TreeNode) bool {
	_, ok := check(root)
	return ok
}

```