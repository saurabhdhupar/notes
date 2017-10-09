> https://leetcode.com/problems/longest-substring-without-repeating-characters/description/

Given a string, find the length of the longest substring without repeating characters.

Examples:

Given "abcabcbb", the answer is "abc", which the length is 3.

Given "bbbbb", the answer is "b", with the length of 1.

Given "pwwkew", the answer is "wke", with the length of 3. Note that the answer must be a substring, "pwke" is a subsequence and not a substring.

思路

搞一个i,j分别指向最长字符串的首尾，然后将i和j之间的字符存在一个hashTable里面

```python
def longest_string(s):
    lonest_s = set()
    lonest_l = 0

    i, j = 0, 0
    while i < len(s) and j < len(s):
        if s[j] not in lonest_s:
            lonest_s.add(s[j])
            j += 1
            lonest_l = max(lonest_l, j - i)
        else:
            lonest_s.remove(s[i])
            i += 1

    return lonest_l


if __name__ == '__main__':
    for s, l in [('abcabcbb', 3), ('bbbbb', 1), ('pwwkew', 3)]:
        assert longest_string(s) == l

    print('ok')
```