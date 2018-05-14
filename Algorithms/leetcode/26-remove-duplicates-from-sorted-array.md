> https://leetcode.com/problems/remove-duplicates-from-sorted-array/description/


Given a sorted array, remove the duplicates in place such that each element appear only once and return the new length.

Do not allocate extra space for another array, you must do this in place with constant memory.

For example,
Given input array nums = `[1,1,2]`,

Your function should return length = `2`, with the first two elements of nums being `1` and `2` respectively. It doesn't matter what you leave beyond the new length.

- 去除已排序数组的重复元素，返回不重复的个数N，原数组经过操作后，前N项需要就是那几个非重复的元素（不能使用额外的数组，必须操作原来的数组）
- 考虑下标i,j，j来扫描数组，i作为非重复数组的最后一个元素的游标
- 为了满足前i个都是非重复的，需要把后面的非重复元素赋值给前面的重复的元素


```python
class Solution(object):
    def removeDuplicates(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        if not nums:
            return 0

        i = 0
        for j in range(1, len(nums)):
            if nums[i] != nums[j]:
                i += 1
                nums[i] = nums[j]
        return i + 1


if __name__ == '__main__':
    for a, b, n in [
        [[1, 1, 2], [1, 2], 2],
        [[1, 1, 1, 1, 1, 1], [1], 1],
        [[1, 2, 3, 4, 4, 5], [1, 2, 3, 4, 5], 5],
        [[], [], 0]
    ]:
        data = Solution().removeDuplicates(a)
        assert a[:n] == b
        assert data == n
```