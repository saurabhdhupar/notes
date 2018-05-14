> https://leetcode.com/problems/binary-number-with-alternating-bits/description/

Given a positive integer, check whether it has alternating bits: namely, if two adjacent bits will always have different values.

Example 1:
```
Input: 5
Output: True
Explanation:
The binary representation of 5 is: 101
```
Example 2:
```
Input: 7
Output: False
Explanation:
The binary representation of 7 is: 111.
```
Example 3:
```
Input: 11
Output: False
Explanation:
The binary representation of 11 is: 1011.
```
Example 4:
```
Input: 10
Output: True
Explanation:
The binary representation of 10 is: 1010.
```

* 判断一个整数转成二进制之后，所有相邻的数字是否均不相同（693）
  * 用辗转相除法转二进制
  * 记录上一次的数字，不相同的时候退出
  * 所以不需要两个循环了

```go
func hasAlternatingBits(n int) bool {
	zhen := -1
	if n%2 == 1 {
		zhen = 0
	} else {
		zhen = 1
	}

	for n != 0 {
		if zhen == n%2 {
			return false
		}

		zhen = n % 2
		n = (n - zhen) / 2

	}

	return true
}
```
