> https://leetcode.com/problems/longest-substring-without-repeating-characters/description/

Given a string, find the length of the longest substring without repeating characters.

非重复字符最长子串查找，输出子串长度

Examples:

Given "abcabcbb", the answer is "abc", which the length is 3.

Given "bbbbb", the answer is "b", with the length of 1.

Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

思路

- 搞一个i,j分别指向最长字符串的首尾，然后将i和j之间的字符存在一个hashTable里面
- 开始的时候字符串长度为0，所以i和j都是0
- 然后将字符串依次放进map（如果这个字符串以前没有碰到的话），j因为指向字符串的尾部，自增
- 如果出现字符串重复，将头部指向的字符串移除map，然后位置后移，i自增
- j和i的差值的最大值就是结果

```golang
package test

import (
	"testing"
	"github.com/stretchr/testify/assert"
)

func longestString(s string) int {
	m := make(map[byte]bool)
	l := 0

	for i, j := 0, 0; i < len(s) && j < len(s); {
		if exist, ok := m[s[j]]; ok && exist {
			m[s[i]] = false
			i++
		} else {
			m[s[j]] = true
			j++

			if j-i > l {
				l = j - i
			}
		}
	}

	return l
}

func TestFunc(t *testing.T) {
	assert.Nil(t, nil)
	assert.Equal(t, 3, longestString("abcabcbb"))
	assert.Equal(t, 1, longestString("bbbbb"))
	assert.Equal(t, 3, longestString("pwwkew"))
}
```

```python
def longest_string(s):
    lonest_s = set()
    lonest_l = 0

    i, j = 0, 0
    while i < len(s) and j < len(s):
        if s[j] not in lonest_s:
            lonest_s.add(s[j])
            j += 1
            lonest_l = max(lonest_l, j - i)
        else:
            lonest_s.remove(s[i])
            i += 1

    return lonest_l


if __name__ == '__main__':
    for s, l in [('abcabcbb', 3), ('bbbbb', 1), ('pwwkew', 3)]:
        assert longest_string(s) == l

    print('ok')
```