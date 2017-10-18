> https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/description/

Given an array of integers where 1 ≤ a[i] ≤ n (n = size of array), some elements appear twice and others appear once.

Find all the elements of [1, n] inclusive that do not appear in this array.

Could you do it without extra space and in O(n) runtime? You may assume the returned list does not count as extra space.

Example:
```
Input:
[4,3,2,7,8,2,3,1]

Output:
[5,6]
```

- 数组大小n，数组元素范围1-n
- 找出在范围1-n+1，但是不在输入范围的数据
- 方案：
  - 循环将index位置的数据放到他本来的位置上
  - 当一次循环没有数据更改的时候，结束大循环
  - 输出位置和数据不一致的数据

```go
func findDisappearedNumbers(nums []int) []int {
	notstop := true
	for notstop {
		notstop = false
		for k, v := range nums {
			if nums[k] != nums[v-1] {
				notstop = true
			}
			nums[k], nums[v-1] = nums[v-1], nums[k]
		}
	}

	d := []int{}
	for k, _ := range nums {
		if nums[k] != k+1 {
			d = append(d, k+1)
		}
	}

	return d
}
```