> https://leetcode.com/problems/hamming-distance/description/


The [Hamming distance](https://en.wikipedia.org/wiki/Hamming_distance) between two integers is the number of positions at which the corresponding bits are different.

Given two integers `x` and `y`, calculate the Hamming distance.

Note:
0 ≤ `x`, `y` < 231.

Example:
```
Input: x = 1, y = 4

Output: 2

Explanation:
1   (0 0 0 1)
4   (0 1 0 0)
       ↑   ↑
```
The above arrows point to positions where the corresponding bits are different.

- 先转成二进制字符串
- 从后往前扫描比较字符串
- 长的二进制字符串，多的那部分，如果有1也要加上

```go
package main

import "fmt"

func base10ToBinary(x int, s string) string {
	s = fmt.Sprintf("%d", x%2) + s

	x = x / 2

	if x != 0 {
		return base10ToBinary(x, s)
	}

	return s
}

func hammingDistance(x int, y int) int {
	x_b := base10ToBinary(x, "")
	y_b := base10ToBinary(y, "")
	if len(x_b) > len(y_b) {
		x_b, y_b = y_b, x_b
	}

	diff := 0
	for i := len(x_b) - 1; i >= 0; i-- {
		if x_b[i] != y_b[i+len(y_b)-len(x_b)] {
			diff++
		}
	}
	for i := len(y_b) - len(x_b) - 1; i >= 0; i-- {
		if y_b[i] == 49 {
			diff++
		}
	}
	return diff
}
```