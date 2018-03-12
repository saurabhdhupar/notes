> https://leetcode.com/problems/excel-sheet-column-number/description/


Related to question Excel Sheet Column Title

Given a column title as appear in an Excel sheet, return its corresponding column number.

For example:
```
    A -> 1
    B -> 2
    C -> 3
    ...
    Z -> 26
    AA -> 27
    AB -> 28
```

同 [Excel Sheet Column Title](./168-excel-sheet-column-title.md)

只不过上一次是十进制转26进制，这一次是26进制转10进制


```go
package leetcode

import (
	"testing"
	"math"
)

func titleToNumber(s string) int {
	length := len(s)
	n := 0

	for k, v := range s {
		n += int(math.Pow(26, float64(length-k-1))) * (int(v - 64))
	}

	return n
}

func TestA(t *testing.T) {
	{
		n := titleToNumber("Z")
		if n != 26 {
			t.Fatal("get", n)
		}
	}

	{
		n := titleToNumber("AB")
		if n != 28 {
			t.Fatal("get", n)
		}
	}
}

```