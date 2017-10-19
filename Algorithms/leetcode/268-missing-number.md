> https://leetcode.com/problems/missing-number/description/


Given an array containing n distinct numbers taken from `0, 1, 2, ..., n`, find the one that is missing from the array.

For example,
Given nums = `[0, 1, 3]` return `2`.

Note:
Your algorithm should run in linear runtime complexity. Could you implement it using only constant extra space complexity?

Credits:
Special thanks to [@jianchao.li.fighter](https://leetcode.com/discuss/user/jianchao.li.fighter) for adding this problem and creating all test cases.

- 运用那个[single-number](./136-single-number.md)的技巧
- 只有将0-n的数+nums，那么缺少的那个树就是一个single number

```go
func missingNumber(nums []int) int {
	d := 0
	for _, v := range nums {
		d ^= v
	}
	for i := 0; i <= len(nums); i++ {
		d ^= i
	}

	return d
}
```