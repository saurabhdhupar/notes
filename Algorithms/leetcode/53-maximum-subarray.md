> https://leetcode.com/problems/maximum-subarray/description/

Find the contiguous subarray within an array (containing at least one number) which has the largest sum.

For example, given the array `[-2,1,-3,4,-1,2,1,-5,4]`,
the contiguous subarray `[4,-1,2,1]` has the largest sum = `6`.

More practice:
If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.


参见：https://github.com/Chyroc/blog/issues/21

- 如果一个子数组的和小于0，那么这个数组的最后一个元素肯定小于0
- 所以就对后面的和计算无益，可以舍去整个数组

