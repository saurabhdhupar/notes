> https://leetcode.com/problems/max-consecutive-ones/description/


Given a binary array, find the maximum number of consecutive 1s in this array.

Example 1:
```
Input: [1,1,0,1,1,1]
Output: 3
Explanation: The first two digits or the last three digits are consecutive 1s.
    The maximum number of consecutive 1s is 3.
```
Note:

The input array will only contain `0` and `1`.
The length of input array is a positive integer and will not exceed 10,000

- 输入是只有0和1的数组
- 输入1连续最长的值

```go
func findMaxConsecutiveOnes(nums []int) int {
	c := 0
	m := 0
	for _, v := range nums {
		if v == 1 {
			c++
		} else {
			if c > m {
				m = c
			}
			c = 0
		}
	}
	if c > m {
		m = c
	}

	return m
}
```