> https://leetcode.com/problems/implement-strstr/solution/


Implement strStr().

Returns the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

```python
class Solution(object):
    def strStr(self, haystack, needle):
        """
        :type haystack: str
        :type needle: str
        :rtype: int
        """
        needle_len = len(needle)

        for k in range(len(haystack) - needle_len + 1):
            if haystack[k:k + needle_len] == needle:
                return k

        return -1


if __name__ == '__main__':
    assert Solution().strStr("", "") == 0
    assert Solution().strStr("a", "") == 0
    assert Solution().strStr("a", "a") == 0
    assert Solution().strStr("aaa", "aa") == 0
    assert Solution().strStr("mississippi", "pi") == 9
```