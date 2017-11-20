> https://leetcode.com/problems/longest-continuous-increasing-subsequence/description/

Given an unsorted array of integers, find the length of longest `continuous` increasing subsequence.

**Example 1:**
```
Input: [1,3,5,4,7]
Output: 3
Explanation: The longest continuous increasing subsequence is [1,3,5], its length is 3. 
Even though [1,3,5,7] is also an increasing subsequence, it's not a continuous one where 5 and 7 are separated by 4. 
```

**Example 2:**
```
Input: [2,2,2,2,2]
Output: 1
Explanation: The longest continuous increasing subsequence is [2], its length is 1. 
```

Note: Length of the array will not exceed 10,000.

- 求一个数组里面连续递增的子数据的最大长度
- 这一题和那个球股票赚钱的题差不多
- 设两个变量，较大值max和临时值tmp，每次增长的话，tmp+1，否则，取max和tmp中间较大值为max，tmp置为1重新开始
- 注意：
  - 这类有两个变量，一个临时变量的问题，需要考虑在循环结束之后再进行判断一次

```go
package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func findLengthOfLCIS(nums []int) int {
	if len(nums) == 0 {
		return 0
	}

	max := 1
	tmp := 1
	for i := 1; i < len(nums); i++ {
		if nums[i] > nums[i-1] {
			tmp++
		} else {
			if tmp > max {
				max = tmp
			}
			tmp = 1
		}
	}
	if tmp > max {
		max = tmp
	}

	return max
}

func TestT(t *testing.T) {
	assert.Equal(t, 4, findLengthOfLCIS([]int{1, 3, 5, 7}))
	assert.Equal(t, 3, findLengthOfLCIS([]int{1, 3, 5, 4, 7}))
	assert.Equal(t, 1, findLengthOfLCIS([]int{2, 2, 2}))

}
```