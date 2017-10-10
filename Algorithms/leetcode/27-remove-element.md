> https://leetcode.com/problems/remove-element/description/

Given an array and a value, remove all instances of that value in place and return the new length.

Do not allocate extra space for another array, you must do this in place with constant memory.

The order of elements can be changed. It doesn't matter what you leave beyond the new length.

Example:
Given input array nums = `[3,2,2,3]`, val = `3`

Your function should return length = 2, with the first two elements of nums being 2.

- 和26一样
- 使用i表示非目标元素的数据游标，使用j对数组遍历
- 遍历数组，将不等于目标元素的数据移动到数组前面，位置由i确定
- 另外一种方法就是「等于目标元素的数据」，i要从后往前变

```python
class Solution(object):
    def removeElement(self, nums, val):
        """
        :type nums: List[int]
        :type val: int
        :rtype: int
        """

        i = 0
        for j in range(len(nums)):
            if nums[j] != val:
                nums[i] = nums[j]
                i += 1
        return i


if __name__ == '__main__':
    for array_source, ele, array_target, n in [
        [[3, 2, 2, 3], 3, [2, 2], 2],
        [[1, 1, 1, 1, 1, 1], 1, [], 0],
        [[], 1, [], 0]
    ]:
        data = Solution().removeElement(array_source, ele)
        assert array_source[:n] == array_target
        assert data == n
```