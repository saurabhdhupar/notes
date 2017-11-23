> https://leetcode.com/problems/next-greater-element-i/description/

You are given two arrays (without duplicates) `nums1` and `nums2` where `nums1`’s elements are subset of `nums2`. Find all the next greater numbers for `nums1`'s elements in the corresponding places of `nums2`.

The Next Greater Number of a number x in nums1 is the first greater number to its right in nums2. If it does not exist, output -1 for this number.

Example 1:
```
Input: nums1 = [4,1,2], nums2 = [1,3,4,2].
Output: [-1,3,-1]
Explanation:
    For number 4 in the first array, you cannot find the next greater number for it in the second array, so output -1.
    For number 1 in the first array, the next greater number for it in the second array is 3.
    For number 2 in the first array, there is no next greater number for it in the second array, so output -1.
```
Example 2:
```
Input: nums1 = [2,4], nums2 = [1,2,3,4].
Output: [3,-1]
Explanation:
    For number 2 in the first array, the next greater number for it in the second array is 3.
    For number 4 in the first array, there is no next greater number for it in the second array, so output -1.
```
Note:
- All elements in nums1 and nums2 are unique.
- The length of both nums1 and nums2 would not exceed 1000.

- 先建一个哈希表，存储长数组，v是index
- 然后遍历小数组，对于每一个数，看看是不是在哈希表里面，并且其后面有大于其本身的

```go
func nextGreaterElement(findNums []int, nums []int) []int {
	set := make(map[int]int, 0)
	for k, v := range nums {
		set[v] = k + 1
	}

	r := []int{}
	for _, v := range findNums {
		mingzhong := false
		if indexPlusOne, ok := set[v]; ok {
			indexPlusOnePlusOne := indexPlusOne
			for indexPlusOnePlusOne < len(nums) {
				if nums[indexPlusOne-1] < nums[indexPlusOnePlusOne] {
					r = append(r, nums[indexPlusOnePlusOne])
					mingzhong = true
					break
				}
				indexPlusOnePlusOne++
			}
		}
		if !mingzhong {
			r = append(r, -1)
		}
	}
	return r
}
```