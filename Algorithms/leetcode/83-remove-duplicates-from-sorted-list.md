> https://leetcode.com/problems/remove-duplicates-from-sorted-list/description/


Given a sorted linked list, delete all duplicates such that each element appear only once.

For example,
Given `1->1->2`, return `1->2`.
Given `1->1->2->3->3`, return `1->2->3`.

给定一个排序的链表（换成数组也是一样的），去掉重复元素

思路：
* 循环链表，如果当前数据和前一个数字相等，那么直接跳过，否则将链表接上

```go
package leetcode

import (
	"testing"
	"strconv"
)


type ListNode struct {
	Val  int
	Next *ListNode
}

func (l *ListNode) String() string {
	s := ""
	for l != nil {
		s = s + strconv.Itoa(l.Val)
		l = l.Next
	}
	return s
}

func deleteDuplicates(head *ListNode) *ListNode {
	if head == nil {
		return nil
	}
	var p = head
	var n = head
	var tmp = head.Val
	for n != nil {
		if tmp == n.Val {
			n = n.Next
		} else {
			tmp = n.Val
			p.Next = n
			p = p.Next
			n = n.Next
		}
	}
	p.Next = nil
	return head
}

func TestA(t *testing.T) {
	{
		p := ListNode{
			Val: 1,
			Next: &ListNode{
				Val: 1,
				Next: &ListNode{
					Val:  2,
					Next: nil,
				},
			},
		}

		p2 := deleteDuplicates(&p)
		if "12" != p2.String() {
			t.Fatal("get", p2.String())
		}
	}

	{
		p := ListNode{}

		p2 := deleteDuplicates(&p)
		if "0" != p2.String() {
			t.Fatal("get", p2.String())
		}
	}

	{
		p2 := deleteDuplicates(nil)
		if nil != p2 {
			t.Fatal("get", p2)
		}
	}
}

```