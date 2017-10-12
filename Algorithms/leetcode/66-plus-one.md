> https://leetcode.com/problems/plus-one/description/

Given a non-negative integer represented as a non-empty array of digits, plus one to the integer.

You may assume the integer do not contain any leading zero, except the number 0 itself.

The digits are stored such that the most significant digit is at the head of the list.

- 用数组表示整数，除了0本身，不会有前置0
- 把这个数组表示的整数加1返回，仍然用数组形式表示

```python
class Solution(object):
    def plusOne(self, digits):
        """
        :type digits: List[int]
        :rtype: List[int]
        """

        d = 0
        for i in digits:
            d = d * 10 + i
        d = d + 1

        r = []
        while d >= 10:
            a, b = d // 10, d % 10
            r.append(b)
            d = a
        r.append(d)

        r.reverse()
        return r


if __name__ == '__main__':
    assert Solution().plusOne([0]) == [1]
    assert Solution().plusOne([9]) == [1, 0]
    assert Solution().plusOne([1, 0]) == [1, 1]
    assert Solution().plusOne([9, 9]) == [1, 0, 0]
```