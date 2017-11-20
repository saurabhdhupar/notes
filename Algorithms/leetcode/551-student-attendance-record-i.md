> https://leetcode.com/problems/student-attendance-record-i/description/

You are given a string representing an attendance record for a student. The record only contains the following three characters:

- 'A' : Absent.
- 'L' : Late.
- 'P' : Present.
A student could be rewarded if his attendance record doesn't contain more than one 'A' (absent) or more than two continuous 'L' (late).

You need to return whether the student could be rewarded according to his attendance record.

Example 1:
```
Input: "PPALLP"
Output: True
```

Example 2:
```
Input: "PPALLL"
Output: False
```

- 题目
  - 给一个字符串，判断其是不是有大于1个的A，或者大于2个的连续的L
- 思路
  - 一个是a的个数计数
  - 一个是tmp和max做对l连续多少次的计数，这个有1，表示连续2次
  - tmp和max仍然要注意那个问题

```go
package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func checkRecord(s string) bool {
	aCount := 0
	lMaxCount := 0
	lTmpCount := 0

	for k, v := range s {
		if string(v) == "A" {
			aCount++
		} else if string(v) == "L" {
			if k > 0 && k < len(s) {
				if s[k] == s[k-1] {
					lTmpCount++
				} else {
					lTmpCount = 0
				}

				if lTmpCount > lMaxCount {
					lMaxCount = lTmpCount
				}
			}
		}
	}

	if lTmpCount > lMaxCount {
		lMaxCount = lTmpCount
	}

	if aCount > 1 {
		return false
	}
	if lMaxCount >= 2 {
		return false
	}

	return true
}

func TestT(t *testing.T) {
	assert.Equal(t, true, checkRecord("PPALLP"))
	assert.Equal(t, false, checkRecord("PPALLL"))
}
```