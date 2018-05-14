> https://leetcode.com/problems/move-zeroes/description/

Given an array `nums`, write a function to move all `0`'s to the end of it while maintaining the relative order of the non-zero elements.

For example, given `nums = [0, 1, 0, 3, 12]`, after calling your function, `nums` should be `[1, 3, 12, 0, 0]`.

Note:
- You must do this in-place without making a copy of the array.
- Minimize the total number of operations.

Credits:
Special thanks to [@jianchao.li.fighter](https://leetcode.com/discuss/user/jianchao.li.fighter) for adding this problem and creating all test cases.

* 将数组中的0移到末尾，在原数组上操作，最小化操作次数
- 解决
  - 遍历数组
  - 如果不为0，跳过
  - 为0，从这个数据后面找一个不为0的，交换；找不到就说明后面全是0了，返回

```go
func findFirstNotZero(nums []int, start int) int {
	for k, v := range nums {
		if k < start {
			continue
		}
		if v != 0 {
			return k
		}
	}
	return -1
}

func moveZeroes(nums []int) {
	for k, v := range nums {
		println(k, v)
		if v == 0 {
			if k == len(nums)-1 {
				fmt.Printf("2 \n", nums)
				return
			}

			k2 := findFirstNotZero(nums, k+1)
			if k2 == -1 {
				fmt.Printf("1 \n", nums)
				return
			}

			nums[k], nums[k2] = nums[k2], nums[k]
		}
	}

	fmt.Printf("", nums)
}
```