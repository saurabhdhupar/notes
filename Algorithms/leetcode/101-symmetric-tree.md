> https://leetcode.com/problems/symmetric-tree/description/


Given a binary tree, check whether it is a mirror of itself (ie, symmetric around its center).

For example, this binary tree `[1,2,2,3,4,4,3]` is symmetric:

检测一个二叉树是否左右对称

```
    1
   / \
  2   2
 / \ / \
3  4 4  3
```
But the following [1,2,2,null,3,null,3] is not:
```
    1
   / \
  2   2
   \   \
   3    3
```


Note:
Bonus points if you could solve it both recursively and iteratively.

- 和100题配合，先把树反转，然后判断是不是和原来的树相等

```go
package main

import "fmt"

// Definition for a binary tree node.
type TreeNode struct {
	Val   int
	Left  *TreeNode
	Right *TreeNode
}

func isSameTree(p *TreeNode, q *TreeNode) bool {
	if p == nil && q == nil {
		return true
	} else if q == nil || p == nil {
		return false
	}

	if p.Val != q.Val {
		return false
	}

	fmt.Printf("zuo", p.Left)
	fmt.Printf("zuo", q.Left)

	return isSameTree(p.Left, q.Left) && isSameTree(p.Right, q.Right)
}

func reverse(root *TreeNode) *TreeNode {
	if root == nil {
		return root
	}

	var root2 = &TreeNode{Val: root.Val}

	root2.Right = reverse(root.Left)
	root2.Left = reverse(root.Right)

	return root2
}

func isSymmetric(root *TreeNode) bool {
	return isSameTree(root, reverse(root))
}
```
