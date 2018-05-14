> https://leetcode.com/problems/self-dividing-numbers/description/


A self-dividing number is a number that is divisible by every digit it contains.

For example, 128 is a self-dividing number because 128 % 1 == 0, 128 % 2 == 0, and 128 % 8 == 0.

Also, a self-dividing number is not allowed to contain the digit zero.

Given a lower and upper number bound, output a list of every possible self dividing number, including the bounds if possible.

Example 1:
```
Input:
left = 1, right = 22
Output: [1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 15, 22]
```

Note:
```
The boundaries of each input argument are 1 <= left <= right <= 10000.
```

* self-dividing数，指的是一个数字的每一位都可以被他自己除尽：128 % 1 == 0, 128 % 2 == 0, and 128 % 8 == 0（728）
  * 不能为0
  * 对10取余，获取这个数字的最后一个数字：s = j%10
  * 减去对10取余的数字，然后再除以10，结果是最后一个数字之前的数字：j = (j-s)/10
  * 判断i%s是否不等于0
  * 知道s等于0，退出循环


```go
package ttt

import (
	"testing"
	"reflect"
)

func selfDividingNumbers(left int, right int) []int {
	var l []int
	for i := left; i <= right; i++ {
		j := i

		t := true
		for j > 0 {
			s := j % 10

			if s == 0 {
				t = false
				break
			}

			j = (j - s) / 10

			if i%s != 0 {
				t = false

				break
			}
		}

		if t {
			l = append(l, i)
		}

	}

	return l
}

func TestNumJewelsInStones(t *testing.T) {
	n := selfDividingNumbers(1, 22)
	t.Log("", n)
	if !reflect.DeepEqual(n, []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12, 15, 22}) {
		t.Fatal()
	}
}

```