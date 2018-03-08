> https://leetcode.com/problems/jewels-and-stones/description/

You're given strings J representing the types of stones that are jewels, and S representing the stones you have.  Each character in S is a type of stone you have.  You want to know how many of the stones you have are also jewels.

The letters in J are guaranteed distinct, and all characters in J and S are letters. Letters are case sensitive, so "a" is considered a different type of stone from "A".


Example 1:
```
Input: J = "aA", S = "aAAbbbb"
Output: 3
```

Example 2:
```
Input: J = "z", S = "ZZ"
Output: 0
```

Note:
```
S and J will consist of letters and have length at most 50.
The characters in J are distinct.
```

统计字符串j里面的字符在s里面出现的个数。

* j里面的字符是distinct的
* j和s中只有字母，而且大小写敏感。
* s和j的长度最大是50

思路：
* 查找特定字符，考虑map

```go
package ttt

import "testing"

func numJewelsInStones(J string, S string) int {
	var m = make(map[rune]bool)
	for _, v := range J {
		m[v] = true
	}

	n := 0
	for _, v := range S {
		if _, ok := m[v]; ok {
			n++
		}
	}
	return n
}

func TestNumJewelsInStones(t *testing.T) {
	n := numJewelsInStones("aA", "aAAbbbb")
	if n != 3 {
		t.Fatal()
	}

	n = numJewelsInStones("z", "ZZ")
	if n != 0 {
		t.Fatal()
	}
}
```
