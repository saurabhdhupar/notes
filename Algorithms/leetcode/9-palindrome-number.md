> https://leetcode.com/problems/palindrome-number/description/

Determine whether an integer is a palindrome. Do this without extra space.

Some hints:
Could negative integers be palindromes? (ie, -1)

If you are thinking of converting the integer to string, note the restriction of using extra space.

You could also try reversing an integer. However, if you have solved the problem "Reverse Integer", you know that the reversed integer might overflow. How would you handle such case?

There is a more generic way of solving this problem.

- 负数不是回文数
- 0是回文数
- 可能有溢出（如果做过第7题很好理解）


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

    def isPalindrome(self, x):
        """
        :type x: int
        :rtype: bool
        """
        if x == 0:
            return True
        if x < 0:
            return False

        return x == self.reverse(x)


if __name__ == '__main__':
    assert Solution().isPalindrome(123) == False
    assert Solution().isPalindrome(1000000003) == False
    assert Solution().isPalindrome(0) == True
    assert Solution().isPalindrome(-2147447412) == False
```