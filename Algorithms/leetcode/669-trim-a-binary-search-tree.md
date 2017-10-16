> https://leetcode.com/problems/trim-a-binary-search-tree/description/

Given a binary search tree and the lowest and highest boundaries as `L` and `R`, trim the tree so that all its elements lies in `[L, R]` (R >= L). You might need to change the root of the tree, so the result should return the new root of the trimmed binary search tree.

Example 1:
```
Input: 
    1
   / \
  0   2

  L = 1
  R = 2

Output: 
    1
      \
       2
```
Example 2:
```
Input: 
    3
   / \
  0   4
   \
    2
   /
  1

  L = 1
  R = 3

Output: 
      3
     / 
   2   
  /
 1
```

- 是一个二叉搜索树，所以左边小于父节点，右边大于父节点
- 所以一旦父节点不在这个范围，肯定有一边就可以抛弃了
- 解决了父节点的问题后，剩下的就是左右子树的老套路了