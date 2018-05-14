> https://leetcode.com/problems/merge-sorted-array/description/


Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.

Note:
You may assume that nums1 has enough space (size that is greater or equal to m + n) to hold additional elements from nums2. The number of elements initialized in nums1 and nums2 are m and n respectively.


* 合并两个已经排序的数组，结果需要保存到第一个数组（即原地操作）
  * 需要从数组后面往前面操作，不能反过来。因为，后面的空间是空的；前面的空间是有数字的，所以从前往后的话，会覆盖数据
  * i和j分别指向两个数组的最后一个元素，k指向第一个数组的m+n-1位置，即合并后的数组长度的最后一位
  * 假设数组是递增的，比较i和j指向的元素，然后把较大值放在m上
  * 使用类似 `for i>=0 && j>=0 { ... i-- or j-- }` 的方式遍历数组
  * 最后还可能会有一个数组有数据（i>0或者j>0），把数据依次加到第一个数组上
    * 疑问：如果是i还有2个数据，那么还需要加吗？

```go
func merge(nums1 []int, m int, nums2 []int, n int) {
	var (
		i = m - 1
		j = n - 1
		k = m + n - 1
	)

	for i >= 0 && j >= 0 {
		if nums1[i] > nums2[j] {
			nums1[k] = nums1[i]
			i--
		} else {
			nums1[k] = nums2[j]
			j--
		}
		k--
	}

	for i >= 0 {
		nums1[k] = nums1[i]
		i--
		k--
	}

	for j >= 0 {
		nums1[k] = nums2[j]
		j--
		k--
	}

}
```