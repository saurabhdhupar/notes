> https://leetcode.com/problems/1-bit-and-2-bit-characters/description/


We have two special characters. The first character can be represented by one bit `0`. The second character can be represented by two bits (`10` or `11`).

Now given a string represented by several bits. Return whether the last character must be a one-bit character or not. The given string will always end with a zero.

Example 1:
```
Input:
bits = [1, 0, 0]
Output: True
Explanation:
The only way to decode it is two-bit character and one-bit character. So the last character is one-bit character.
```
Example 2:
```
Input:
bits = [1, 1, 1, 0]
Output: False
Explanation:
The only way to decode it is two-bit character and two-bit character. So the last character is NOT one-bit character.
```
Note:

* `1 <= len(bits) <= 1000`.
* bits[i] is always `0` or `1`.

给定一个只有0和1的字符串/int数组，设合法的字符串是：`0`,`10`,`11`

问这个字符串能否合法的以`0`结尾

注意：
* 不是0就是1
* 长度在1到1000之间

思路：

* 递归

```go
package leetcode

import (
	"testing"
)

func isOneBitCharacter(bits []int) bool {
	if len(bits) == 0 {
		return false
	} else if len(bits) == 1 {
		return bits[0] == 0
	} else if len(bits) == 2 {
		return bits[0] == 0 && bits[1] == 0
	} else {
		return (bits[0] == 0 && isOneBitCharacter(bits[1:])) || (bits[0] == 1 && isOneBitCharacter(bits[2:]))
	}
}

func TestA(t *testing.T) {
	{

		if !isOneBitCharacter([]int{1, 0, 0}) {
			t.Fatal("get false")
		}
	}

	{

		if !isOneBitCharacter([]int{0, 0}) {
			t.Fatal("get false")
		}
	}

	{
		if isOneBitCharacter([]int{1, 1, 1, 0}) {
			t.Fatal("get true")
		}
	}
}

```