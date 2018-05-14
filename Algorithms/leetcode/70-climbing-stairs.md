> https://leetcode.com/problems/climbing-stairs/description/

You are climbing a stair case. It takes n steps to reach to the top.

Each time you can either climb 1 or 2 steps. In how many distinct ways can you climb to the top?

Note: Given n will be a positive integer.

* 动态规划
* 有n级台阶，一次可以走1步或者2步，求一共有多少种方法（70）
  * 1级台阶，答案1：（1）
  * 2级台阶，答案2：（1-1），（2）
  * 3级以上台阶
    * 先走1步，剩下的答案是f(n-1)
    * 先走2步，剩下的答案是f(n-2)
  * 注意使用缓存存储已经计算的答案

```python
class Solution(object):
    cache = {}

    def climbStairs(self, n):
        """
        :type n: int
        :rtype: int
        """
        if n in self.cache:
            return self.cache[n]

        if n <= 2:
            self.cache[n] = n
        else:
            self.cache[n] = self.climbStairs(n - 1) + self.climbStairs(n - 2)

        return self.cache[n]


if __name__ == '__main__':
    assert Solution().climbStairs(1) == 1
    assert Solution().climbStairs(2) == 2
    assert Solution().climbStairs(3) == 3
```