> https://leetcode.com/problems/valid-anagram/description/

Given two strings s and t, write a function to determine if t is an anagram of s.

For example,
s = "anagram", t = "nagaram", return true.
s = "rat", t = "car", return false.

**Note:**
You may assume the string contains only lowercase alphabets.

**Follow up:**
What if the inputs contain unicode characters? How would you adapt your solution to such case?

- 判断两个字符串是不是异构，即构成的字符正好一样
- 使用哈希表
- 注意可能一个字符会出现多次，所以map应该使用数字，而不是bool

```go
package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func isAnagram(s string, t string) bool {
	if len(s) != len(t) {
		return false
	}

	var sMap = make(map[int32]int)
	for _, v := range s {
		if _, ok := sMap[v]; ok {
			sMap[v]++
		} else {
			sMap[v] = 1
		}
	}

	for _, v := range t {
		if _, ok := sMap[v]; ok {
			sMap[v]--
		} else {
			return false
		}
	}

	for _, v := range sMap {
		if v != 0 {
			return false
		}
	}

	return true
}

func TestT(t *testing.T) {
	assert.Equal(t, true, isAnagram("abc", "bac"))
	assert.Equal(t, false, isAnagram("aacc", "aaac"))

}
```