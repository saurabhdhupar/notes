> https://leetcode.com/problems/single-number/description/

Given an array of integers, every element appears twice except for one. Find that single one.

Note:
Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?

- 给定整数数组，只有一个数只有一个，其余的数字都是两个，找出那个一个的数字
- 常量时间，不使用额外的空间

下面介绍异或：

- 如果 0 XOR 一个数，答案是这个数
  `a ⊕ 0 = a`
- 如果 XOR 两个相同的数，答案是0
  `a ⊕ a = 0`
- 有交换律
  `a ⊕ b ⊕ a = (a ⊕ a) ⊕ b = 0 ⊕ b = b`
- 所以如果有一个数组，里面「只有一个数只有一个，其余的数字都是两个」，那么将他们和0做异或，结果就是那个单独的数据

```go
func singleNumber(nums []int) int {
	d := 0
	for _, v := range nums {
		d ^= v
	}

	return d
}
```