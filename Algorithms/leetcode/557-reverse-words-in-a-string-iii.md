> https://leetcode.com/problems/reverse-words-in-a-string-iii/description/

Given a string, you need to reverse the order of characters in each word within a sentence while still preserving whitespace and initial word order.

Example 1:
```
Input: "Let's take LeetCode contest"
Output: "s'teL ekat edoCteeL tsetnoc"
```

Note: In the string, each word is separated by single space and there will not be any extra space in the string.

- 用变量d1,d2分别存储长串和单词串，以空格为分割

```go
func reverseWords(s string) string {
	d1 := ""
	d2 := ""
	for _, v := range s {
		if v == rune(' ') {
			d1 = d1 + " " + d2
			d2 = ""
		} else {
			d2 = string(v) + d2
			println(d2)
		}
	}
	d1 = d1 + " " + d2

	return d1[1:]
}
```