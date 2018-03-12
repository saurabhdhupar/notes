> https://leetcode.com/problems/excel-sheet-column-title/description/

Given a positive integer, return its corresponding column title as appear in an Excel sheet.

For example:
```
    1 -> A
    2 -> B
    3 -> C
    ...
    26 -> Z
    27 -> AA
    28 -> AB
```

如图所示，有一个进制转换，

思考
* 就是一个十进制和26进制的转换
* 二进制的转换是：辗转相除，余数依次加到结果的前面（即第一个余数是结果的最后一位）
* 所以本题就是除以26


```go
package leetcode

import (
	"testing"
)

func convertToTitle(n int) string {
	s := ""

	for n > 0 {
		m := n % 26
		if m == 0 {
			m += 26
		}
		s = string(m+64) + s
		n = (n - m) / 26
	}

	return s
}

func TestA(t *testing.T) {
	{
		n := convertToTitle(26)
		if n != "Z" {
			t.Fatal("get", n)
		}
	}

	{
		n := convertToTitle(28)
		if n != "AB" {
			t.Fatal("get", n)
		}
	}
}

```