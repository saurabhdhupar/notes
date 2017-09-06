> https://leetcode.com/problems/two-sum/description/

Given an array of integers, return indices of the two numbers such that they add up to a specific target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

Example.
```
Given nums = [2, 7, 11, 15], target = 9,

Because nums[0] + nums[1] = 2 + 7 = 9,
return [0, 1].
```

```go
package main

import "fmt"

func func1(nums []int, target int) []int {
	for i := 0; i < len(nums); i++ {
		for j := i + 1; j < len(nums); j++ {
			if nums[i]+nums[j] == target {
				return []int{i, j}
			}
		}
	}
	return []int{}
}

func func2(nums []int, target int) []int {
	var mapInt = make(map[int]int, len(nums))
	for i := 0; i < len(nums); i++ {
		mapInt[nums[i]] = i
	}

	for i := 0; i < len(nums); i++ {
		if j, ok := mapInt[target-nums[i]]; ok && i != j {
			return []int{i, j}
		}
	}

	return []int{}
}

func func3(nums []int, target int) []int {
	var mapInt = make(map[int]int, len(nums))
	for i := 0; i < len(nums); i++ {
		if j, ok := mapInt[target-nums[i]]; ok {
			return []int{i, j}
		}
		mapInt[nums[i]] = i
	}

	return []int{}
}

func main() {
	fmt.Println(func1([]int{2, 7, 11, 15}, 9))
	fmt.Println(func2([]int{2, 7, 11, 15}, 9))
	fmt.Println(func3([]int{2, 7, 11, 15}, 9))
}

```
