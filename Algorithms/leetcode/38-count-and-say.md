> https://leetcode.com/problems/count-and-say/description/


The count-and-say sequence is the sequence of integers with the first five terms as following:

```
1.     1
2.     11
3.     21
4.     1211
5.     111221
```

`1` is read off as `"one 1"` or `11`.
`11` is read off as `"two 1s"` or `21`.
`21` is read off as `"one 2, then one 1"` or `1211`.
Given an integer n, generate the nth term of the count-and-say sequence.

Note: Each term of the sequence of integers will be represented as a string.

Example 1:
```
Input: 1
Output: "1"
```

Example 2:
```
Input: 4
Output: "1211"
```

- 扫描数字的字符串，统一连续相同的数字的个数

```python
class Solution(object):
    def ss(self, s):
        i = 0
        new_s = ''
        count = 1
        flag = 0
        while i < len(s) - 1:
            if s[i] == s[i + 1]:
                count += 1
                flag = 0
            else:
                new_s = '{}{}{}'.format(new_s, count, s[i])
                count = 1
                flag = 1
            i += 1

        if flag == 0:
            new_s = '{}{}{}'.format(new_s, count, s[i])
        else:
            new_s = '{}{}{}'.format(new_s, 1, s[i])

        return new_s

    def countAndSay(self, n):
        """
        :type n: int
        :rtype: str
        """

        s = '1'

        while n > 1:
            s = self.ss(s)
            n -= 1

        return s
```