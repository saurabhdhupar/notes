> https://leetcode.com/problems/add-binary/description/

Given two binary strings, return their sum (also a binary string).

For example,
a = "11"
b = "1"
Return "100".

- 常见的两个数组扫描
- 先用i,j扫描公共的长度
- 然后 while i > 0 的时候扫描那个没有完成的数组
- 二进制进位：s//2 s%2

```python
class Solution(object):
    def addBinary(self, a, b):
        """
        :type a: str
        :type b: str
        :rtype: str
        """
        i = len(a) - 1
        j = len(b) - 1
        t = 0
        m = ''

        while i >= 0 and j >= 0:
            s = int(a[i]) + int(b[j]) + t
            if s > 1:
                m = str(s % 2) + m
                t = s // 2
            else:
                m = str(s) + m
                t = 0

            i -= 1
            j -= 1

        while i >= 0:
            s = int(a[i]) + t
            if s == 2:
                m = str(s % 2) + m
                t = s // 2
            else:
                m = str(s) + m
                t = 0

            i -= 1

        while j >= 0:
            s = int(b[j]) + t
            if s == 2:
                m = str(s % 2) + m
                t = s // 2
            else:
                m = str(s) + m
                t = 0

            j -= 1

        if t == 1:
            m = str(t) + m

        return m


if __name__ == '__main__':
    assert Solution().addBinary('11', '1') == '100'
    assert Solution().addBinary('1111', '1111') == 11110
```