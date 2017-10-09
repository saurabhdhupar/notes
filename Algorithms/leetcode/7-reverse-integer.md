> https://leetcode.com/problems/reverse-integer/description/

Reverse digits of an integer.

Example1: x = 123, return 321
Example2: x = -123, return -321

Have you thought about this?
Here are some good questions to ask before coding. Bonus points for you if you have already thought through this!

If the integer's last digit is 0, what should the output be? ie, cases such as 10, 100.

Did you notice that the reversed integer might overflow? Assume the input is a 32-bit integer, then the reverse of 1000000003 overflows. How should you handle such cases?

For the purpose of this problem, assume that your function returns 0 when the reversed integer overflows.

Note:
The input is assumed to be a 32-bit signed integer. Your function should return 0 when the reversed integer overflows.

- 数字获取后N位，对10*N取余即可（获取最后一位，对10取余）
- 有符号整数范围   *- 2 ** (N-1) ~ 2 ** (N-1) - 1*
- 无符号整数范围   *0 ~ 2 ** N - 1*
- 整数溢出注意判断上界和下届

```python
class Solution(object):
    f = False

    def over(self, n):
        if self.f:
            return -n < -2 ** 31
        else:
            return n > 2 ** 31 - 1

    def reverse(self, x):
        """
        :type x: int
        :rtype: int
        """
        if x < 0:
            self.f = True
            x = -x

        r = 0

        while True:
            y = x % 10
            x = x // 10
            r = 10 * r + y
            if self.over(r):
                return 0

            if x == 0:
                break

        if self.f:
            r = -r
        return r


if __name__ == '__main__':
    assert Solution().reverse(123) == 321
    assert Solution().reverse(-123) == -321
    assert Solution().reverse(1000000003) == 0
    assert Solution().reverse(-2147483648) == 0
    assert Solution().reverse(100) == 1

```