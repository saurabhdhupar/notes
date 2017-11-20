> https://leetcode.com/problems/minimum-index-sum-of-two-lists/description/

Suppose Andy and Doris want to choose a restaurant for dinner, and they both have a list of favorite restaurants represented by strings.

You need to help them find out their **common interest** with the **least list index sum**. If there is a choice tie between answers, output all of them with no order requirement. You could assume there always exists an answer.

Example 1:
```
Input:
["Shogun", "Tapioca Express", "Burger King", "KFC"]
["Piatti", "The Grill at Torrey Pines", "Hungry Hunter Steakhouse", "Shogun"]
Output: ["Shogun"]
Explanation: The only restaurant they both like is "Shogun".
```
Example 2:
```
Input:
["Shogun", "Tapioca Express", "Burger King", "KFC"]
["KFC", "Shogun", "Burger King"]
Output: ["Shogun"]
Explanation: The restaurant they both like and have the least index sum is "Shogun" with index sum 1 (0+1).
```
Note:
- The length of both lists will be in the range of [1, 1000].
- The length of strings in both lists will be in the range of [1, 30].
- The index is starting from 0 to the list length minus 1.
- No duplicates in both lists.

- 问题
  - 给两个字符串数组，其中有一些数据重复，找出这些重复的数据，返回他们的下标的和位最小值的字符串数组
- 思考
  - 用哈希

```go
package main

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func findRestaurant(list1 []string, list2 []string) []string {
	var m = make(map[string]int)
	for k, v := range list1 {
		m[v] = k
	}

	min := -1
	tmp := 0
	var n = make(map[int][]string)
	for k, v := range list2 {
		if k2, ok := m[v]; ok {
			tmp = k + k2
			if min == -1 || tmp < min {
				min = tmp
			}

			if _, ok := n[tmp]; ok {
				n[tmp] = append(n[tmp], v)
			} else {
				n[tmp] = []string{v}
			}
		}
	}

	return n[min]
}

func TestT(t *testing.T) {
	assert.Equal(t, []string{"Shogun"}, findRestaurant([]string{"Shogun", "Tapioca Express", "Burger King", "KFC"}, []string{"Piatti", "The Grill at Torrey Pines", "Hungry Hunter Steakhouse", "Shogun"}))
}
```