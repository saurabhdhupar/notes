> https://leetcode.com/problems/add-binary/description/

Given two binary strings, return their sum (also a binary string).

For example,
a = "11"
b = "1"
Return "100".

* 求两个二进制的字符串的和（67）
  * i和j分别指向两个二进制字符串的最后一个元素，然后 `for i >= 0 && j >= 0 { ... }`这样循环
  * 需要一个额外的变量t存储是否进位，0或者1，每次加的时候都要加上t
  * 每次加完后需要判断是否大于1（二进制进位），然后处理一下进位
  * 最后可能还有一个字符串没有处理完，再处理一下
  * 二进制进位：s整除2的商 s除以2的余数

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
            m = '1' + m

        return m


if __name__ == '__main__':
    assert Solution().addBinary('11', '1') == '100'
    assert Solution().addBinary('1111', '1111') == 11110
```