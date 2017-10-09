> https://leetcode.com/problems/longest-common-prefix/description/

Write a function to find the longest common prefix string amongst an array of strings.


- 横向扫描

![](https://leetcode.com/media/original_images/14_basic.png)

```python
class Solution(object):
    def longestCommonPrefix(self, strs):
        """
        :type strs: List[str]
        :rtype: str
        """
        if len(strs) == 0:
            return ''

        pre = strs[0]

        i = 1
        while i < len(strs):
            while strs[i].find(pre) != 0:
                pre = pre[:-1]
            i += 1
        return pre


if __name__ == '__main__':
    assert Solution().longestCommonPrefix(['c', 'acc', 'ccc']) == ''
    assert Solution().longestCommonPrefix(['aa1', 'aa2']) == 'aa'
    assert Solution().longestCommonPrefix(['abba1', 'abab2']) == 'ab'
    assert Solution().longestCommonPrefix([]) == ''
```

- 二叉搜索

![](https://leetcode.com/media/original_images/14_lcp_binary_search.png)

```python
class Solution(object):
    def isCommonPrefix(self, strs, length):
        s = strs[0][:length]
        for str in strs:
            if not str.startswith(s):
                return False
        return True

    def longestCommonPrefix(self, strs):
        """
        :type strs: List[str]
        :rtype: str
        """
        if len(strs) == 0:
            return ''

        low = 1
        high = len(min(strs, key=lambda x: len(x)))

        while low <= high:
            mid = (low + high) // 2
            if self.isCommonPrefix(strs, mid):
                low = mid + 1
            else:
                high = mid - 1

        return strs[0][:(low + high) // 2]
```