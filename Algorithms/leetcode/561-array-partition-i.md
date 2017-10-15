> https://leetcode.com/problems/array-partition-i/description/


Given an array of 2n integers, your task is to group these integers into n pairs of integer, say (a1, b1), (a2, b2), ..., (an, bn) which makes sum of min(ai, bi) for all i from 1 to n as large as possible.

Example 1:
```
Input: [1,4,3,2]

Output: 4
Explanation: n is 2, and the maximum sum of pairs is 4 = min(1, 2) + min(3, 4).
```
Note:
- n is a positive integer, which is in the range of [1, 10000].
- All the integers in the array will be in the range of [-10000, 10000].

- 最大值肯定不是较小值而计算总和，所以最大值淘汰
- 最大值可以保住第二大值，所以需要把这两个分在一起
- 剩下的参考上面两条
- 所以先把数组排序，然后将0, 2, 4, ...的和计算出来
- 结果就是n对数组的较小值的和的最大值了

```go
package main

import (
	"sort"
)

func arrayPairSum(nums []int) int {
	sort.Ints(nums)

	s := 0
	for i := 0; i < len(nums); i++ {
		s += nums[i]
		i++
	}

	return s

}
```