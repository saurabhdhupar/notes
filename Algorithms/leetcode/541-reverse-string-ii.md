> https://leetcode.com/problems/reverse-string-ii/description/


Given a string and an integer k, you need to reverse the first k characters for every 2k characters counting from the start of the string. If there are less than k characters left, reverse all of them. If there are less than 2k but greater than or equal to k characters, then reverse the first k characters and left the other as original.

**Example:**
```
Input: s = "abcdefg", k = 2
Output: "bacdfeg"
```

**Restrictions:**
- The string consists of lower English letters only.
- Length of the given string and k will in the range [1, 10000]


- 题目
  - 反转字符串二，题目很复杂，看原文
- 思考
  - 相当于，以k为步长，分解字符串
  - 所有奇数个k串反转，偶数个串不需要


```go
package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func reverse(s string) string {
	ss := ""

	for i := len(s) - 1; i >= 0; i-- {
		ss += string(s[i])
	}

	return ss
}

func reverseStr(s string, k int) string {
	ji := true
	ss := ""
	for i := 0; i*k <= len(s); i++ {
		var sub = ""
		if (i+1)*k > len(s) {
			sub = s[i*k:]
		} else {
			sub = s[i*k:(i+1)*k]
		}

		if ji {
			ss += reverse(sub)
			ji = !ji
		} else {
			ss += sub
			ji = !ji
		}
	}

	return ss
}

func TestT(t *testing.T) {
	assert.Equal(t, "bacdfeg", reverseStr("abcdefg", 2))
}
```