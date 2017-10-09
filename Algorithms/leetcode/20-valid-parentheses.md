> https://leetcode.com/problems/valid-parentheses/description/

Given a string containing just the characters `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`, determine if the input string is valid.

The brackets must close in the correct order, `"()"` and `"()[]{}"` are all valid but `"(]"` and `"([)]"` are not.

```python
class Solution(object):
    def isValid(self, s):
        """
        :type s: str
        :rtype: bool
        """
        l = []
        for i in s:
            if i in '({[':
                l.append(i)
            elif i in ')}]':
                if l == []:
                    return False
                if i == ')' and l[-1] == '(':
                    l.pop()
                elif i == '}' and l[-1] == '{':
                    l.pop()
                elif i == ']' and l[-1] == '[':
                    l.pop()
                else:
                    return False
            else:
                return False
        return l == []


if __name__ == '__main__':
    assert Solution().isValid('[]{}[]]') == False
    assert Solution().isValid('([)]') == False
    assert Solution().isValid('(])') == False
```