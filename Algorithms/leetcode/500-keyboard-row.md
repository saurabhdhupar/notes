> https://leetcode.com/problems/keyboard-row/description/

Given a List of words, return the words that can be typed using letters of alphabet on only one row's of American keyboard like the image below.

![American keyboard](./img/500.png)

Example 1:
```
Input: ["Hello", "Alaska", "Dad", "Peace"]
Output: ["Alaska", "Dad"]
```
Note:
- You may use one character in the keyboard more than once.
- You may assume the input string will only contain letters of alphabet.

- 遍历单词，看看行数是否一致

```go
package main

func getHang(r rune) int {
	var wordTables = map[rune]int{
		'Q': 1, 'W': 1, 'E': 1, 'R': 1, 'T': 1, 'Y': 1, 'U': 1, 'I': 1, 'O': 1, 'P': 1,
		'A': 2, 'S': 2, 'D': 2, 'F': 2, 'G': 2, 'H': 2, 'J': 2, 'K': 2, 'L': 2,
		'Z': 3, 'X': 3, 'C': 3, 'V': 3, 'B': 3, 'N': 3, 'M': 3,
	}

	in := wordTables[r]
	if in == 0 {
		in = wordTables[r-32]
	}

	return in
}

func findWords(words []string) []string {
	ws := []string{}
	for _, word := range words {
		in := getHang(rune(word[0]))
		is := true
		for _, w := range word {
			if in != getHang(w) {
				is = false
				break
			}
		}
		if is {
			ws = append(ws, word)
		}
	}
	return ws
}
```