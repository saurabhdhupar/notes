> https://leetcode.com/problems/baseball-game/description/

You're now a baseball game point recorder.

Given a list of strings, each string can be one of the 4 following types:

Integer (one round's score): Directly represents the number of points you get in this round.
"+" (one round's score): Represents that the points you get in this round are the sum of the last two valid round's points.
"D" (one round's score): Represents that the points you get in this round are the doubled data of the last valid round's points.
"C" (an operation, which isn't a round's score): Represents the last valid round's points you get were invalid and should be removed.
Each round's operation is permanent and could have an impact on the round before and the round after.

You need to return the sum of the points you could get in all the rounds.

Example 1:
```
Input: ["5","2","C","D","+"]
Output: 30
Explanation:
Round 1: You could get 5 points. The sum is: 5.
Round 2: You could get 2 points. The sum is: 7.
Operation 1: The round 2's data was invalid. The sum is: 5.
Round 3: You could get 10 points (the round 2's data has been removed). The sum is: 15.
Round 4: You could get 5 + 10 = 15 points. The sum is: 30.
```

Example 2:
```
Input: ["5","-2","4","C","D","9","+","+"]
Output: 27
Explanation:
Round 1: You could get 5 points. The sum is: 5.
Round 2: You could get -2 points. The sum is: 3.
Round 3: You could get 4 points. The sum is: 7.
Operation 1: The round 3's data is invalid. The sum is: 3.
Round 4: You could get -4 points (the round 3's data has been removed). The sum is: -1.
Round 5: You could get 9 points. The sum is: 8.
Round 6: You could get -4 + 9 = 5 points. The sum is 13.
Round 7: You could get 9 + 5 = 14 points. The sum is 27.
```

Note:
```
The size of the input list will be between 1 and 1000.
Every integer represented in the list will be between -30000 and 30000.
```

一种游戏，规则是输入四种字符串，然后输出得分：
* 数字，本次得分：本数字
* +，本次得分：上两轮有效得分之和
* D，本次得分：上一次有效得分的两倍
* C，使得上一次得分无效

求所有有效得分之和

注意：
* 输入列表的范围是1-1000
* 每个数字范围是-30000 and 30000.

思路：
* list记录有效得分列表
* 只会操作最近两次的得分，添加得分，很简单
* go的slice操作

```go
package ttt

import (
	"testing"
	"strconv"
)

func calPoints(ops []string) int {
	var l []int

	for _, v := range ops {
		var c int
		var d = false

		switch v {
		case "C":
			d = true
		case "D":
			c = 2 * l[len(l)-1]
		case "+":
			c = l[len(l)-2] + l[len(l)-1]
		default:
			c, _ = strconv.Atoi(v)
		}

		if d {
			l = l[:len(l)-1]
		} else {
			l = append(l, c)
		}
	}

	var sum int
	for _, v := range l {
		sum += v
	}

	return sum
}

func TestNumJewelsInStones(t *testing.T) {
	{
		n := calPoints([]string{"5", "2", "C", "D", "+"})
		if n != 30 {
			t.Fatal()
		}
	}

	{
		n := calPoints([]string{"5", "-2", "4", "C", "D", "9", "+", "+"})
		if n != 27 {
			t.Fatal()
		}
	}
}
```