## Overview
用以操纵双向链表（a doubly linked list.）

遍历：
```go
for e := l.Front(); e != nil; e = e.Next() {
	// do something with e.Value
}
```

## Type and Function

```go
type Element struct {
      // The value stored with this element.
      Value interface{}
      // contains filtered or unexported fields
}
/*
Element是链表的一个元素
*/
```

```go
    func (e *Element) Next() *Element
    /*
    链表下一个
    */
```

```go
    func (e *Element) Prev() *Element
    /*
    链表前一个
    */
```

```go
type List struct {
    // contains filtered or unexported fields
}
/*
双向链表
*/
```

```go
    func New() *List
    /*
    初始化链表
    */
```

```go
    func (l *List) Back() *Element
    /*
    返回链表的最后一个元素，或者是 nil
    */
```

```go
    func (l *List) Front() *Element
    /*
    返回链表的第一个元素
    */
```

```go
    func (l *List) Init() *List
    /*
    初始化或者清空链表
    */
```

```go
    func (l *List) InsertAfter(v interface{}, mark *Element) *Element
    /*
    在链表l 中 mark元素后面插入一个元素 v，如果mark不在链表中，链表不会改变
    */
```

```go
    func (l *List) InsertBefore(v interface{}, mark *Element) *Element
    /*
    在 mark 之前插入
    */
```

```go
    func (l *List) Len() int
    /*
    链表长度，时间复杂度 O(1)
    */
```

```go
    func (l *List) MoveAfter(e, mark *Element)
    /*
    将链表 l中 e 移动到 mark 后面
    如果 e 或者 mark 不是 l 的元素，或者 e == mark，链表不会改变
    */
```

```go
    func (l *List) MoveBefore(e, mark *Element)
    /*
    把 e 移动到 mark 之前
    */
```

```go
    func (l *List) MoveToBack(e *Element)
    /*
    把 e 移到最后，如果 e 不是 l 的元素，l不变
    */
```

```go
    func (l *List) MoveToFront(e *Element)
    /*
    同上
    */
```

```go
    func (l *List) PushBack(v interface{}) *Element
    /*
    在链表的最后插入一个元素
    */
```

```go
    func (l *List) PushBackList(other *List)
    /*
    将一个链表插入到 l 的最后
    */
```

```go
    func (l *List) PushFront(v interface{}) *Element
    /*
    同前
    */
```

```go
    func (l *List) PushFrontList(other *List)
    /*
    同前
    */
```

```go
    func (l *List) Remove(e *Element) interface{}
    /*
    从 l 中移除 e（如果有 e的话），返回 e.Value
    */
```
