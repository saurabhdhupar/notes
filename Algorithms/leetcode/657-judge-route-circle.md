> https://leetcode.com/problems/judge-route-circle/description/


Initially, there is a Robot at position (0, 0). Given a sequence of its moves, judge if this robot makes a circle, which means it moves back to **the original place**.

The move sequence is represented by a string. And each move is represent by a character. The valid robot moves are `R` (Right), `L` (Left), `U` (Up) and `D` (down). The output should be true or false representing whether the robot makes a circle.

Example 1:
```
Input: "UD"
Output: true
```

Example 2:
```
Input: "LL"
Output: false
```

- 很简单，直接循环 case UDRL比较判断坐标就行

```go
package main

func judgeCircle(moves string) bool {
	point := []int{0, 0}
	for _, v := range moves {
		switch v {
		case rune('U'):
			point[1]++
		case rune('D'):
			point[1]--
		case rune('L'):
			point[0]--
		case rune('R'):
			point[0]++
		}
	}

	return point[0] == 0 && point[1] == 0

}
```