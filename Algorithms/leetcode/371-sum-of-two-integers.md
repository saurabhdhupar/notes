> https://leetcode.com/problems/sum-of-two-integers/description/

Calculate the sum of two integers a and b, but you are not allowed to use the operator `+` and `-`.

Example:
Given a = 1 and b = 2, return 3.

Credits:
Special thanks to @fujiaozhu for adding this problem and creating all test cases.

- 不用加减计算和

```go
func getSum(a int, b int) int {
	return (a & b) + (a | b)
}
```