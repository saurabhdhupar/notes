## Overview
用以操作 `heap.Interface`

A heap（堆） 父节点是子树的最小值的二叉堆，故最小值是根节点，index 为 0

heap 是一个常见的实现 a priority queue(优先队列) 的方法

## Function
`**where n = h.Len().**`
```go
func Fix(h Interface, i int)
/*
如果修改了第 i 个元素，需要调用这个函数 修复 堆的顺序
和 先干掉 第 i 个元素，然后加入新数据是一样的效果，但是时间复杂度小
时间复杂度 O(log(n))
*/
```

```go
func Init(h Interface)
/*
heap必须先初始化才能进行其他操作
幂等操作
时间复杂度是 O(n)
*/
```

```go
func Pop(h Interface) interface{}
/*
返回 最小的值
时间复杂度 O(log(n))
相当于 Remove(h, 0).
*/
```

```go
func Push(h Interface, x interface{})
/*
推入数据
时间复杂度 O(log(n))
*/
```

```go
func Remove(h Interface, i int) interface{}
/*
conf heap 中 删除 index 为 i 的元素
时间复杂度是 O(log(n))
*/
```

```go
type Interface

type Interface interface {
        sort.Interface
        Push(x interface{}) // add x as element Len()
        Pop() interface{}   // remove and return element Len() - 1.
}

!h.Less(j, i) for 0 <= i < h.Len() and 2*i+1 <= j <= 2*i+2 and j < h.Len()
/*
继承自 sort.Interface
而 sort.Interface 需要定义三个函数： Len() int / Less(i, j int) bool / Swap(i, j int)
*/
```


## Examples

### Package (IntHeap)
```go
// This example demonstrates an integer heap built using the heap interface.
package main

import (
	"container/heap"
	"fmt"
)

// IntHeap 是元素类型为 int 的最小堆
type IntHeap []int

// 定义 堆 需要定义的 sort 的三个函数, 和 pop push 两个函数
func (h IntHeap) Len() int           { return len(h) }              // 长度
func (h IntHeap) Less(i, j int) bool { return h[i] < h[j] }         // 第i个比第j个小
func (h IntHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }    // 交换 i, j
func (h *IntHeap) Push(x interface{}) { *h = append(*h, x.(int)) }  // 推入，需要传指针 h,因为不仅需要改变内容，还需要改变长度
func (h *IntHeap) Pop() interface{} {                               // 推出
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

// This example inserts several ints into an IntHeap, checks the minimum,
// and removes them in order of priority.
func main() {
	h := &IntHeap{2, 1, 5}
	heap.Init(h)                               // 然后这里 heap 就能操作了
	heap.Push(h, 3)                            // 然后这里 heap 就能操作了
	fmt.Printf("minimum: %d\n", (*h)[0])
	for h.Len() > 0 {
		fmt.Printf("%d ", heap.Pop(h))
	}
}
```

### Package (PriorityQueue)
```go
// 用 heap 实现的一个优先级队列
package main

import (
	"container/heap"
	"fmt"
)

// Item 是实现优先级队列的数据结构 的 节点
type Item struct {
	value    string  // 值 ; arbitrary.
	priority int     // 这个节点在队列里的优先级.
	index int        // heap 里面的index.
}

type PriorityQueue []*Item // 优先级队列

func (pq PriorityQueue) Len() int { return len(pq) }

func (pq PriorityQueue) Less(i, j int) bool { return pq[i].priority > pq[j].priority }  // 想要 pop 获取最大值，所以这里是 i 比 j 大

func (pq PriorityQueue) Swap(i, j int) {
	pq[i], pq[j] = pq[j], pq[i]
	pq[i].index = i
	pq[j].index = j
}

func (pq *PriorityQueue) Push(x interface{}) {
	n := len(*pq)
	item := x.(*Item)
	item.index = n
	*pq = append(*pq, item)
}

func (pq *PriorityQueue) Pop() interface{} {
	old := *pq
	n := len(old)
	item := old[n-1]
	item.index = -1 // for safety
	*pq = old[0 : n-1]
	return item
}

func (pq *PriorityQueue) update(item *Item, value string, priority int) {  // 更新，用 heap.Fix
	item.value = value
	item.priority = priority
	heap.Fix(pq, item.index)
}

// 例子，创建了一个优先级队列，
func main() {
  // 初始化 添加了一些数据
	items := map[string]int{
		"banana": 3, "apple": 2, "pear": 4,
	}
	pq := make(PriorityQueue, len(items))
	i := 0
	for value, priority := range items {
		pq[i] = &Item{
			value:    value,
			priority: priority,
			index:    i,
		}
		i++
	}
	heap.Init(&pq)

	// 往队列里添加数据.
	item := &Item{
		value:    "orange",
		priority: 1,
	}
	heap.Push(&pq, item)
	pq.update(item, item.value, 5)

  // 根据优先级获取数据
	for pq.Len() > 0 {
		item := heap.Pop(&pq).(*Item)
		fmt.Printf("%.2d:%s ", item.priority, item.value)
	}
}
```
