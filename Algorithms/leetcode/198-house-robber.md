> https://leetcode.com/problems/house-robber/description/

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and **it will automatically contact the police if two adjacent houses were broken into on the same night.**

Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight **without alerting the police.**

**Credits:**
Special thanks to [@ifanchu](https://oj.leetcode.com/discuss/user/ifanchu) for adding this problem and creating all test cases. Also thanks to @ts for adding additional test cases.

- 问题
  - 从一个数组中，取出若干元素，求其和最大值，要求不能有相邻的元素
- 思考
  - 这个问题和那个上楼梯需要多少步的问题一致
  - 先取第一个元素，那么结果就是这个元素加上第三个元素开始的后面的数组的最大值
  - 先取第二个，第四个开始
  - 先取第三个，是第一个分类的子问题

```go
package main

import (
	"fmt"
	"testing"
	"math"
	"strings"

	"github.com/stretchr/testify/assert"
)

var d = make(map[string]int)

func rob(nums []int) int {
	numss := []string{}
	for _, v := range nums {
		numss = append(numss, fmt.Sprintf("%d", v))
	}
	numsS := strings.Join(numss, "")
	if v, ok := d[numsS]; ok {
		return v
	}

	if len(nums) == 0 {
		return 0
	} else if len(nums) == 1 {
		return nums[0]
	} else if len(nums) == 2 {
		return int(math.Max(float64(nums[0]), float64(nums[1])))
	} else if len(nums) == 3 {
		return int(math.Max(float64(nums[0]+nums[2]), float64(nums[1])))
	}

	f1 := rob(nums[2:]) + nums[0]
	f2 := rob(nums[3:]) + nums[1]

	data := int(math.Max(float64(f1), float64(f2)))

	d[numsS] = data

	return data
}

func TestT(t *testing.T) {
	assert.Equal(t, 7, rob([]int{4, 2, 3}))
	assert.Equal(t, 3, rob([]int{1, 3, 1}))
	assert.Equal(t, 2, rob([]int{1, 1, 1, 1}))
}
```