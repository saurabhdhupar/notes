> https://leetcode.com/problems/detect-capital/description/

Given a word, you need to judge whether the usage of capitals in it is right or not.

We define the usage of capitals in a word to be right when one of the following cases holds:

- All letters in this word are capitals, like "USA".
- All letters in this word are not capitals, like "leetcode".
- Only the first letter in this word is capital if it has more than one letter, like "Google".
Otherwise, we define that this word doesn't use capitals in a right way.
Example 1:
```
Input: "USA"
Output: True
```
Example 2:
```
Input: "FlaG"
Output: False
```
Note: The input will be a non-empty word consisting of uppercase and lowercase latin letters.

- 判断一个字符串是不是正确地使用了大写字母
- 下面是正确地使用的情况
  - 第一个大写字母，后面的都是小写
  - 全部是大写
  - 全部是小写
- 解析上面的规则就是：
  - 长度0或者1的字符串肯定是的
  - 第一个字母不能比第二个字母小
  - 从第二个字母开始，所有字母必须一样

```go
func isLowwer(r rune) bool {
	return r >= 97 && r <= 122
}

func detectCapitalUse(word string) bool {
	if len(word) == 0 || len(word) == 1 {
		return true
	}

	f := isLowwer(rune(word[1]))

	if isLowwer(rune(word[0])) && !isLowwer(rune(word[1])) {
		return false
	}

	for k, v := range word {
		if k == 0 {
			continue
		}
		if isLowwer(v) != f {
			return false
		}
	}

	return true
}
```