> https://leetcode.com/problems/number-complement/description/

Given a positive integer, output its complement number. The complement strategy is to flip the bits of its binary representation.

Note:
The given integer is guaranteed to fit within the range of a 32-bit signed integer.
You could assume no leading zero bit in the integer’s binary representation.
Example 1:
```
Input: 5
Output: 2
Explanation: The binary representation of 5 is 101 (no leading zero bits), and its complement is 010. So you need to output 2.
```

Example 2:
```
Input: 1
Output: 0
Explanation: The binary representation of 1 is 1 (no leading zero bits), and its complement is 0. So you need to output 0.
```

输入一个数字，计算他的二进制，然后把二进制的每一位都颠倒一下，输出，这个新的二进制的十进制

```go
package leetcode

import (
	"testing"
	"math"
	"strconv"
)

func findComplement(num int) int {
	var twoToTen = func(s string) int {
		var i int
		for k, v := range s {
			vi, _ := strconv.Atoi(string(v))
			i += vi * int(math.Pow(2, float64(len(s)-k-1)))
		}
		return i
	}

	var tenToTwo = func(i int) string {
		var s string
		for i > 0 {
			j := i % 2
			i = (i - j) / 2
			s = strconv.Itoa(j) + s
		}
		return s
	}

	var rev = func(s string) string {
		var s2 string
		for _, v := range s {
			vi, _ := strconv.Atoi(string(v))
			if vi == 1 {
				vi = 0
			} else {
				vi = 1
			}
			s2 = s2 + strconv.Itoa(vi)
		}
		return s2
	}

	return twoToTen(rev(tenToTwo(num)))
}

func TestA(t *testing.T) {
	{
		n := findComplement(5)
		if n != 2 {
			t.Fatal("get", n)
		}
	}

	{
		n := findComplement(1)
		if n != 0 {
			t.Fatal("get", n)
		}
	}
}

```
