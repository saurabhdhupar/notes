> https://leetcode.com/problems/add-two-numbers/description/

You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

就是把十进制数存在链表里面，然后求和（链表前面的数字是最低位）

```
Input: (2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 0 -> 8
```

```go
package test

import (
	"testing"
	"github.com/stretchr/testify/assert"
)

type ListNode struct {
	Val  int
	Next *ListNode
}

// 链表节点分别相加
func addTwoNumbers(l1 *ListNode, l2 *ListNode) *ListNode {
	l3 := &ListNode{}
	l := l3

	add := 0
	for l1 != nil || l2 != nil || add != 0 {
		var x, y int
		if l1 == nil {
			x = 0
		} else {
			x = l1.Val
			l1 = l1.Next
		}

		if l2 == nil {
			y = 0
		} else {
			y = l2.Val
			l2 = l2.Next
		}

		z := x + y + add

		l3.Val = z % 10
		add = z / 10

		if l1 != nil || l2 != nil || add != 0 {
			l3.Next = &ListNode{}
			l3 = l3.Next
		} else {
			l3.Next = nil
		}
	}

	return l
}

func TestFunc(t *testing.T) {
	assert.Nil(t, nil)

	{
		var l1 = &ListNode{
			Val: 5,
			Next: &ListNode{
				Val:  5,
				Next: nil,
			},
		}
		var l2 = &ListNode{
			Val:  5,
			Next: nil,
		}
		l3 := addTwoNumbers(l1, l2)

		assert.Equal(t, 0, l3.Val)
		assert.Equal(t, 6, l3.Next.Val)
		assert.Nil(t, l3.Next.Next)
	}

	{
		var l1 = &ListNode{
			Val: 2,
			Next: &ListNode{
				Val: 4,
				Next: &ListNode{
					Val:  3,
					Next: nil,
				},
			},
		}
		var l2 = &ListNode{
			Val: 5,
			Next: &ListNode{
				Val: 6,
				Next: &ListNode{
					Val:  4,
					Next: nil,
				},
			},
		}
		l3 := addTwoNumbers(l1, l2)

		assert.Equal(t, 7, l3.Val)
		assert.Equal(t, 0, l3.Next.Val)
		assert.Equal(t, 8, l3.Next.Next.Val)
		assert.Nil(t, l3.Next.Next.Next)
	}

	{
		var l1 = &ListNode{
			Val:  5,
			Next: nil,
		}
		var l2 = &ListNode{
			Val:  5,
			Next: nil,
		}
		l3 := addTwoNumbers(l1, l2)

		assert.Equal(t, 0, l3.Val)
		assert.Equal(t, 1, l3.Next.Val)
		assert.Nil(t, l3.Next.Next)
	}
}
```
