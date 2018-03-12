> https://leetcode.com/problems/arranging-coins/description/


You have a total of n coins that you want to form in a staircase shape, where every k-th row must have exactly k coins.

Given n, find the total number of full staircase rows that can be formed.

n is a non-negative integer and fits within the range of a 32-bit signed integer.

Example 1:
```
n = 5

The coins can form the following rows:
¤
¤ ¤
¤ ¤

Because the 3rd row is incomplete, we return 2.
```
Example 2:
```
n = 8

The coins can form the following rows:
¤
¤ ¤
¤ ¤ ¤
¤ ¤

Because the 4th row is incomplete, we return 3.
```

思考：
* 递归
* 每次减少x，然后看剩下的是否大于x？

输入一个数字，用这么多硬币叠梯形，返回最后一个长度与高度一致的数字

```go
package leetcode

import (
	"testing"
)

func rev(n, x int) int {
	s := n - x

	if s <= x {
		return x
	}

	return rev(s, x+1)
}

func arrangeCoins(n int) int {
	if n == 0 {
		return 0
	}

	return rev(n, 1)
}

func TestA(t *testing.T) {
	{

		if 2 != arrangeCoins(5) {
			t.Fatal("get", arrangeCoins(5))
		}
	}

	{

		if 3 != arrangeCoins(8) {
			t.Fatal("get", arrangeCoins(8))
		}
	}
}

```