> https://leetcode.com/problems/reverse-string/description/

Write a function that takes a string as input and returns the string reversed.

Example:

Given s = "hello", return "olleh".

- 反转字符串

```go
func reverseString(s string) string {
	d := ""
	for _, v := range s {
		d = string(v) + d
	}
	return d
}
```
