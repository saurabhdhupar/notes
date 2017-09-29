> https://github.com/yangshun/tech-interview-handbook/master/algorithms/README.md

算法问题
==

This section dives deep into practical tips for specific topics of algorithms and data structures which appear frequently in coding questions. Many algorithm questions involve techniques that can be applied to questions of similar nature. The more techniques you have in your arsenal, the higher the chances of passing the interview. They may lead you to discover corner cases you might have missed out or even lead you towards the optimal approach!

For each topic, there is also a list of recommended common questions which in my opinion is highly valuable for mastering the core concepts for the topic.

## Contents 目录

- [Array](array.md)
- [Dynamic Programming and Memoization](dynamic-programming.md)
- [Geometry](geometry.md)
- [Graph](graph.md)
- [Hash Table](hash-table.md)
- [Heap](heap.md)
- [Interval](interval.md)
- [Linked List](linked-list.md)
- [Math](math.md)
- [Matrix](matrix.md)
- [Object-Oriented Programming](oop.md)
- [Permutation](permutation.md)
- [Queue](queue.md)
- [Sorting and Searching](sorting-searching.md)
- [Stack](stack.md)
- [String](string.md)
- [Tree](tree.md)

## General Tips

- 输入校验:
  - 永远记得校验输入参数。检查不合法 / 空的 / 负数 / 不同输入类型。永远不要假设输入参数是合法的。要么就假设输入参数都是正确的，这样就简化了工作量。
- 有没有时间复杂度和空间复杂度的要求和限制？
- 检查核心问题:
  - 检查 off-by-one 错误.
  - 在没有动态类型的语言里面，检查类型是否一致: `int`/`str`/`list`。
  - 写完代码后，用一些测试用例测试一下。
- Is the algorithm meant to be run multiple times, for example in a web server? If yes, the input is likely to be preprocess-able to improve the efficiency in each call.
- 使用函数式和命令式编程来搞：
  - 进行使用纯函数
  - 纯函数可以帮你减少bug。
  - 避免在函数里改变参数，即使这个参数是引用传递的。除非你很确定你在做什么。
  - However, functional programming is usually expensive in terms of space complexity because of non-mutation and the repeated allocation of new objects. On the other hand, imperative code is faster because you operate on existing objects. Hence you will need to achieve a balance between accuracy vs efficiency, by using the right amount of functional and imperative code where appropriate.
  - Avoid relying on and mutating global variables. Global variables introduce state.
  - If you have to rely on global variables, make sure that you do not mutate it by accident.
- Generally, to improve the speed of a program, we can either choose a more appropriate data structure/algorithm or use more memory. It's a classic space/time tradeoff.
- Data structures are your weapons. Choosing the right weapon for the right battle is the key to victory. Be very familiar about the strengths of each data structure and the time complexities for its various operations.
- Data structures can be augmented to achieve efficient time complexities across different operations. For example, a hash map can be used together with a doubly-linked list to achieve O(1) time complexity for both the `get` and `put` operation in an [LRU cache](https://leetcode.com/problems/lru-cache/).
- Hashmaps are probably the most commonly used data structure for algorithm questions. If you are stuck on a question, your last resort can be to enumerate through the possible data structures (thankfully there aren't that many of them) and consider whether each of them can be applied to the problem. This has worked for me sometimes.
- If you are cutting corners in your code, state that out loud to your interviewer and say what you would do in a non-interview setting (no time constraints). E.g., I would write a regex to parse this string rather than using `split()` which does not cover all cases.

## Sequence 序列

- 数组和字符串被认为是序列 (字符串是字符的序列)。 There are tips relevant for dealing with both arrays and strings which will be covered here.
- 如果序列里面有重复的元素，会影响结果吗？
- 检查序列的范围。
- Be mindful about slicing or concatenating sequences in your code. Typically, slicing and concatenating sequences require O(n) time. Use start and end indices to demarcate a subarray/substring where possible.
- Sometimes you can traverse the sequence from the right rather than from the left.
- Master the [sliding window technique](https://discuss.leetcode.com/topic/30941/here-is-a-10-line-template-that-can-solve-most-substring-problems) that applies to many substring/subarray problems.
- When you are given two sequences to process, it is common to have one index per sequence to traverse/compare the both of them. For example, we use the same approach to merge two sorted arrays.
- Corner cases:
  - Empty sequence.
  - Sequence with 1 or 2 elements.
  - Sequence with repeated elements.

## Array 数组

- 数组排序或者部分排序了吗？如果是的，可以使用某种形式的二叉树搜索。这经常意味着，这道题就是为了考一个快于 O(n)的解法。
- 你能排序数组吗？有时候先把数组排序可以简化问题。确认排序之前不需要保存数组的书序。
- For questions where summation or multiplication of a subarray is involved, pre-computation using hashing or a prefix/suffix sum/product might be useful.
- 如果给了一个序列给你，然后要求O(1)的空间复杂度，也许可以使用数组他本身作为哈希表。例如，如果数组只有1到N的元素，N是数组的长度，干掉该索引上的元素（使其减1）来表明该元素的存在。

#### Practice Questions

- [Two Sum](https://leetcode.com/problems/two-sum/)
- [Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)
- [Contains Duplicate](https://leetcode.com/problems/contains-duplicate/)
- [Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/)
- [Maximum Subarray](https://leetcode.com/problems/maximum-subarray/)
- [Maximum Product Subarray](https://leetcode.com/problems/maximum-product-subarray/)
- [Find Minimum in Rotated Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)
- [Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array/)
- [3Sum](https://leetcode.com/problems/3sum/)
- [Container With Most Water](https://leetcode.com/problems/container-with-most-water/)

## Binary 二进制

- 有时会询问涉及二进制表示和按位操作的问题，必须绝对熟悉数字从在十进制和二进制之间相互转化。
- Test k<sup>th</sup> bit is set: `num & (1 << k) != 0`.
- Set k<sup>th</sup> bit: `num |= (1 << k)`.
- Turn off k<sup>th</sup> bit: `num &= ~(1 << k)`.
- Toggle the k<sup>th</sup> bit: `num ^= (1 << k)`.
- To check if a number is a power of 2, `num & num - 1 == 0`.

#### Practice Questions

- [Sum of Two Integers](https://leetcode.com/problems/sum-of-two-integers/)
- [Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits/)
- [Counting Bits](https://leetcode.com/problems/counting-bits/)
- [Missing Number](https://leetcode.com/problems/missing-number/)
- [Reverse Bits](https://leetcode.com/problems/reverse-bits/)

## Dynamic Programming 动态规划

- 通常用来解决优化问题。
- 阿拉尼亚·卡夫斯（Alaina Kafkes）在处理DP问题上写了一个令人敬畏的[帖子](https://medium.freecodecamp.org/demystifying-dynamic-programming-3efafb8d4296)。
- 在DP上得到更好的唯一办法就是练习。能够认识到DP可以解决问题需要一些实践。
- 有时您不需要将整个DP表存储在内存中，最后两个值或矩阵的最后两行就足够了。

#### Practice Questions

- 0/1 Knapsack
- [Climbing Stairs](https://leetcode.com/problems/climbing-stairs/)
- [Coin Change](https://leetcode.com/problems/coin-change/)
- [Longest Increasing Subsequence](https://leetcode.com/problems/longest-increasing-subsequence/)
- [Longest Common Subsequence]()
- [Word Break Problem](https://leetcode.com/problems/word-break/)
- [Combination Sum](https://leetcode.com/problems/combination-sum-iv/)
- [House Robber](https://leetcode.com/problems/house-robber/) and [House Robber II](https://leetcode.com/problems/house-robber-ii/)
- [Decode Ways](https://leetcode.com/problems/decode-ways/)
- [Unique Paths](https://leetcode.com/problems/unique-paths/)
- [Jump Game](https://leetcode.com/problems/jump-game/)

## Geometry 几何

- 当比较两对点之间的欧氏距离时，使用 dx<sup>2</sup> + dy<sup>2</sup> 就足够了。没有必要对该值进行平方根。
- 要确定两个圆是否重叠，请检查圆的两个中心之间的距离是否小于其半径的总和。

## Graph 图

- 熟悉各种图表示，图搜索算法及其时间和空间复杂性。
- 您可以给出一个边（edges）列表，并从边缘构建自己的图形，执行遍历。公共图表示是：
  - 邻接矩阵
  - 邻接列表
  - 哈希图的哈希图
- 一些问题看起来像是树，但它们实际上是图。在这种情况下，您将不得不处理循环，并在遍历时保留一组被访问的节点。
- 图形搜索算法：
  - 普通 - 宽度优先搜索，深度优先搜索
  - 不常见 - 拓扑排序，Dijkstra算法罕见 - 贝尔曼 - 
  - 福特算法，Floyd-Warshall算法，Prim算法，Kruskal算法
- Graph search algorithms:
  - **Common** - 广度优先搜索（Breadth-first Search），深度优先搜索（Depth-first Search）
  - **Uncommon** - 拓扑排序（Topological Sort），Dijkstra's 算法
  - **Rare** - Bellman-Ford 算法, Floyd-Warshall 算法, Prim's 算法, Kruskal's 算法
- 在面试中，图通常表示为2-D矩阵，其中单元是节点，每个单元可以遍历其相邻单元（上/下/左/右）。因此，您必须熟悉遍历二维矩阵。当递归地遍历矩阵时，始终确保您的下一个位置在矩阵的边界内。有关在矩阵上进行深度优先搜索的更多提示可以在[这里](https://discuss.leetcode.com/topic/66065/python-dfs-bests-85-tips-for-all-dfs-in-matrix-question/)找到。在矩阵上进行深度优先搜索的简单模板如下所示：

```py
def traverse(matrix):
  rows, cols = len(matrix), len(matrix[0])
  visited = set()
  directions = ((0, 1), (0, -1), (1, 0), (-1, 0))
  def dfs(i, j):
    if (i, j) in visited:
      return
    visited.add((i, j))
    # Traverse neighbors
    for direction in directions:
      next_i, next_j = i + direction[0], j + direction[1]
      if 0 <= next_i < rows and 0 <= next_j < cols: # Check boundary
        # Add any other checking here ^
        dfs(next_i, next_j)

  for i in range(rows):
    for j in range(cols):
      dfs(i, j)
```

- Corner cases:
  - 空图.
  - 有一个或两个节点的图.
  - 不想交图.
  - 循环图.

#### Practice Questions

- [Clone Graph](https://leetcode.com/problems/clone-graph/)
- [Course Schedule](https://leetcode.com/problems/course-schedule/)
- [Alien Dictionary](https://leetcode.com/problems/alien-dictionary/)
- [Pacific Atlantic Water Flow](https://leetcode.com/problems/pacific-atlantic-water-flow/)
- [Number of Islands](https://leetcode.com/problems/number-of-islands/)
- [Graph Valid Tree](https://leetcode.com/problems/graph-valid-tree/)
- [Number of Connected Components in an Undirected Graph](https://leetcode.com/problems/number-of-connected-components-in-an-undirected-graph/)
- [Longest Consecutive Sequence](https://leetcode.com/problems/longest-consecutive-sequence/)

## Interval 间隔

- Interval 问题是一个问题，您将获得一个双元素数组（一个 Interval ）的数组，两个值表示一个起始值和一个结束值。Interval 问题被认为是数组问题的一种，但是它们涉及到一些常见的技术，因此它们被提取出来到它们自己的这个特殊部分
- 一个 interval 数组例子: `[[1, 2], [4, 7]]`
- 对于那些以前没有尝试过的人来说，Interval 问题可能是棘手的，因为the sheer number of cases to consider when they overlap
- 对面试官进行搞清楚，`[1,2]` 和 `[2,3]` 是否属于这个问题，因为它会影响你如何写出你的相等检查。
- Interval 问题的常见例程是按每个间隔的起始值排列间隔数组。
- 熟悉编写代码以检查两个间隔是否重叠 / 合并两个重叠间隔：

```py
def is_overlap(a, b):
  return a[0] < b[1] and b[0] < a[1]

def merge_overlapping_intervals(a, b):
  return [min(a[0], b[0]), max(a[1], b[1])]
```

- Corner cases:
  - 一个 interval
  - 无重叠 intervals
  - 一个包含另外一个
  - 重复 intervals

#### Practice Questions

- [Insert Interval](https://leetcode.com/problems/insert-interval/)
- [Merge Intervals](https://leetcode.com/problems/merge-intervals/)
- [Meeting Rooms](https://leetcode.com/problems/meeting-rooms/) and [Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii/)
- [Non-overlapping Intervals](https://leetcode.com/problems/non-overlapping-intervals/)

## Linked List

- Like arrays, linked lists are used to represent sequential data. The benefit of linked lists is that insertion and deletion from anywhere in the list is O(1) whereas in arrays the following elements will have to be shifted.
- Adding a dummy node at the head and/or tail might help to handle many edge cases where operations have to be performed at the head or the tail. The presence of dummy nodes essentially ensures that operations will never have be done on the head or the tail, thereby removing a lot of headache in writing conditional checks to dealing with null pointers. Be sure to remember to remove them at the end of the operation.
- Sometimes linked lists problem can be solved without additional storage. Try to borrow ideas from reverse a linked list problem.
- For deletion in linked lists, you can either modify the node values or change the node pointers. You might need to keep a reference to the previous element.
- For partitioning linked lists, create two separate linked lists and join them back together.
- Linked lists problems share similarity with array problems, think about how you would do it for an array and try to apply it to a linked list.
- Two pointer approaches are also common for linked lists. For example:
  - Getting the k<sup>th</sup> from last node - Have two pointers, where one is k nodes ahead of the other. When the node ahead reaches the end, the other node is k nodes behind.
  - Detecting cycles - Have two pointers, where one pointer increments twice as much as the other, if the two pointers meet, means that there is a cycle.
  - Getting the middle node - Have two pointers, where one pointer increments twice as much as the other. When the faster node reaches the end of the list, the slower node will be at the middle.
- Be familiar with the following routines because many linked list questions make use of one or more of these routines in the solution:
  - Counting the number of nodes in the linked list.
  - Reversing a linked list in-place.
  - Finding the middle node of the linked list using fast/slow pointers.
  - Merging two lists together.
- Corner cases:
  - Single node.
  - Two nodes.
  - Cycle in linked list - Clarify whether there can be a cycle in the list? Usually the answer is no.

#### Practice Questions

- [Reverse a Linked List](https://leetcode.com/problems/reverse-linked-list/)
- [Detect Cycle in a Linked List](https://leetcode.com/problems/linked-list-cycle/)
- [Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)
- [Merge K Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
- [Remove Nth Node From End Of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)
- [Reorder List](https://leetcode.com/problems/reorder-list/)

## Math

- If code involves division or modulo, remember to check for division or modulo by 0 case.
- When a question involves "a multiple of a number", perhaps modulo might be useful.
- Check for and handle overflow/underflow if you are using a typed language like Java and C++. At the very least, mention that overflow/underflow is possible and ask whether you need to handle it.
- Consider negative numbers and floating point numbers. This may sound obvious, but under interview pressure, many obvious cases go unnoticed.
- If the question asks to implement an operator such as power, squareroot or division and want it to be faster than O(n), binary search is usually the approach to go.
- Some common formulas:
  - Sum of 1 to N = (n+1) * n/2
  - Sum of GP = 2<sup>0</sup> + 2<sup>1</sup> + 2<sup>2</sup> + 2<sup>3</sup> + ... 2<sup>n</sup> = 2<sup>n+1</sup> - 1
  - Permutations of N = N! / (N-K)!
  - Combinations of N = N! / (K! * (N-K)!)

#### Practice Questions

- [Pow(x, n)](https://leetcode.com/problems/powx-n/)
- [Sqrt(x)](https://leetcode.com/problems/sqrtx/)
- [Integer to English Words](https://leetcode.com/problems/integer-to-english-words/)

## Matrix

- A matrix is a 2-dimensional array. Questions involving matrices are usually related to dynamic programming or graph traversal.
- Corner cases:
  - Empty matrix. Check that none of the arrays are 0 length.
  - 1 x 1 matrix.
  - Matrix with only one row or column.
- For questions involving traversal or dynamic programming, you almost always want to make a copy of the matrix with the same dimensions that is initialized to empty values to store the visited state or dynamic programming table. Be familiar with such a routine:

```py
rows, cols = len(matrix), len(matrix[0])
copy = [[0 for _ in range(cols)] for _ in range(rows)]
```

- Many grid-based games can be modeled as a matrix, such as Tic-Tac-Toe, Sudoku, Crossword, Connect 4, Battleship, etc. It is not uncommon to be asked to verify the winning condition of the game. For games like Tic-Tac-Toe, Connect 4 and Crosswords, where verification has to be done vertically and horizontally, one trick is to write code to verify the matrix for the horizontal cells, transpose the matrix and reuse the logic for horizontal verification to verify originally vertical cells (which are now horizontal).
- Transposing a matrix in Python is simply:

```py
transposed_matrix = zip(*matrix)
```

#### Practice Questions

- [Set Matrix Zeroes](https://leetcode.com/problems/set-matrix-zeroes/)
- [Spiral Matrix](https://leetcode.com/problems/spiral-matrix/)
- [Rotate Image](https://leetcode.com/problems/rotate-image/)
- [Word Search](https://leetcode.com/problems/word-search/)

## Recursion

- Remember to always define a base case so that your recursion will end.
- Useful for permutation, generating all combinations and tree-based questions.
- Be familiar with how to generate all permutations of a sequence as well as how to handle duplicates.
- Recursion implicitly uses a stack. Hence all recursive approaches can be rewritten iteratively using a stack.
- Beware of cases where the recursion level goes too deep and causes a stack overflow (the default limit in Python is 1000).
- Recursion will never be O(1) space complexity because a stack is involved unless there is [tail-call optimization](https://stackoverflow.com/questions/310974/what-is-tail-call-optimization). Do find out if your chosen language supports tail-call optimization.

#### Practice Questions

- [Subsets](https://leetcode.com/problems/subsets/) and [Subsets II](https://leetcode.com/problems/subsets-ii/)
- [Strobogrammatic Number II](https://leetcode.com/problems/strobogrammatic-number-ii/)

## String

- Please read the above tips on [Sequence](#sequence) because they apply to strings too.
- Corner cases:
  - Strings with only one distinct character.
- Ask about input character set and case sensitivity. Usually the characters are limited to lower case Latin characters, i.e. a-z.
- When you need to compare strings where the order isn't important (like anagram), you may consider using a hash map as a counter. If your language has a built-in `Counter` class like Python, ask to use that instead.
- If you need to keep a counter of characters, a common mistake to make is to say that the space complexity required for the counter is O(n). The space required for a counter is O(1) not O(n), because the upper bound is the range of characters which is usually a fixed constant of 26 when the input set is just lower case Latin characters.
- Common data structures for looking up strings efficiently:
  - [Trie / Prefix Tree](https://en.wikipedia.org/wiki/Trie)
  - [Suffix Tree](https://en.wikipedia.org/wiki/Suffix_tree)
- Common string algorithms:
  - [Rabin Karp](https://en.wikipedia.org/wiki/Rabin%E2%80%93Karp_algorithm) for efficient searching of substring using a rolling hash.
  - [KMP](https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm) for efficient searching of substring.

#### Non-repeating Characters

- Use a 26-bit bitmask to indicate which lower case latin characters are inside the string.

```py
mask = 0
for c in set(word):
  mask |= (1 << (ord(c) - ord('a')))
```

- To determine if two strings have common characters, perform `&` on the two bitmasks and if the result is non-zero, the two strings do have common characters: `mask_a & mask_b > 0`.

#### Anagram

- An anagram is direct word switch or word play, the result of rearranging the letters of a word or phrase to produce a new word or phrase, using all the original letters exactly once. In interviews, usually we are only bothered with words without spaces in them.
- Determine if two strings are anagrams:
  - Sorting both strings should produce the same resulting string.
  - If we map each character to a prime number and we multiply each mapped number together, anagrams should have the same multiple (prime factor decomposition).
  - Frequency counting of characters will help to determine if two strings are anagrams.

#### Palindrome

- A palindrome is a word, phrase, number, or other sequence of characters which reads the same backward as forward, such as madam or racecar.
- Ways to determine if a string is a palindrome:
  - Reverse the string and it should be equal to itself.
  - Have two pointers at the start and end of the string, move inwards till they meet. At any point in time the characters at both pointers should match.
- The order of characters within the string matters, so hash maps are usually not helpful.
- When a question is about counting the number of palindromes, a common trick is to have two pointer that move outwards, away from the middle. Note that palindromes can be even/odd length, and that for each middle pivot position, you would need to check twice, once including the character, and once without.
  - For substrings, you can terminate early once there is no match.
  - For subsequences, use dynamic programming as there are overlapping subproblems. Check out [this question](https://leetcode.com/problems/longest-palindromic-subsequence/).

#### Practice Questions

- [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/)
- [Longest Repeating Character Replacement](https://leetcode.com/problems/longest-repeating-character-replacement/)
- [Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring/description/)
- [Encode and Decode Strings](https://leetcode.com/problems/encode-and-decode-strings/)
- [Valid Anagram](https://leetcode.com/problems/valid-anagram)
- [Group Anagrams](https://leetcode.com/problems/group-anagrams/)
- [Valid Parentheses](https://leetcode.com/problems/valid-parentheses)
- [Valid Palindrome](https://leetcode.com/problems/valid-palindrome/)
- [Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/)
- [Palindromic Substrings](https://leetcode.com/problems/palindromic-substrings/)

## Tree

- A tree is an undirected, connected, acyclic graph.
- Recursion is a common approach for trees. When you notice the subtree problem can be used to solve the whole problem, you should try recursion.
- When using recursion, always remember to check for the base case, usually where the node is `null`.
- When you are asked to traverse a tree by level, use depth-first search.
- Sometimes it is possible that your recursive function needs to return two values.
- If the question involves summation of nodes along the way, be sure to check whether nodes can be negative.
- You should be very familiar with writing pre-order, in-order and post-order traversal recursively. As an extension, challenge yourself by writing them iteratively. Sometimes interviewers do ask candidates for the iterative approach, especially if the candidate finishes writing the recursive approach too fast.
- Corner cases:
  - Empty tree.
  - Single node.
  - Two nodes.
  - Very skewed tree (like a linked list).

**Binary Tree**

- In-order traversal of a binary tree is insufficient to uniquely serialize a tree. Pre-order or post-order traversal is also required.

**Binary Search Tree**

- In-order traversal of a BST will give you all elements in order.
- Be very familiar with the properties of a BST and validating that a binary tree is a BST. This comes up more often than expected.
- When a question involves a BST, the interviewer is usually looking for a solution which runs faster than O(n).

#### Practice Questions

- [Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree/)
- [Same Tree](https://leetcode.com/problems/same-tree/)
- [Invert/Flip Binary Tree](https://leetcode.com/problems/invert-binary-tree/)
- [Binary Tree Maximum Path Sum](https://leetcode.com/problems/binary-tree-maximum-path-sum/)
- [Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/)
- [Serialize and Deserialize Binary Tree](https://leetcode.com/problems/serialize-and-deserialize-binary-tree/)
- [Subtree of Another Tree](https://leetcode.com/problems/subtree-of-another-tree/)
- [Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)
- [Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree/)
- [Kth Smallest Element in a BST](https://leetcode.com/problems/kth-smallest-element-in-a-bst/)
- [Lowest Common Ancestor of BST](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/)

## Trie

- Tries are special trees (prefix trees) that make searching and storing strings more efficient. Tries have many practical applications such as for searching and autocomplete. It will be helpful to know these common applications so that you can easily identify when a problem can be solved efficiently using a trie.
- Sometimes preprocessing a dictionary of words (given in a list) into a trie will improve the efficiency when searching for a word of length k among n words. Searching becomes O(k) instead of O(n).
- LeetCode has written a [very comprehensive article](https://leetcode.com/articles/implement-trie-prefix-tree/) on tries which you are highly encouraged to read.
- Be familiar with implementing a `Trie` class and its `add`, `remove` and `search` methods from scratch.

#### Practice Questions

- [Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree)
- [Add and Search Word](https://leetcode.com/problems/add-and-search-word-data-structure-design)
- [Word Search II](https://leetcode.com/problems/word-search-ii/)

## Heap

- If you see a top/lowest K being mentioned in the question, it is usually a signal that a heap can be used to solve the problem.
- If you require the top K elements use a Min Heap of size K. Iterate through each element, pushing it into the heap. Whenever the heap size exceeds K, remove the minimum element, that will guarantee that you have the K largest elements.

#### Practice Questions

- [Merge K Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
- [Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/)
- [Find Median from Data Stream](https://leetcode.com/problems/find-median-from-data-stream/)

###### References

- http://blog.triplebyte.com/how-to-pass-a-programming-interview
- https://quip.com/q41AA3OmoZbC
- http://www.geeksforgeeks.org/must-do-coding-questions-for-companies-like-amazon-microsoft-adobe/
Algorithm Questions
==

This section dives deep into practical tips for specific topics of algorithms and data structures which appear frequently in coding questions. Many algorithm questions involve techniques that can be applied to questions of similar nature. The more techniques you have in your arsenal, the higher the chances of passing the interview. They may lead you to discover corner cases you might have missed out or even lead you towards the optimal approach!

For each topic, there is also a list of recommended common questions which in my opinion is highly valuable for mastering the core concepts for the topic.

## Contents

- [Array](array.md)
- [Dynamic Programming and Memoization](dynamic-programming.md)
- [Geometry](geometry.md)
- [Graph](graph.md)
- [Hash Table](hash-table.md)
- [Heap](heap.md)
- [Interval](interval.md)
- [Linked List](linked-list.md)
- [Math](math.md)
- [Matrix](matrix.md)
- [Object-Oriented Programming](oop.md)
- [Permutation](permutation.md)
- [Queue](queue.md)
- [Sorting and Searching](sorting-searching.md)
- [Stack](stack.md)
- [String](string.md)
- [Tree](tree.md)

## General Tips

- Input validation:
  - Always validate input first. Check for invalid/empty/negative/different type input. Never assume you are given the valid parameters. Alternatively, clarify with the interviewer whether you can assume valid input (usually yes), which can save you time from writing code that does input validation.
- Are there any time/space complexity requirements/constraints?
- Check corner cases:
  - Check for off-by-one errors.
  - In languages where there are no automatic type coercion, check that concatenation of values are of the same type: `int`/`str`/`list`.
  - After finishing your code, use a few example inputs to test your solution.
- Is the algorithm meant to be run multiple times, for example in a web server? If yes, the input is likely to be preprocess-able to improve the efficiency in each call.
- Use a mix of functional and imperative programming paradigms:
  - Write pure functions as much as possible.
  - Pure functions are easier to reason about and can help to reduce bugs in your implementation.
  - Avoid mutating the parameters passed into your function especially if they are passed by reference unless you are sure of what you are doing.
  - However, functional programming is usually expensive in terms of space complexity because of non-mutation and the repeated allocation of new objects. On the other hand, imperative code is faster because you operate on existing objects. Hence you will need to achieve a balance between accuracy vs efficiency, by using the right amount of functional and imperative code where appropriate.
  - Avoid relying on and mutating global variables. Global variables introduce state.
  - If you have to rely on global variables, make sure that you do not mutate it by accident.
- Generally, to improve the speed of a program, we can either choose a more appropriate data structure/algorithm or use more memory. It's a classic space/time tradeoff.
- Data structures are your weapons. Choosing the right weapon for the right battle is the key to victory. Be very familiar about the strengths of each data structure and the time complexities for its various operations.
- Data structures can be augmented to achieve efficient time complexities across different operations. For example, a hash map can be used together with a doubly-linked list to achieve O(1) time complexity for both the `get` and `put` operation in an [LRU cache](https://leetcode.com/problems/lru-cache/).
- Hashmaps are probably the most commonly used data structure for algorithm questions. If you are stuck on a question, your last resort can be to enumerate through the possible data structures (thankfully there aren't that many of them) and consider whether each of them can be applied to the problem. This has worked for me sometimes.
- If you are cutting corners in your code, state that out loud to your interviewer and say what you would do in a non-interview setting (no time constraints). E.g., I would write a regex to parse this string rather than using `split()` which does not cover all cases.

## Sequence

- Arrays and strings are considered sequences (a string is a sequence of characters). There are tips relevant for dealing with both arrays and strings which will be covered here.
- Are there duplicate values in the sequence, would it affect the answer?
- Check for sequence out of bounds.
- Be mindful about slicing or concatenating sequences in your code. Typically, slicing and concatenating sequences require O(n) time. Use start and end indices to demarcate a subarray/substring where possible.
- Sometimes you can traverse the sequence from the right rather than from the left.
- Master the [sliding window technique](https://discuss.leetcode.com/topic/30941/here-is-a-10-line-template-that-can-solve-most-substring-problems) that applies to many substring/subarray problems.
- When you are given two sequences to process, it is common to have one index per sequence to traverse/compare the both of them. For example, we use the same approach to merge two sorted arrays.
- Corner cases:
  - Empty sequence.
  - Sequence with 1 or 2 elements.
  - Sequence with repeated elements.

## Array

- Is the array sorted or partially sorted? If it is, some form of binary search should be possible. This also usually means that the interviewer is looking for a solution that is faster than O(n).
- Can you sort the array? Sometimes sorting the array first may significantly simplify the problem. Make sure that the order of array elements do not need to be preserved before attempting a sort.
- For questions where summation or multiplication of a subarray is involved, pre-computation using hashing or a prefix/suffix sum/product might be useful.
- If you are given a sequence and the interviewer asks for O(1) space, it might be possible to use the array itself as a hash table. For example, if the array only has values from 1 to N, where N is the length of the array, negate the value at that index (minus one) to indicate presence of that number.

#### Practice Questions

- [Two Sum](https://leetcode.com/problems/two-sum/)
- [Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)
- [Contains Duplicate](https://leetcode.com/problems/contains-duplicate/)
- [Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/)
- [Maximum Subarray](https://leetcode.com/problems/maximum-subarray/)
- [Maximum Product Subarray](https://leetcode.com/problems/maximum-product-subarray/)
- [Find Minimum in Rotated Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)
- [Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array/)
- [3Sum](https://leetcode.com/problems/3sum/)
- [Container With Most Water](https://leetcode.com/problems/container-with-most-water/)

## Binary

- Questions involving binary representations and bitwise operations are asked sometimes and you must be absolutely familiar with how to convert a number from decimal form into binary form (and vice versa) in your programming language of choice.
- Test k<sup>th</sup> bit is set: `num & (1 << k) != 0`.
- Set k<sup>th</sup> bit: `num |= (1 << k)`.
- Turn off k<sup>th</sup> bit: `num &= ~(1 << k)`.
- Toggle the k<sup>th</sup> bit: `num ^= (1 << k)`.
- To check if a number is a power of 2, `num & num - 1 == 0`.

#### Practice Questions

- [Sum of Two Integers](https://leetcode.com/problems/sum-of-two-integers/)
- [Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits/)
- [Counting Bits](https://leetcode.com/problems/counting-bits/)
- [Missing Number](https://leetcode.com/problems/missing-number/)
- [Reverse Bits](https://leetcode.com/problems/reverse-bits/)

## Dynamic Programming

- Usually used to solve optimization problems.
- Alaina Kafkes has written an [awesome post](https://medium.freecodecamp.org/demystifying-dynamic-programming-3efafb8d4296) on tackling DP problems.
- The only way to get better at DP is to practice. It takes some amount of practice to be able to recognize that a problem can be solved by DP.
- Sometimes you do not need to store the whole DP table in memory, the last two values or the last two rows of the matrix will suffice.

#### Practice Questions

- 0/1 Knapsack
- [Climbing Stairs](https://leetcode.com/problems/climbing-stairs/)
- [Coin Change](https://leetcode.com/problems/coin-change/)
- [Longest Increasing Subsequence](https://leetcode.com/problems/longest-increasing-subsequence/)
- [Longest Common Subsequence]()
- [Word Break Problem](https://leetcode.com/problems/word-break/)
- [Combination Sum](https://leetcode.com/problems/combination-sum-iv/)
- [House Robber](https://leetcode.com/problems/house-robber/) and [House Robber II](https://leetcode.com/problems/house-robber-ii/)
- [Decode Ways](https://leetcode.com/problems/decode-ways/)
- [Unique Paths](https://leetcode.com/problems/unique-paths/)
- [Jump Game](https://leetcode.com/problems/jump-game/)

## Geometry

- When comparing euclidean distance between two pairs of points, using dx<sup>2</sup> + dy<sup>2</sup> is sufficient. It is unnecessary to square root the value.
- To find out if two circles overlap, check that the distance between the two centers of the circles is less than the sum of their radii.

## Graph

- Be familiar with the various graph representations, graph search algorithms and their time and space complexities.
- You can be given a list of edges and tasked to build your own graph from the edges to perform a traversal on. The common graph representations are:
  - Adjacency matrix.
  - Adjacency list.
  - Hashmap of hashmaps.
- Some questions look like they are trees but they are actually graphs. In that case you will have to handle cycles and keep a set of visited nodes when traversing.
- Graph search algorithms:
  - **Common** - Breadth-first Search, Depth-first Search
  - **Uncommon** - Topological Sort, Dijkstra's algorithm
  - **Rare** - Bellman-Ford algorithm, Floyd-Warshall algorithm, Prim's algorithm, Kruskal's algorithm
- In coding interviews, graphs are commonly represented as 2-D matrices where cells are the nodes and each cell can traverse to its adjacent cells (up/down/left/right). Hence it is important that you be familiar with traversing a 2-D matrix. When recursively traversing the matrix, always ensure that your next position is within the boundary of the matrix. More tips for doing depth-first searches on a matrix can be found [here](https://discuss.leetcode.com/topic/66065/python-dfs-bests-85-tips-for-all-dfs-in-matrix-question/). A simple template for doing depth-first searches on a matrix goes like this:

```py
def traverse(matrix):
  rows, cols = len(matrix), len(matrix[0])
  visited = set()
  directions = ((0, 1), (0, -1), (1, 0), (-1, 0))
  def dfs(i, j):
    if (i, j) in visited:
      return
    visited.add((i, j))
    # Traverse neighbors
    for direction in directions:
      next_i, next_j = i + direction[0], j + direction[1]
      if 0 <= next_i < rows and 0 <= next_j < cols: # Check boundary
        # Add any other checking here ^
        dfs(next_i, next_j)

  for i in range(rows):
    for j in range(cols):
      dfs(i, j)
```

- Corner cases:
  - Empty graph.
  - Graph with one or two nodes.
  - Disjoint graphs.
  - Graph with cycles.

#### Practice Questions

- [Clone Graph](https://leetcode.com/problems/clone-graph/)
- [Course Schedule](https://leetcode.com/problems/course-schedule/)
- [Alien Dictionary](https://leetcode.com/problems/alien-dictionary/)
- [Pacific Atlantic Water Flow](https://leetcode.com/problems/pacific-atlantic-water-flow/)
- [Number of Islands](https://leetcode.com/problems/number-of-islands/)
- [Graph Valid Tree](https://leetcode.com/problems/graph-valid-tree/)
- [Number of Connected Components in an Undirected Graph](https://leetcode.com/problems/number-of-connected-components-in-an-undirected-graph/)
- [Longest Consecutive Sequence](https://leetcode.com/problems/longest-consecutive-sequence/)

## Interval

- Interval questions are questions where you are given an array of two-element arrays (an interval) and the two values represent a start and an end value. Interval questions are considered part of the array family but they involve some common techniques hence they are extracted out to this special section of their own.
- An example interval array: `[[1, 2], [4, 7]]`.
- Interval questions can be tricky to those who have not tried them before because of the sheer number of cases to consider when they overlap.
- Do clarify with the interviewer whether `[1, 2]` and `[2, 3]` are considered overlapping intervals as it affects how you will write your equality checks.
- A common routine for interval questions is to sort the array of intervals by each interval's starting value.
- Be familiar with writing code to check if two intervals overlap and merging two overlapping intervals:

```py
def is_overlap(a, b):
  return a[0] < b[1] and b[0] < a[1]

def merge_overlapping_intervals(a, b):
  return [min(a[0], b[0]), max(a[1], b[1])]
```

- Corner cases:
  - Single interval.
  - Non-overlapping intervals.
  - An interval totally consumed within another interval.
  - Duplicate intervals.

#### Practice Questions

- [Insert Interval](https://leetcode.com/problems/insert-interval/)
- [Merge Intervals](https://leetcode.com/problems/merge-intervals/)
- [Meeting Rooms](https://leetcode.com/problems/meeting-rooms/) and [Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii/)
- [Non-overlapping Intervals](https://leetcode.com/problems/non-overlapping-intervals/)

## Linked List

- Like arrays, linked lists are used to represent sequential data. The benefit of linked lists is that insertion and deletion from anywhere in the list is O(1) whereas in arrays the following elements will have to be shifted.
- Adding a dummy node at the head and/or tail might help to handle many edge cases where operations have to be performed at the head or the tail. The presence of dummy nodes essentially ensures that operations will never have be done on the head or the tail, thereby removing a lot of headache in writing conditional checks to dealing with null pointers. Be sure to remember to remove them at the end of the operation.
- Sometimes linked lists problem can be solved without additional storage. Try to borrow ideas from reverse a linked list problem.
- For deletion in linked lists, you can either modify the node values or change the node pointers. You might need to keep a reference to the previous element.
- For partitioning linked lists, create two separate linked lists and join them back together.
- Linked lists problems share similarity with array problems, think about how you would do it for an array and try to apply it to a linked list.
- Two pointer approaches are also common for linked lists. For example:
  - Getting the k<sup>th</sup> from last node - Have two pointers, where one is k nodes ahead of the other. When the node ahead reaches the end, the other node is k nodes behind.
  - Detecting cycles - Have two pointers, where one pointer increments twice as much as the other, if the two pointers meet, means that there is a cycle.
  - Getting the middle node - Have two pointers, where one pointer increments twice as much as the other. When the faster node reaches the end of the list, the slower node will be at the middle.
- Be familiar with the following routines because many linked list questions make use of one or more of these routines in the solution:
  - Counting the number of nodes in the linked list.
  - Reversing a linked list in-place.
  - Finding the middle node of the linked list using fast/slow pointers.
  - Merging two lists together.
- Corner cases:
  - Single node.
  - Two nodes.
  - Cycle in linked list - Clarify whether there can be a cycle in the list? Usually the answer is no.

#### Practice Questions

- [Reverse a Linked List](https://leetcode.com/problems/reverse-linked-list/)
- [Detect Cycle in a Linked List](https://leetcode.com/problems/linked-list-cycle/)
- [Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)
- [Merge K Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
- [Remove Nth Node From End Of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)
- [Reorder List](https://leetcode.com/problems/reorder-list/)

## Math

- If code involves division or modulo, remember to check for division or modulo by 0 case.
- When a question involves "a multiple of a number", perhaps modulo might be useful.
- Check for and handle overflow/underflow if you are using a typed language like Java and C++. At the very least, mention that overflow/underflow is possible and ask whether you need to handle it.
- Consider negative numbers and floating point numbers. This may sound obvious, but under interview pressure, many obvious cases go unnoticed.
- If the question asks to implement an operator such as power, squareroot or division and want it to be faster than O(n), binary search is usually the approach to go.
- Some common formulas:
  - Sum of 1 to N = (n+1) * n/2
  - Sum of GP = 2<sup>0</sup> + 2<sup>1</sup> + 2<sup>2</sup> + 2<sup>3</sup> + ... 2<sup>n</sup> = 2<sup>n+1</sup> - 1
  - Permutations of N = N! / (N-K)!
  - Combinations of N = N! / (K! * (N-K)!)

#### Practice Questions

- [Pow(x, n)](https://leetcode.com/problems/powx-n/)
- [Sqrt(x)](https://leetcode.com/problems/sqrtx/)
- [Integer to English Words](https://leetcode.com/problems/integer-to-english-words/)

## Matrix

- A matrix is a 2-dimensional array. Questions involving matrices are usually related to dynamic programming or graph traversal.
- Corner cases:
  - Empty matrix. Check that none of the arrays are 0 length.
  - 1 x 1 matrix.
  - Matrix with only one row or column.
- For questions involving traversal or dynamic programming, you almost always want to make a copy of the matrix with the same dimensions that is initialized to empty values to store the visited state or dynamic programming table. Be familiar with such a routine:

```py
rows, cols = len(matrix), len(matrix[0])
copy = [[0 for _ in range(cols)] for _ in range(rows)]
```

- Many grid-based games can be modeled as a matrix, such as Tic-Tac-Toe, Sudoku, Crossword, Connect 4, Battleship, etc. It is not uncommon to be asked to verify the winning condition of the game. For games like Tic-Tac-Toe, Connect 4 and Crosswords, where verification has to be done vertically and horizontally, one trick is to write code to verify the matrix for the horizontal cells, transpose the matrix and reuse the logic for horizontal verification to verify originally vertical cells (which are now horizontal).
- Transposing a matrix in Python is simply:

```py
transposed_matrix = zip(*matrix)
```

#### Practice Questions

- [Set Matrix Zeroes](https://leetcode.com/problems/set-matrix-zeroes/)
- [Spiral Matrix](https://leetcode.com/problems/spiral-matrix/)
- [Rotate Image](https://leetcode.com/problems/rotate-image/)
- [Word Search](https://leetcode.com/problems/word-search/)

## Recursion

- Remember to always define a base case so that your recursion will end.
- Useful for permutation, generating all combinations and tree-based questions.
- Be familiar with how to generate all permutations of a sequence as well as how to handle duplicates.
- Recursion implicitly uses a stack. Hence all recursive approaches can be rewritten iteratively using a stack.
- Beware of cases where the recursion level goes too deep and causes a stack overflow (the default limit in Python is 1000).
- Recursion will never be O(1) space complexity because a stack is involved unless there is [tail-call optimization](https://stackoverflow.com/questions/310974/what-is-tail-call-optimization). Do find out if your chosen language supports tail-call optimization.

#### Practice Questions

- [Subsets](https://leetcode.com/problems/subsets/) and [Subsets II](https://leetcode.com/problems/subsets-ii/)
- [Strobogrammatic Number II](https://leetcode.com/problems/strobogrammatic-number-ii/)

## String

- Please read the above tips on [Sequence](#sequence) because they apply to strings too.
- Corner cases:
  - Strings with only one distinct character.
- Ask about input character set and case sensitivity. Usually the characters are limited to lower case Latin characters, i.e. a-z.
- When you need to compare strings where the order isn't important (like anagram), you may consider using a hash map as a counter. If your language has a built-in `Counter` class like Python, ask to use that instead.
- If you need to keep a counter of characters, a common mistake to make is to say that the space complexity required for the counter is O(n). The space required for a counter is O(1) not O(n), because the upper bound is the range of characters which is usually a fixed constant of 26 when the input set is just lower case Latin characters.
- Common data structures for looking up strings efficiently:
  - [Trie / Prefix Tree](https://en.wikipedia.org/wiki/Trie)
  - [Suffix Tree](https://en.wikipedia.org/wiki/Suffix_tree)
- Common string algorithms:
  - [Rabin Karp](https://en.wikipedia.org/wiki/Rabin%E2%80%93Karp_algorithm) for efficient searching of substring using a rolling hash.
  - [KMP](https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm) for efficient searching of substring.

#### Non-repeating Characters

- Use a 26-bit bitmask to indicate which lower case latin characters are inside the string.

```py
mask = 0
for c in set(word):
  mask |= (1 << (ord(c) - ord('a')))
```

- To determine if two strings have common characters, perform `&` on the two bitmasks and if the result is non-zero, the two strings do have common characters: `mask_a & mask_b > 0`.

#### Anagram

- An anagram is direct word switch or word play, the result of rearranging the letters of a word or phrase to produce a new word or phrase, using all the original letters exactly once. In interviews, usually we are only bothered with words without spaces in them.
- Determine if two strings are anagrams:
  - Sorting both strings should produce the same resulting string.
  - If we map each character to a prime number and we multiply each mapped number together, anagrams should have the same multiple (prime factor decomposition).
  - Frequency counting of characters will help to determine if two strings are anagrams.

#### Palindrome

- A palindrome is a word, phrase, number, or other sequence of characters which reads the same backward as forward, such as madam or racecar.
- Ways to determine if a string is a palindrome:
  - Reverse the string and it should be equal to itself.
  - Have two pointers at the start and end of the string, move inwards till they meet. At any point in time the characters at both pointers should match.
- The order of characters within the string matters, so hash maps are usually not helpful.
- When a question is about counting the number of palindromes, a common trick is to have two pointer that move outwards, away from the middle. Note that palindromes can be even/odd length, and that for each middle pivot position, you would need to check twice, once including the character, and once without.
  - For substrings, you can terminate early once there is no match.
  - For subsequences, use dynamic programming as there are overlapping subproblems. Check out [this question](https://leetcode.com/problems/longest-palindromic-subsequence/).

#### Practice Questions

- [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/)
- [Longest Repeating Character Replacement](https://leetcode.com/problems/longest-repeating-character-replacement/)
- [Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring/description/)
- [Encode and Decode Strings](https://leetcode.com/problems/encode-and-decode-strings/)
- [Valid Anagram](https://leetcode.com/problems/valid-anagram)
- [Group Anagrams](https://leetcode.com/problems/group-anagrams/)
- [Valid Parentheses](https://leetcode.com/problems/valid-parentheses)
- [Valid Palindrome](https://leetcode.com/problems/valid-palindrome/)
- [Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/)
- [Palindromic Substrings](https://leetcode.com/problems/palindromic-substrings/)

## Tree

- A tree is an undirected, connected, acyclic graph.
- Recursion is a common approach for trees. When you notice the subtree problem can be used to solve the whole problem, you should try recursion.
- When using recursion, always remember to check for the base case, usually where the node is `null`.
- When you are asked to traverse a tree by level, use depth-first search.
- Sometimes it is possible that your recursive function needs to return two values.
- If the question involves summation of nodes along the way, be sure to check whether nodes can be negative.
- You should be very familiar with writing pre-order, in-order and post-order traversal recursively. As an extension, challenge yourself by writing them iteratively. Sometimes interviewers do ask candidates for the iterative approach, especially if the candidate finishes writing the recursive approach too fast.
- Corner cases:
  - Empty tree.
  - Single node.
  - Two nodes.
  - Very skewed tree (like a linked list).

**Binary Tree**

- In-order traversal of a binary tree is insufficient to uniquely serialize a tree. Pre-order or post-order traversal is also required.

**Binary Search Tree**

- In-order traversal of a BST will give you all elements in order.
- Be very familiar with the properties of a BST and validating that a binary tree is a BST. This comes up more often than expected.
- When a question involves a BST, the interviewer is usually looking for a solution which runs faster than O(n).

#### Practice Questions

- [Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree/)
- [Same Tree](https://leetcode.com/problems/same-tree/)
- [Invert/Flip Binary Tree](https://leetcode.com/problems/invert-binary-tree/)
- [Binary Tree Maximum Path Sum](https://leetcode.com/problems/binary-tree-maximum-path-sum/)
- [Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/)
- [Serialize and Deserialize Binary Tree](https://leetcode.com/problems/serialize-and-deserialize-binary-tree/)
- [Subtree of Another Tree](https://leetcode.com/problems/subtree-of-another-tree/)
- [Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)
- [Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree/)
- [Kth Smallest Element in a BST](https://leetcode.com/problems/kth-smallest-element-in-a-bst/)
- [Lowest Common Ancestor of BST](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/)

## Trie

- Tries are special trees (prefix trees) that make searching and storing strings more efficient. Tries have many practical applications such as for searching and autocomplete. It will be helpful to know these common applications so that you can easily identify when a problem can be solved efficiently using a trie.
- Sometimes preprocessing a dictionary of words (given in a list) into a trie will improve the efficiency when searching for a word of length k among n words. Searching becomes O(k) instead of O(n).
- LeetCode has written a [very comprehensive article](https://leetcode.com/articles/implement-trie-prefix-tree/) on tries which you are highly encouraged to read.
- Be familiar with implementing a `Trie` class and its `add`, `remove` and `search` methods from scratch.

#### Practice Questions

- [Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree)
- [Add and Search Word](https://leetcode.com/problems/add-and-search-word-data-structure-design)
- [Word Search II](https://leetcode.com/problems/word-search-ii/)

## Heap

- If you see a top/lowest K being mentioned in the question, it is usually a signal that a heap can be used to solve the problem.
- If you require the top K elements use a Min Heap of size K. Iterate through each element, pushing it into the heap. Whenever the heap size exceeds K, remove the minimum element, that will guarantee that you have the K largest elements.

#### Practice Questions

- [Merge K Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
- [Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/)
- [Find Median from Data Stream](https://leetcode.com/problems/find-median-from-data-stream/)

###### References

- http://blog.triplebyte.com/how-to-pass-a-programming-interview
- https://quip.com/q41AA3OmoZbC
- http://www.geeksforgeeks.org/must-do-coding-questions-for-companies-like-amazon-microsoft-adobe/
Algorithm Questions
==

This section dives deep into practical tips for specific topics of algorithms and data structures which appear frequently in coding questions. Many algorithm questions involve techniques that can be applied to questions of similar nature. The more techniques you have in your arsenal, the higher the chances of passing the interview. They may lead you to discover corner cases you might have missed out or even lead you towards the optimal approach!

For each topic, there is also a list of recommended common questions which in my opinion is highly valuable for mastering the core concepts for the topic.

## Contents

- [Array](array.md)
- [Dynamic Programming and Memoization](dynamic-programming.md)
- [Geometry](geometry.md)
- [Graph](graph.md)
- [Hash Table](hash-table.md)
- [Heap](heap.md)
- [Interval](interval.md)
- [Linked List](linked-list.md)
- [Math](math.md)
- [Matrix](matrix.md)
- [Object-Oriented Programming](oop.md)
- [Permutation](permutation.md)
- [Queue](queue.md)
- [Sorting and Searching](sorting-searching.md)
- [Stack](stack.md)
- [String](string.md)
- [Tree](tree.md)

## General Tips

- Input validation:
  - Always validate input first. Check for invalid/empty/negative/different type input. Never assume you are given the valid parameters. Alternatively, clarify with the interviewer whether you can assume valid input (usually yes), which can save you time from writing code that does input validation.
- Are there any time/space complexity requirements/constraints?
- Check corner cases:
  - Check for off-by-one errors.
  - In languages where there are no automatic type coercion, check that concatenation of values are of the same type: `int`/`str`/`list`.
  - After finishing your code, use a few example inputs to test your solution.
- Is the algorithm meant to be run multiple times, for example in a web server? If yes, the input is likely to be preprocess-able to improve the efficiency in each call.
- Use a mix of functional and imperative programming paradigms:
  - Write pure functions as much as possible.
  - Pure functions are easier to reason about and can help to reduce bugs in your implementation.
  - Avoid mutating the parameters passed into your function especially if they are passed by reference unless you are sure of what you are doing.
  - However, functional programming is usually expensive in terms of space complexity because of non-mutation and the repeated allocation of new objects. On the other hand, imperative code is faster because you operate on existing objects. Hence you will need to achieve a balance between accuracy vs efficiency, by using the right amount of functional and imperative code where appropriate.
  - Avoid relying on and mutating global variables. Global variables introduce state.
  - If you have to rely on global variables, make sure that you do not mutate it by accident.
- Generally, to improve the speed of a program, we can either choose a more appropriate data structure/algorithm or use more memory. It's a classic space/time tradeoff.
- Data structures are your weapons. Choosing the right weapon for the right battle is the key to victory. Be very familiar about the strengths of each data structure and the time complexities for its various operations.
- Data structures can be augmented to achieve efficient time complexities across different operations. For example, a hash map can be used together with a doubly-linked list to achieve O(1) time complexity for both the `get` and `put` operation in an [LRU cache](https://leetcode.com/problems/lru-cache/).
- Hashmaps are probably the most commonly used data structure for algorithm questions. If you are stuck on a question, your last resort can be to enumerate through the possible data structures (thankfully there aren't that many of them) and consider whether each of them can be applied to the problem. This has worked for me sometimes.
- If you are cutting corners in your code, state that out loud to your interviewer and say what you would do in a non-interview setting (no time constraints). E.g., I would write a regex to parse this string rather than using `split()` which does not cover all cases.

## Sequence

- Arrays and strings are considered sequences (a string is a sequence of characters). There are tips relevant for dealing with both arrays and strings which will be covered here.
- Are there duplicate values in the sequence, would it affect the answer?
- Check for sequence out of bounds.
- Be mindful about slicing or concatenating sequences in your code. Typically, slicing and concatenating sequences require O(n) time. Use start and end indices to demarcate a subarray/substring where possible.
- Sometimes you can traverse the sequence from the right rather than from the left.
- Master the [sliding window technique](https://discuss.leetcode.com/topic/30941/here-is-a-10-line-template-that-can-solve-most-substring-problems) that applies to many substring/subarray problems.
- When you are given two sequences to process, it is common to have one index per sequence to traverse/compare the both of them. For example, we use the same approach to merge two sorted arrays.
- Corner cases:
  - Empty sequence.
  - Sequence with 1 or 2 elements.
  - Sequence with repeated elements.

## Array

- Is the array sorted or partially sorted? If it is, some form of binary search should be possible. This also usually means that the interviewer is looking for a solution that is faster than O(n).
- Can you sort the array? Sometimes sorting the array first may significantly simplify the problem. Make sure that the order of array elements do not need to be preserved before attempting a sort.
- For questions where summation or multiplication of a subarray is involved, pre-computation using hashing or a prefix/suffix sum/product might be useful.
- If you are given a sequence and the interviewer asks for O(1) space, it might be possible to use the array itself as a hash table. For example, if the array only has values from 1 to N, where N is the length of the array, negate the value at that index (minus one) to indicate presence of that number.

#### Practice Questions

- [Two Sum](https://leetcode.com/problems/two-sum/)
- [Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)
- [Contains Duplicate](https://leetcode.com/problems/contains-duplicate/)
- [Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/)
- [Maximum Subarray](https://leetcode.com/problems/maximum-subarray/)
- [Maximum Product Subarray](https://leetcode.com/problems/maximum-product-subarray/)
- [Find Minimum in Rotated Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)
- [Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array/)
- [3Sum](https://leetcode.com/problems/3sum/)
- [Container With Most Water](https://leetcode.com/problems/container-with-most-water/)

## Binary

- Questions involving binary representations and bitwise operations are asked sometimes and you must be absolutely familiar with how to convert a number from decimal form into binary form (and vice versa) in your programming language of choice.
- Test k<sup>th</sup> bit is set: `num & (1 << k) != 0`.
- Set k<sup>th</sup> bit: `num |= (1 << k)`.
- Turn off k<sup>th</sup> bit: `num &= ~(1 << k)`.
- Toggle the k<sup>th</sup> bit: `num ^= (1 << k)`.
- To check if a number is a power of 2, `num & num - 1 == 0`.

#### Practice Questions

- [Sum of Two Integers](https://leetcode.com/problems/sum-of-two-integers/)
- [Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits/)
- [Counting Bits](https://leetcode.com/problems/counting-bits/)
- [Missing Number](https://leetcode.com/problems/missing-number/)
- [Reverse Bits](https://leetcode.com/problems/reverse-bits/)

## Dynamic Programming

- Usually used to solve optimization problems.
- Alaina Kafkes has written an [awesome post](https://medium.freecodecamp.org/demystifying-dynamic-programming-3efafb8d4296) on tackling DP problems.
- The only way to get better at DP is to practice. It takes some amount of practice to be able to recognize that a problem can be solved by DP.
- Sometimes you do not need to store the whole DP table in memory, the last two values or the last two rows of the matrix will suffice.

#### Practice Questions

- 0/1 Knapsack
- [Climbing Stairs](https://leetcode.com/problems/climbing-stairs/)
- [Coin Change](https://leetcode.com/problems/coin-change/)
- [Longest Increasing Subsequence](https://leetcode.com/problems/longest-increasing-subsequence/)
- [Longest Common Subsequence]()
- [Word Break Problem](https://leetcode.com/problems/word-break/)
- [Combination Sum](https://leetcode.com/problems/combination-sum-iv/)
- [House Robber](https://leetcode.com/problems/house-robber/) and [House Robber II](https://leetcode.com/problems/house-robber-ii/)
- [Decode Ways](https://leetcode.com/problems/decode-ways/)
- [Unique Paths](https://leetcode.com/problems/unique-paths/)
- [Jump Game](https://leetcode.com/problems/jump-game/)

## Geometry

- When comparing euclidean distance between two pairs of points, using dx<sup>2</sup> + dy<sup>2</sup> is sufficient. It is unnecessary to square root the value.
- To find out if two circles overlap, check that the distance between the two centers of the circles is less than the sum of their radii.

## Graph

- Be familiar with the various graph representations, graph search algorithms and their time and space complexities.
- You can be given a list of edges and tasked to build your own graph from the edges to perform a traversal on. The common graph representations are:
  - Adjacency matrix.
  - Adjacency list.
  - Hashmap of hashmaps.
- Some questions look like they are trees but they are actually graphs. In that case you will have to handle cycles and keep a set of visited nodes when traversing.
- Graph search algorithms:
  - **Common** - Breadth-first Search, Depth-first Search
  - **Uncommon** - Topological Sort, Dijkstra's algorithm
  - **Rare** - Bellman-Ford algorithm, Floyd-Warshall algorithm, Prim's algorithm, Kruskal's algorithm
- In coding interviews, graphs are commonly represented as 2-D matrices where cells are the nodes and each cell can traverse to its adjacent cells (up/down/left/right). Hence it is important that you be familiar with traversing a 2-D matrix. When recursively traversing the matrix, always ensure that your next position is within the boundary of the matrix. More tips for doing depth-first searches on a matrix can be found [here](https://discuss.leetcode.com/topic/66065/python-dfs-bests-85-tips-for-all-dfs-in-matrix-question/). A simple template for doing depth-first searches on a matrix goes like this:

```py
def traverse(matrix):
  rows, cols = len(matrix), len(matrix[0])
  visited = set()
  directions = ((0, 1), (0, -1), (1, 0), (-1, 0))
  def dfs(i, j):
    if (i, j) in visited:
      return
    visited.add((i, j))
    # Traverse neighbors
    for direction in directions:
      next_i, next_j = i + direction[0], j + direction[1]
      if 0 <= next_i < rows and 0 <= next_j < cols: # Check boundary
        # Add any other checking here ^
        dfs(next_i, next_j)

  for i in range(rows):
    for j in range(cols):
      dfs(i, j)
```

- Corner cases:
  - Empty graph.
  - Graph with one or two nodes.
  - Disjoint graphs.
  - Graph with cycles.

#### Practice Questions

- [Clone Graph](https://leetcode.com/problems/clone-graph/)
- [Course Schedule](https://leetcode.com/problems/course-schedule/)
- [Alien Dictionary](https://leetcode.com/problems/alien-dictionary/)
- [Pacific Atlantic Water Flow](https://leetcode.com/problems/pacific-atlantic-water-flow/)
- [Number of Islands](https://leetcode.com/problems/number-of-islands/)
- [Graph Valid Tree](https://leetcode.com/problems/graph-valid-tree/)
- [Number of Connected Components in an Undirected Graph](https://leetcode.com/problems/number-of-connected-components-in-an-undirected-graph/)
- [Longest Consecutive Sequence](https://leetcode.com/problems/longest-consecutive-sequence/)

## Interval

- Interval questions are questions where you are given an array of two-element arrays (an interval) and the two values represent a start and an end value. Interval questions are considered part of the array family but they involve some common techniques hence they are extracted out to this special section of their own.
- An example interval array: `[[1, 2], [4, 7]]`.
- Interval questions can be tricky to those who have not tried them before because of the sheer number of cases to consider when they overlap.
- Do clarify with the interviewer whether `[1, 2]` and `[2, 3]` are considered overlapping intervals as it affects how you will write your equality checks.
- A common routine for interval questions is to sort the array of intervals by each interval's starting value.
- Be familiar with writing code to check if two intervals overlap and merging two overlapping intervals:

```py
def is_overlap(a, b):
  return a[0] < b[1] and b[0] < a[1]

def merge_overlapping_intervals(a, b):
  return [min(a[0], b[0]), max(a[1], b[1])]
```

- Corner cases:
  - Single interval.
  - Non-overlapping intervals.
  - An interval totally consumed within another interval.
  - Duplicate intervals.

#### Practice Questions

- [Insert Interval](https://leetcode.com/problems/insert-interval/)
- [Merge Intervals](https://leetcode.com/problems/merge-intervals/)
- [Meeting Rooms](https://leetcode.com/problems/meeting-rooms/) and [Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii/)
- [Non-overlapping Intervals](https://leetcode.com/problems/non-overlapping-intervals/)

## Linked List

- Like arrays, linked lists are used to represent sequential data. The benefit of linked lists is that insertion and deletion from anywhere in the list is O(1) whereas in arrays the following elements will have to be shifted.
- Adding a dummy node at the head and/or tail might help to handle many edge cases where operations have to be performed at the head or the tail. The presence of dummy nodes essentially ensures that operations will never have be done on the head or the tail, thereby removing a lot of headache in writing conditional checks to dealing with null pointers. Be sure to remember to remove them at the end of the operation.
- Sometimes linked lists problem can be solved without additional storage. Try to borrow ideas from reverse a linked list problem.
- For deletion in linked lists, you can either modify the node values or change the node pointers. You might need to keep a reference to the previous element.
- For partitioning linked lists, create two separate linked lists and join them back together.
- Linked lists problems share similarity with array problems, think about how you would do it for an array and try to apply it to a linked list.
- Two pointer approaches are also common for linked lists. For example:
  - Getting the k<sup>th</sup> from last node - Have two pointers, where one is k nodes ahead of the other. When the node ahead reaches the end, the other node is k nodes behind.
  - Detecting cycles - Have two pointers, where one pointer increments twice as much as the other, if the two pointers meet, means that there is a cycle.
  - Getting the middle node - Have two pointers, where one pointer increments twice as much as the other. When the faster node reaches the end of the list, the slower node will be at the middle.
- Be familiar with the following routines because many linked list questions make use of one or more of these routines in the solution:
  - Counting the number of nodes in the linked list.
  - Reversing a linked list in-place.
  - Finding the middle node of the linked list using fast/slow pointers.
  - Merging two lists together.
- Corner cases:
  - Single node.
  - Two nodes.
  - Cycle in linked list - Clarify whether there can be a cycle in the list? Usually the answer is no.

#### Practice Questions

- [Reverse a Linked List](https://leetcode.com/problems/reverse-linked-list/)
- [Detect Cycle in a Linked List](https://leetcode.com/problems/linked-list-cycle/)
- [Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)
- [Merge K Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
- [Remove Nth Node From End Of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)
- [Reorder List](https://leetcode.com/problems/reorder-list/)

## Math

- If code involves division or modulo, remember to check for division or modulo by 0 case.
- When a question involves "a multiple of a number", perhaps modulo might be useful.
- Check for and handle overflow/underflow if you are using a typed language like Java and C++. At the very least, mention that overflow/underflow is possible and ask whether you need to handle it.
- Consider negative numbers and floating point numbers. This may sound obvious, but under interview pressure, many obvious cases go unnoticed.
- If the question asks to implement an operator such as power, squareroot or division and want it to be faster than O(n), binary search is usually the approach to go.
- Some common formulas:
  - Sum of 1 to N = (n+1) * n/2
  - Sum of GP = 2<sup>0</sup> + 2<sup>1</sup> + 2<sup>2</sup> + 2<sup>3</sup> + ... 2<sup>n</sup> = 2<sup>n+1</sup> - 1
  - Permutations of N = N! / (N-K)!
  - Combinations of N = N! / (K! * (N-K)!)

#### Practice Questions

- [Pow(x, n)](https://leetcode.com/problems/powx-n/)
- [Sqrt(x)](https://leetcode.com/problems/sqrtx/)
- [Integer to English Words](https://leetcode.com/problems/integer-to-english-words/)

## Matrix

- A matrix is a 2-dimensional array. Questions involving matrices are usually related to dynamic programming or graph traversal.
- Corner cases:
  - Empty matrix. Check that none of the arrays are 0 length.
  - 1 x 1 matrix.
  - Matrix with only one row or column.
- For questions involving traversal or dynamic programming, you almost always want to make a copy of the matrix with the same dimensions that is initialized to empty values to store the visited state or dynamic programming table. Be familiar with such a routine:

```py
rows, cols = len(matrix), len(matrix[0])
copy = [[0 for _ in range(cols)] for _ in range(rows)]
```

- Many grid-based games can be modeled as a matrix, such as Tic-Tac-Toe, Sudoku, Crossword, Connect 4, Battleship, etc. It is not uncommon to be asked to verify the winning condition of the game. For games like Tic-Tac-Toe, Connect 4 and Crosswords, where verification has to be done vertically and horizontally, one trick is to write code to verify the matrix for the horizontal cells, transpose the matrix and reuse the logic for horizontal verification to verify originally vertical cells (which are now horizontal).
- Transposing a matrix in Python is simply:

```py
transposed_matrix = zip(*matrix)
```

#### Practice Questions

- [Set Matrix Zeroes](https://leetcode.com/problems/set-matrix-zeroes/)
- [Spiral Matrix](https://leetcode.com/problems/spiral-matrix/)
- [Rotate Image](https://leetcode.com/problems/rotate-image/)
- [Word Search](https://leetcode.com/problems/word-search/)

## Recursion

- Remember to always define a base case so that your recursion will end.
- Useful for permutation, generating all combinations and tree-based questions.
- Be familiar with how to generate all permutations of a sequence as well as how to handle duplicates.
- Recursion implicitly uses a stack. Hence all recursive approaches can be rewritten iteratively using a stack.
- Beware of cases where the recursion level goes too deep and causes a stack overflow (the default limit in Python is 1000).
- Recursion will never be O(1) space complexity because a stack is involved unless there is [tail-call optimization](https://stackoverflow.com/questions/310974/what-is-tail-call-optimization). Do find out if your chosen language supports tail-call optimization.

#### Practice Questions

- [Subsets](https://leetcode.com/problems/subsets/) and [Subsets II](https://leetcode.com/problems/subsets-ii/)
- [Strobogrammatic Number II](https://leetcode.com/problems/strobogrammatic-number-ii/)

## String

- Please read the above tips on [Sequence](#sequence) because they apply to strings too.
- Corner cases:
  - Strings with only one distinct character.
- Ask about input character set and case sensitivity. Usually the characters are limited to lower case Latin characters, i.e. a-z.
- When you need to compare strings where the order isn't important (like anagram), you may consider using a hash map as a counter. If your language has a built-in `Counter` class like Python, ask to use that instead.
- If you need to keep a counter of characters, a common mistake to make is to say that the space complexity required for the counter is O(n). The space required for a counter is O(1) not O(n), because the upper bound is the range of characters which is usually a fixed constant of 26 when the input set is just lower case Latin characters.
- Common data structures for looking up strings efficiently:
  - [Trie / Prefix Tree](https://en.wikipedia.org/wiki/Trie)
  - [Suffix Tree](https://en.wikipedia.org/wiki/Suffix_tree)
- Common string algorithms:
  - [Rabin Karp](https://en.wikipedia.org/wiki/Rabin%E2%80%93Karp_algorithm) for efficient searching of substring using a rolling hash.
  - [KMP](https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm) for efficient searching of substring.

#### Non-repeating Characters

- Use a 26-bit bitmask to indicate which lower case latin characters are inside the string.

```py
mask = 0
for c in set(word):
  mask |= (1 << (ord(c) - ord('a')))
```

- To determine if two strings have common characters, perform `&` on the two bitmasks and if the result is non-zero, the two strings do have common characters: `mask_a & mask_b > 0`.

#### Anagram

- An anagram is direct word switch or word play, the result of rearranging the letters of a word or phrase to produce a new word or phrase, using all the original letters exactly once. In interviews, usually we are only bothered with words without spaces in them.
- Determine if two strings are anagrams:
  - Sorting both strings should produce the same resulting string.
  - If we map each character to a prime number and we multiply each mapped number together, anagrams should have the same multiple (prime factor decomposition).
  - Frequency counting of characters will help to determine if two strings are anagrams.

#### Palindrome

- A palindrome is a word, phrase, number, or other sequence of characters which reads the same backward as forward, such as madam or racecar.
- Ways to determine if a string is a palindrome:
  - Reverse the string and it should be equal to itself.
  - Have two pointers at the start and end of the string, move inwards till they meet. At any point in time the characters at both pointers should match.
- The order of characters within the string matters, so hash maps are usually not helpful.
- When a question is about counting the number of palindromes, a common trick is to have two pointer that move outwards, away from the middle. Note that palindromes can be even/odd length, and that for each middle pivot position, you would need to check twice, once including the character, and once without.
  - For substrings, you can terminate early once there is no match.
  - For subsequences, use dynamic programming as there are overlapping subproblems. Check out [this question](https://leetcode.com/problems/longest-palindromic-subsequence/).

#### Practice Questions

- [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/)
- [Longest Repeating Character Replacement](https://leetcode.com/problems/longest-repeating-character-replacement/)
- [Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring/description/)
- [Encode and Decode Strings](https://leetcode.com/problems/encode-and-decode-strings/)
- [Valid Anagram](https://leetcode.com/problems/valid-anagram)
- [Group Anagrams](https://leetcode.com/problems/group-anagrams/)
- [Valid Parentheses](https://leetcode.com/problems/valid-parentheses)
- [Valid Palindrome](https://leetcode.com/problems/valid-palindrome/)
- [Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/)
- [Palindromic Substrings](https://leetcode.com/problems/palindromic-substrings/)

## Tree

- A tree is an undirected, connected, acyclic graph.
- Recursion is a common approach for trees. When you notice the subtree problem can be used to solve the whole problem, you should try recursion.
- When using recursion, always remember to check for the base case, usually where the node is `null`.
- When you are asked to traverse a tree by level, use depth-first search.
- Sometimes it is possible that your recursive function needs to return two values.
- If the question involves summation of nodes along the way, be sure to check whether nodes can be negative.
- You should be very familiar with writing pre-order, in-order and post-order traversal recursively. As an extension, challenge yourself by writing them iteratively. Sometimes interviewers do ask candidates for the iterative approach, especially if the candidate finishes writing the recursive approach too fast.
- Corner cases:
  - Empty tree.
  - Single node.
  - Two nodes.
  - Very skewed tree (like a linked list).

**Binary Tree**

- In-order traversal of a binary tree is insufficient to uniquely serialize a tree. Pre-order or post-order traversal is also required.

**Binary Search Tree**

- In-order traversal of a BST will give you all elements in order.
- Be very familiar with the properties of a BST and validating that a binary tree is a BST. This comes up more often than expected.
- When a question involves a BST, the interviewer is usually looking for a solution which runs faster than O(n).

#### Practice Questions

- [Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree/)
- [Same Tree](https://leetcode.com/problems/same-tree/)
- [Invert/Flip Binary Tree](https://leetcode.com/problems/invert-binary-tree/)
- [Binary Tree Maximum Path Sum](https://leetcode.com/problems/binary-tree-maximum-path-sum/)
- [Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/)
- [Serialize and Deserialize Binary Tree](https://leetcode.com/problems/serialize-and-deserialize-binary-tree/)
- [Subtree of Another Tree](https://leetcode.com/problems/subtree-of-another-tree/)
- [Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)
- [Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree/)
- [Kth Smallest Element in a BST](https://leetcode.com/problems/kth-smallest-element-in-a-bst/)
- [Lowest Common Ancestor of BST](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/)

## Trie

- Tries are special trees (prefix trees) that make searching and storing strings more efficient. Tries have many practical applications such as for searching and autocomplete. It will be helpful to know these common applications so that you can easily identify when a problem can be solved efficiently using a trie.
- Sometimes preprocessing a dictionary of words (given in a list) into a trie will improve the efficiency when searching for a word of length k among n words. Searching becomes O(k) instead of O(n).
- LeetCode has written a [very comprehensive article](https://leetcode.com/articles/implement-trie-prefix-tree/) on tries which you are highly encouraged to read.
- Be familiar with implementing a `Trie` class and its `add`, `remove` and `search` methods from scratch.

#### Practice Questions

- [Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree)
- [Add and Search Word](https://leetcode.com/problems/add-and-search-word-data-structure-design)
- [Word Search II](https://leetcode.com/problems/word-search-ii/)

## Heap

- If you see a top/lowest K being mentioned in the question, it is usually a signal that a heap can be used to solve the problem.
- If you require the top K elements use a Min Heap of size K. Iterate through each element, pushing it into the heap. Whenever the heap size exceeds K, remove the minimum element, that will guarantee that you have the K largest elements.

#### Practice Questions

- [Merge K Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
- [Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/)
- [Find Median from Data Stream](https://leetcode.com/problems/find-median-from-data-stream/)

###### References

- http://blog.triplebyte.com/how-to-pass-a-programming-interview
- https://quip.com/q41AA3OmoZbC
- http://www.geeksforgeeks.org/must-do-coding-questions-for-companies-like-amazon-microsoft-adobe/
Algorithm Questions
==

This section dives deep into practical tips for specific topics of algorithms and data structures which appear frequently in coding questions. Many algorithm questions involve techniques that can be applied to questions of similar nature. The more techniques you have in your arsenal, the higher the chances of passing the interview. They may lead you to discover corner cases you might have missed out or even lead you towards the optimal approach!

For each topic, there is also a list of recommended common questions which in my opinion is highly valuable for mastering the core concepts for the topic.

## Contents

- [Array](array.md)
- [Dynamic Programming and Memoization](dynamic-programming.md)
- [Geometry](geometry.md)
- [Graph](graph.md)
- [Hash Table](hash-table.md)
- [Heap](heap.md)
- [Interval](interval.md)
- [Linked List](linked-list.md)
- [Math](math.md)
- [Matrix](matrix.md)
- [Object-Oriented Programming](oop.md)
- [Permutation](permutation.md)
- [Queue](queue.md)
- [Sorting and Searching](sorting-searching.md)
- [Stack](stack.md)
- [String](string.md)
- [Tree](tree.md)

## General Tips

- Input validation:
  - Always validate input first. Check for invalid/empty/negative/different type input. Never assume you are given the valid parameters. Alternatively, clarify with the interviewer whether you can assume valid input (usually yes), which can save you time from writing code that does input validation.
- Are there any time/space complexity requirements/constraints?
- Check corner cases:
  - Check for off-by-one errors.
  - In languages where there are no automatic type coercion, check that concatenation of values are of the same type: `int`/`str`/`list`.
  - After finishing your code, use a few example inputs to test your solution.
- Is the algorithm meant to be run multiple times, for example in a web server? If yes, the input is likely to be preprocess-able to improve the efficiency in each call.
- Use a mix of functional and imperative programming paradigms:
  - Write pure functions as much as possible.
  - Pure functions are easier to reason about and can help to reduce bugs in your implementation.
  - Avoid mutating the parameters passed into your function especially if they are passed by reference unless you are sure of what you are doing.
  - However, functional programming is usually expensive in terms of space complexity because of non-mutation and the repeated allocation of new objects. On the other hand, imperative code is faster because you operate on existing objects. Hence you will need to achieve a balance between accuracy vs efficiency, by using the right amount of functional and imperative code where appropriate.
  - Avoid relying on and mutating global variables. Global variables introduce state.
  - If you have to rely on global variables, make sure that you do not mutate it by accident.
- Generally, to improve the speed of a program, we can either choose a more appropriate data structure/algorithm or use more memory. It's a classic space/time tradeoff.
- Data structures are your weapons. Choosing the right weapon for the right battle is the key to victory. Be very familiar about the strengths of each data structure and the time complexities for its various operations.
- Data structures can be augmented to achieve efficient time complexities across different operations. For example, a hash map can be used together with a doubly-linked list to achieve O(1) time complexity for both the `get` and `put` operation in an [LRU cache](https://leetcode.com/problems/lru-cache/).
- Hashmaps are probably the most commonly used data structure for algorithm questions. If you are stuck on a question, your last resort can be to enumerate through the possible data structures (thankfully there aren't that many of them) and consider whether each of them can be applied to the problem. This has worked for me sometimes.
- If you are cutting corners in your code, state that out loud to your interviewer and say what you would do in a non-interview setting (no time constraints). E.g., I would write a regex to parse this string rather than using `split()` which does not cover all cases.

## Sequence

- Arrays and strings are considered sequences (a string is a sequence of characters). There are tips relevant for dealing with both arrays and strings which will be covered here.
- Are there duplicate values in the sequence, would it affect the answer?
- Check for sequence out of bounds.
- Be mindful about slicing or concatenating sequences in your code. Typically, slicing and concatenating sequences require O(n) time. Use start and end indices to demarcate a subarray/substring where possible.
- Sometimes you can traverse the sequence from the right rather than from the left.
- Master the [sliding window technique](https://discuss.leetcode.com/topic/30941/here-is-a-10-line-template-that-can-solve-most-substring-problems) that applies to many substring/subarray problems.
- When you are given two sequences to process, it is common to have one index per sequence to traverse/compare the both of them. For example, we use the same approach to merge two sorted arrays.
- Corner cases:
  - Empty sequence.
  - Sequence with 1 or 2 elements.
  - Sequence with repeated elements.

## Array

- Is the array sorted or partially sorted? If it is, some form of binary search should be possible. This also usually means that the interviewer is looking for a solution that is faster than O(n).
- Can you sort the array? Sometimes sorting the array first may significantly simplify the problem. Make sure that the order of array elements do not need to be preserved before attempting a sort.
- For questions where summation or multiplication of a subarray is involved, pre-computation using hashing or a prefix/suffix sum/product might be useful.
- If you are given a sequence and the interviewer asks for O(1) space, it might be possible to use the array itself as a hash table. For example, if the array only has values from 1 to N, where N is the length of the array, negate the value at that index (minus one) to indicate presence of that number.

#### Practice Questions

- [Two Sum](https://leetcode.com/problems/two-sum/)
- [Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)
- [Contains Duplicate](https://leetcode.com/problems/contains-duplicate/)
- [Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/)
- [Maximum Subarray](https://leetcode.com/problems/maximum-subarray/)
- [Maximum Product Subarray](https://leetcode.com/problems/maximum-product-subarray/)
- [Find Minimum in Rotated Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)
- [Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array/)
- [3Sum](https://leetcode.com/problems/3sum/)
- [Container With Most Water](https://leetcode.com/problems/container-with-most-water/)

## Binary

- Questions involving binary representations and bitwise operations are asked sometimes and you must be absolutely familiar with how to convert a number from decimal form into binary form (and vice versa) in your programming language of choice.
- Test k<sup>th</sup> bit is set: `num & (1 << k) != 0`.
- Set k<sup>th</sup> bit: `num |= (1 << k)`.
- Turn off k<sup>th</sup> bit: `num &= ~(1 << k)`.
- Toggle the k<sup>th</sup> bit: `num ^= (1 << k)`.
- To check if a number is a power of 2, `num & num - 1 == 0`.

#### Practice Questions

- [Sum of Two Integers](https://leetcode.com/problems/sum-of-two-integers/)
- [Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits/)
- [Counting Bits](https://leetcode.com/problems/counting-bits/)
- [Missing Number](https://leetcode.com/problems/missing-number/)
- [Reverse Bits](https://leetcode.com/problems/reverse-bits/)

## Dynamic Programming

- Usually used to solve optimization problems.
- Alaina Kafkes has written an [awesome post](https://medium.freecodecamp.org/demystifying-dynamic-programming-3efafb8d4296) on tackling DP problems.
- The only way to get better at DP is to practice. It takes some amount of practice to be able to recognize that a problem can be solved by DP.
- Sometimes you do not need to store the whole DP table in memory, the last two values or the last two rows of the matrix will suffice.

#### Practice Questions

- 0/1 Knapsack
- [Climbing Stairs](https://leetcode.com/problems/climbing-stairs/)
- [Coin Change](https://leetcode.com/problems/coin-change/)
- [Longest Increasing Subsequence](https://leetcode.com/problems/longest-increasing-subsequence/)
- [Longest Common Subsequence]()
- [Word Break Problem](https://leetcode.com/problems/word-break/)
- [Combination Sum](https://leetcode.com/problems/combination-sum-iv/)
- [House Robber](https://leetcode.com/problems/house-robber/) and [House Robber II](https://leetcode.com/problems/house-robber-ii/)
- [Decode Ways](https://leetcode.com/problems/decode-ways/)
- [Unique Paths](https://leetcode.com/problems/unique-paths/)
- [Jump Game](https://leetcode.com/problems/jump-game/)

## Geometry

- When comparing euclidean distance between two pairs of points, using dx<sup>2</sup> + dy<sup>2</sup> is sufficient. It is unnecessary to square root the value.
- To find out if two circles overlap, check that the distance between the two centers of the circles is less than the sum of their radii.

## Graph

- Be familiar with the various graph representations, graph search algorithms and their time and space complexities.
- You can be given a list of edges and tasked to build your own graph from the edges to perform a traversal on. The common graph representations are:
  - Adjacency matrix.
  - Adjacency list.
  - Hashmap of hashmaps.
- Some questions look like they are trees but they are actually graphs. In that case you will have to handle cycles and keep a set of visited nodes when traversing.
- Graph search algorithms:
  - **Common** - Breadth-first Search, Depth-first Search
  - **Uncommon** - Topological Sort, Dijkstra's algorithm
  - **Rare** - Bellman-Ford algorithm, Floyd-Warshall algorithm, Prim's algorithm, Kruskal's algorithm
- In coding interviews, graphs are commonly represented as 2-D matrices where cells are the nodes and each cell can traverse to its adjacent cells (up/down/left/right). Hence it is important that you be familiar with traversing a 2-D matrix. When recursively traversing the matrix, always ensure that your next position is within the boundary of the matrix. More tips for doing depth-first searches on a matrix can be found [here](https://discuss.leetcode.com/topic/66065/python-dfs-bests-85-tips-for-all-dfs-in-matrix-question/). A simple template for doing depth-first searches on a matrix goes like this:

```py
def traverse(matrix):
  rows, cols = len(matrix), len(matrix[0])
  visited = set()
  directions = ((0, 1), (0, -1), (1, 0), (-1, 0))
  def dfs(i, j):
    if (i, j) in visited:
      return
    visited.add((i, j))
    # Traverse neighbors
    for direction in directions:
      next_i, next_j = i + direction[0], j + direction[1]
      if 0 <= next_i < rows and 0 <= next_j < cols: # Check boundary
        # Add any other checking here ^
        dfs(next_i, next_j)

  for i in range(rows):
    for j in range(cols):
      dfs(i, j)
```

- Corner cases:
  - Empty graph.
  - Graph with one or two nodes.
  - Disjoint graphs.
  - Graph with cycles.

#### Practice Questions

- [Clone Graph](https://leetcode.com/problems/clone-graph/)
- [Course Schedule](https://leetcode.com/problems/course-schedule/)
- [Alien Dictionary](https://leetcode.com/problems/alien-dictionary/)
- [Pacific Atlantic Water Flow](https://leetcode.com/problems/pacific-atlantic-water-flow/)
- [Number of Islands](https://leetcode.com/problems/number-of-islands/)
- [Graph Valid Tree](https://leetcode.com/problems/graph-valid-tree/)
- [Number of Connected Components in an Undirected Graph](https://leetcode.com/problems/number-of-connected-components-in-an-undirected-graph/)
- [Longest Consecutive Sequence](https://leetcode.com/problems/longest-consecutive-sequence/)

## Interval

- Interval questions are questions where you are given an array of two-element arrays (an interval) and the two values represent a start and an end value. Interval questions are considered part of the array family but they involve some common techniques hence they are extracted out to this special section of their own.
- An example interval array: `[[1, 2], [4, 7]]`.
- Interval questions can be tricky to those who have not tried them before because of the sheer number of cases to consider when they overlap.
- Do clarify with the interviewer whether `[1, 2]` and `[2, 3]` are considered overlapping intervals as it affects how you will write your equality checks.
- A common routine for interval questions is to sort the array of intervals by each interval's starting value.
- Be familiar with writing code to check if two intervals overlap and merging two overlapping intervals:

```py
def is_overlap(a, b):
  return a[0] < b[1] and b[0] < a[1]

def merge_overlapping_intervals(a, b):
  return [min(a[0], b[0]), max(a[1], b[1])]
```

- Corner cases:
  - Single interval.
  - Non-overlapping intervals.
  - An interval totally consumed within another interval.
  - Duplicate intervals.

#### Practice Questions

- [Insert Interval](https://leetcode.com/problems/insert-interval/)
- [Merge Intervals](https://leetcode.com/problems/merge-intervals/)
- [Meeting Rooms](https://leetcode.com/problems/meeting-rooms/) and [Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii/)
- [Non-overlapping Intervals](https://leetcode.com/problems/non-overlapping-intervals/)

## Linked List

- Like arrays, linked lists are used to represent sequential data. The benefit of linked lists is that insertion and deletion from anywhere in the list is O(1) whereas in arrays the following elements will have to be shifted.
- Adding a dummy node at the head and/or tail might help to handle many edge cases where operations have to be performed at the head or the tail. The presence of dummy nodes essentially ensures that operations will never have be done on the head or the tail, thereby removing a lot of headache in writing conditional checks to dealing with null pointers. Be sure to remember to remove them at the end of the operation.
- Sometimes linked lists problem can be solved without additional storage. Try to borrow ideas from reverse a linked list problem.
- For deletion in linked lists, you can either modify the node values or change the node pointers. You might need to keep a reference to the previous element.
- For partitioning linked lists, create two separate linked lists and join them back together.
- Linked lists problems share similarity with array problems, think about how you would do it for an array and try to apply it to a linked list.
- Two pointer approaches are also common for linked lists. For example:
  - Getting the k<sup>th</sup> from last node - Have two pointers, where one is k nodes ahead of the other. When the node ahead reaches the end, the other node is k nodes behind.
  - Detecting cycles - Have two pointers, where one pointer increments twice as much as the other, if the two pointers meet, means that there is a cycle.
  - Getting the middle node - Have two pointers, where one pointer increments twice as much as the other. When the faster node reaches the end of the list, the slower node will be at the middle.
- Be familiar with the following routines because many linked list questions make use of one or more of these routines in the solution:
  - Counting the number of nodes in the linked list.
  - Reversing a linked list in-place.
  - Finding the middle node of the linked list using fast/slow pointers.
  - Merging two lists together.
- Corner cases:
  - Single node.
  - Two nodes.
  - Cycle in linked list - Clarify whether there can be a cycle in the list? Usually the answer is no.

#### Practice Questions

- [Reverse a Linked List](https://leetcode.com/problems/reverse-linked-list/)
- [Detect Cycle in a Linked List](https://leetcode.com/problems/linked-list-cycle/)
- [Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)
- [Merge K Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
- [Remove Nth Node From End Of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)
- [Reorder List](https://leetcode.com/problems/reorder-list/)

## Math

- If code involves division or modulo, remember to check for division or modulo by 0 case.
- When a question involves "a multiple of a number", perhaps modulo might be useful.
- Check for and handle overflow/underflow if you are using a typed language like Java and C++. At the very least, mention that overflow/underflow is possible and ask whether you need to handle it.
- Consider negative numbers and floating point numbers. This may sound obvious, but under interview pressure, many obvious cases go unnoticed.
- If the question asks to implement an operator such as power, squareroot or division and want it to be faster than O(n), binary search is usually the approach to go.
- Some common formulas:
  - Sum of 1 to N = (n+1) * n/2
  - Sum of GP = 2<sup>0</sup> + 2<sup>1</sup> + 2<sup>2</sup> + 2<sup>3</sup> + ... 2<sup>n</sup> = 2<sup>n+1</sup> - 1
  - Permutations of N = N! / (N-K)!
  - Combinations of N = N! / (K! * (N-K)!)

#### Practice Questions

- [Pow(x, n)](https://leetcode.com/problems/powx-n/)
- [Sqrt(x)](https://leetcode.com/problems/sqrtx/)
- [Integer to English Words](https://leetcode.com/problems/integer-to-english-words/)

## Matrix

- A matrix is a 2-dimensional array. Questions involving matrices are usually related to dynamic programming or graph traversal.
- Corner cases:
  - Empty matrix. Check that none of the arrays are 0 length.
  - 1 x 1 matrix.
  - Matrix with only one row or column.
- For questions involving traversal or dynamic programming, you almost always want to make a copy of the matrix with the same dimensions that is initialized to empty values to store the visited state or dynamic programming table. Be familiar with such a routine:

```py
rows, cols = len(matrix), len(matrix[0])
copy = [[0 for _ in range(cols)] for _ in range(rows)]
```

- Many grid-based games can be modeled as a matrix, such as Tic-Tac-Toe, Sudoku, Crossword, Connect 4, Battleship, etc. It is not uncommon to be asked to verify the winning condition of the game. For games like Tic-Tac-Toe, Connect 4 and Crosswords, where verification has to be done vertically and horizontally, one trick is to write code to verify the matrix for the horizontal cells, transpose the matrix and reuse the logic for horizontal verification to verify originally vertical cells (which are now horizontal).
- Transposing a matrix in Python is simply:

```py
transposed_matrix = zip(*matrix)
```

#### Practice Questions

- [Set Matrix Zeroes](https://leetcode.com/problems/set-matrix-zeroes/)
- [Spiral Matrix](https://leetcode.com/problems/spiral-matrix/)
- [Rotate Image](https://leetcode.com/problems/rotate-image/)
- [Word Search](https://leetcode.com/problems/word-search/)

## Recursion

- Remember to always define a base case so that your recursion will end.
- Useful for permutation, generating all combinations and tree-based questions.
- Be familiar with how to generate all permutations of a sequence as well as how to handle duplicates.
- Recursion implicitly uses a stack. Hence all recursive approaches can be rewritten iteratively using a stack.
- Beware of cases where the recursion level goes too deep and causes a stack overflow (the default limit in Python is 1000).
- Recursion will never be O(1) space complexity because a stack is involved unless there is [tail-call optimization](https://stackoverflow.com/questions/310974/what-is-tail-call-optimization). Do find out if your chosen language supports tail-call optimization.

#### Practice Questions

- [Subsets](https://leetcode.com/problems/subsets/) and [Subsets II](https://leetcode.com/problems/subsets-ii/)
- [Strobogrammatic Number II](https://leetcode.com/problems/strobogrammatic-number-ii/)

## String

- Please read the above tips on [Sequence](#sequence) because they apply to strings too.
- Corner cases:
  - Strings with only one distinct character.
- Ask about input character set and case sensitivity. Usually the characters are limited to lower case Latin characters, i.e. a-z.
- When you need to compare strings where the order isn't important (like anagram), you may consider using a hash map as a counter. If your language has a built-in `Counter` class like Python, ask to use that instead.
- If you need to keep a counter of characters, a common mistake to make is to say that the space complexity required for the counter is O(n). The space required for a counter is O(1) not O(n), because the upper bound is the range of characters which is usually a fixed constant of 26 when the input set is just lower case Latin characters.
- Common data structures for looking up strings efficiently:
  - [Trie / Prefix Tree](https://en.wikipedia.org/wiki/Trie)
  - [Suffix Tree](https://en.wikipedia.org/wiki/Suffix_tree)
- Common string algorithms:
  - [Rabin Karp](https://en.wikipedia.org/wiki/Rabin%E2%80%93Karp_algorithm) for efficient searching of substring using a rolling hash.
  - [KMP](https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm) for efficient searching of substring.

#### Non-repeating Characters

- Use a 26-bit bitmask to indicate which lower case latin characters are inside the string.

```py
mask = 0
for c in set(word):
  mask |= (1 << (ord(c) - ord('a')))
```

- To determine if two strings have common characters, perform `&` on the two bitmasks and if the result is non-zero, the two strings do have common characters: `mask_a & mask_b > 0`.

#### Anagram

- An anagram is direct word switch or word play, the result of rearranging the letters of a word or phrase to produce a new word or phrase, using all the original letters exactly once. In interviews, usually we are only bothered with words without spaces in them.
- Determine if two strings are anagrams:
  - Sorting both strings should produce the same resulting string.
  - If we map each character to a prime number and we multiply each mapped number together, anagrams should have the same multiple (prime factor decomposition).
  - Frequency counting of characters will help to determine if two strings are anagrams.

#### Palindrome

- A palindrome is a word, phrase, number, or other sequence of characters which reads the same backward as forward, such as madam or racecar.
- Ways to determine if a string is a palindrome:
  - Reverse the string and it should be equal to itself.
  - Have two pointers at the start and end of the string, move inwards till they meet. At any point in time the characters at both pointers should match.
- The order of characters within the string matters, so hash maps are usually not helpful.
- When a question is about counting the number of palindromes, a common trick is to have two pointer that move outwards, away from the middle. Note that palindromes can be even/odd length, and that for each middle pivot position, you would need to check twice, once including the character, and once without.
  - For substrings, you can terminate early once there is no match.
  - For subsequences, use dynamic programming as there are overlapping subproblems. Check out [this question](https://leetcode.com/problems/longest-palindromic-subsequence/).

#### Practice Questions

- [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/)
- [Longest Repeating Character Replacement](https://leetcode.com/problems/longest-repeating-character-replacement/)
- [Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring/description/)
- [Encode and Decode Strings](https://leetcode.com/problems/encode-and-decode-strings/)
- [Valid Anagram](https://leetcode.com/problems/valid-anagram)
- [Group Anagrams](https://leetcode.com/problems/group-anagrams/)
- [Valid Parentheses](https://leetcode.com/problems/valid-parentheses)
- [Valid Palindrome](https://leetcode.com/problems/valid-palindrome/)
- [Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/)
- [Palindromic Substrings](https://leetcode.com/problems/palindromic-substrings/)

## Tree

- A tree is an undirected, connected, acyclic graph.
- Recursion is a common approach for trees. When you notice the subtree problem can be used to solve the whole problem, you should try recursion.
- When using recursion, always remember to check for the base case, usually where the node is `null`.
- When you are asked to traverse a tree by level, use depth-first search.
- Sometimes it is possible that your recursive function needs to return two values.
- If the question involves summation of nodes along the way, be sure to check whether nodes can be negative.
- You should be very familiar with writing pre-order, in-order and post-order traversal recursively. As an extension, challenge yourself by writing them iteratively. Sometimes interviewers do ask candidates for the iterative approach, especially if the candidate finishes writing the recursive approach too fast.
- Corner cases:
  - Empty tree.
  - Single node.
  - Two nodes.
  - Very skewed tree (like a linked list).

**Binary Tree**

- In-order traversal of a binary tree is insufficient to uniquely serialize a tree. Pre-order or post-order traversal is also required.

**Binary Search Tree**

- In-order traversal of a BST will give you all elements in order.
- Be very familiar with the properties of a BST and validating that a binary tree is a BST. This comes up more often than expected.
- When a question involves a BST, the interviewer is usually looking for a solution which runs faster than O(n).

#### Practice Questions

- [Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree/)
- [Same Tree](https://leetcode.com/problems/same-tree/)
- [Invert/Flip Binary Tree](https://leetcode.com/problems/invert-binary-tree/)
- [Binary Tree Maximum Path Sum](https://leetcode.com/problems/binary-tree-maximum-path-sum/)
- [Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/)
- [Serialize and Deserialize Binary Tree](https://leetcode.com/problems/serialize-and-deserialize-binary-tree/)
- [Subtree of Another Tree](https://leetcode.com/problems/subtree-of-another-tree/)
- [Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)
- [Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree/)
- [Kth Smallest Element in a BST](https://leetcode.com/problems/kth-smallest-element-in-a-bst/)
- [Lowest Common Ancestor of BST](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/)

## Trie

- Tries are special trees (prefix trees) that make searching and storing strings more efficient. Tries have many practical applications such as for searching and autocomplete. It will be helpful to know these common applications so that you can easily identify when a problem can be solved efficiently using a trie.
- Sometimes preprocessing a dictionary of words (given in a list) into a trie will improve the efficiency when searching for a word of length k among n words. Searching becomes O(k) instead of O(n).
- LeetCode has written a [very comprehensive article](https://leetcode.com/articles/implement-trie-prefix-tree/) on tries which you are highly encouraged to read.
- Be familiar with implementing a `Trie` class and its `add`, `remove` and `search` methods from scratch.

#### Practice Questions

- [Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree)
- [Add and Search Word](https://leetcode.com/problems/add-and-search-word-data-structure-design)
- [Word Search II](https://leetcode.com/problems/word-search-ii/)

## Heap

- If you see a top/lowest K being mentioned in the question, it is usually a signal that a heap can be used to solve the problem.
- If you require the top K elements use a Min Heap of size K. Iterate through each element, pushing it into the heap. Whenever the heap size exceeds K, remove the minimum element, that will guarantee that you have the K largest elements.

#### Practice Questions

- [Merge K Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
- [Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/)
- [Find Median from Data Stream](https://leetcode.com/problems/find-median-from-data-stream/)

###### References

- http://blog.triplebyte.com/how-to-pass-a-programming-interview
- https://quip.com/q41AA3OmoZbC
- http://www.geeksforgeeks.org/must-do-coding-questions-for-companies-like-amazon-microsoft-adobe/
Algorithm Questions
==

This section dives deep into practical tips for specific topics of algorithms and data structures which appear frequently in coding questions. Many algorithm questions involve techniques that can be applied to questions of similar nature. The more techniques you have in your arsenal, the higher the chances of passing the interview. They may lead you to discover corner cases you might have missed out or even lead you towards the optimal approach!

For each topic, there is also a list of recommended common questions which in my opinion is highly valuable for mastering the core concepts for the topic.

## Contents

- [Array](array.md)
- [Dynamic Programming and Memoization](dynamic-programming.md)
- [Geometry](geometry.md)
- [Graph](graph.md)
- [Hash Table](hash-table.md)
- [Heap](heap.md)
- [Interval](interval.md)
- [Linked List](linked-list.md)
- [Math](math.md)
- [Matrix](matrix.md)
- [Object-Oriented Programming](oop.md)
- [Permutation](permutation.md)
- [Queue](queue.md)
- [Sorting and Searching](sorting-searching.md)
- [Stack](stack.md)
- [String](string.md)
- [Tree](tree.md)

## General Tips

- Input validation:
  - Always validate input first. Check for invalid/empty/negative/different type input. Never assume you are given the valid parameters. Alternatively, clarify with the interviewer whether you can assume valid input (usually yes), which can save you time from writing code that does input validation.
- Are there any time/space complexity requirements/constraints?
- Check corner cases:
  - Check for off-by-one errors.
  - In languages where there are no automatic type coercion, check that concatenation of values are of the same type: `int`/`str`/`list`.
  - After finishing your code, use a few example inputs to test your solution.
- Is the algorithm meant to be run multiple times, for example in a web server? If yes, the input is likely to be preprocess-able to improve the efficiency in each call.
- Use a mix of functional and imperative programming paradigms:
  - Write pure functions as much as possible.
  - Pure functions are easier to reason about and can help to reduce bugs in your implementation.
  - Avoid mutating the parameters passed into your function especially if they are passed by reference unless you are sure of what you are doing.
  - However, functional programming is usually expensive in terms of space complexity because of non-mutation and the repeated allocation of new objects. On the other hand, imperative code is faster because you operate on existing objects. Hence you will need to achieve a balance between accuracy vs efficiency, by using the right amount of functional and imperative code where appropriate.
  - Avoid relying on and mutating global variables. Global variables introduce state.
  - If you have to rely on global variables, make sure that you do not mutate it by accident.
- Generally, to improve the speed of a program, we can either choose a more appropriate data structure/algorithm or use more memory. It's a classic space/time tradeoff.
- Data structures are your weapons. Choosing the right weapon for the right battle is the key to victory. Be very familiar about the strengths of each data structure and the time complexities for its various operations.
- Data structures can be augmented to achieve efficient time complexities across different operations. For example, a hash map can be used together with a doubly-linked list to achieve O(1) time complexity for both the `get` and `put` operation in an [LRU cache](https://leetcode.com/problems/lru-cache/).
- Hashmaps are probably the most commonly used data structure for algorithm questions. If you are stuck on a question, your last resort can be to enumerate through the possible data structures (thankfully there aren't that many of them) and consider whether each of them can be applied to the problem. This has worked for me sometimes.
- If you are cutting corners in your code, state that out loud to your interviewer and say what you would do in a non-interview setting (no time constraints). E.g., I would write a regex to parse this string rather than using `split()` which does not cover all cases.

## Sequence

- Arrays and strings are considered sequences (a string is a sequence of characters). There are tips relevant for dealing with both arrays and strings which will be covered here.
- Are there duplicate values in the sequence, would it affect the answer?
- Check for sequence out of bounds.
- Be mindful about slicing or concatenating sequences in your code. Typically, slicing and concatenating sequences require O(n) time. Use start and end indices to demarcate a subarray/substring where possible.
- Sometimes you can traverse the sequence from the right rather than from the left.
- Master the [sliding window technique](https://discuss.leetcode.com/topic/30941/here-is-a-10-line-template-that-can-solve-most-substring-problems) that applies to many substring/subarray problems.
- When you are given two sequences to process, it is common to have one index per sequence to traverse/compare the both of them. For example, we use the same approach to merge two sorted arrays.
- Corner cases:
  - Empty sequence.
  - Sequence with 1 or 2 elements.
  - Sequence with repeated elements.

## Array

- Is the array sorted or partially sorted? If it is, some form of binary search should be possible. This also usually means that the interviewer is looking for a solution that is faster than O(n).
- Can you sort the array? Sometimes sorting the array first may significantly simplify the problem. Make sure that the order of array elements do not need to be preserved before attempting a sort.
- For questions where summation or multiplication of a subarray is involved, pre-computation using hashing or a prefix/suffix sum/product might be useful.
- If you are given a sequence and the interviewer asks for O(1) space, it might be possible to use the array itself as a hash table. For example, if the array only has values from 1 to N, where N is the length of the array, negate the value at that index (minus one) to indicate presence of that number.

#### Practice Questions

- [Two Sum](https://leetcode.com/problems/two-sum/)
- [Best Time to Buy and Sell Stock](https://leetcode.com/problems/best-time-to-buy-and-sell-stock/)
- [Contains Duplicate](https://leetcode.com/problems/contains-duplicate/)
- [Product of Array Except Self](https://leetcode.com/problems/product-of-array-except-self/)
- [Maximum Subarray](https://leetcode.com/problems/maximum-subarray/)
- [Maximum Product Subarray](https://leetcode.com/problems/maximum-product-subarray/)
- [Find Minimum in Rotated Sorted Array](https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/)
- [Search in Rotated Sorted Array](https://leetcode.com/problems/search-in-rotated-sorted-array/)
- [3Sum](https://leetcode.com/problems/3sum/)
- [Container With Most Water](https://leetcode.com/problems/container-with-most-water/)

## Binary

- Questions involving binary representations and bitwise operations are asked sometimes and you must be absolutely familiar with how to convert a number from decimal form into binary form (and vice versa) in your programming language of choice.
- Test k<sup>th</sup> bit is set: `num & (1 << k) != 0`.
- Set k<sup>th</sup> bit: `num |= (1 << k)`.
- Turn off k<sup>th</sup> bit: `num &= ~(1 << k)`.
- Toggle the k<sup>th</sup> bit: `num ^= (1 << k)`.
- To check if a number is a power of 2, `num & num - 1 == 0`.

#### Practice Questions

- [Sum of Two Integers](https://leetcode.com/problems/sum-of-two-integers/)
- [Number of 1 Bits](https://leetcode.com/problems/number-of-1-bits/)
- [Counting Bits](https://leetcode.com/problems/counting-bits/)
- [Missing Number](https://leetcode.com/problems/missing-number/)
- [Reverse Bits](https://leetcode.com/problems/reverse-bits/)

## Dynamic Programming

- Usually used to solve optimization problems.
- Alaina Kafkes has written an [awesome post](https://medium.freecodecamp.org/demystifying-dynamic-programming-3efafb8d4296) on tackling DP problems.
- The only way to get better at DP is to practice. It takes some amount of practice to be able to recognize that a problem can be solved by DP.
- Sometimes you do not need to store the whole DP table in memory, the last two values or the last two rows of the matrix will suffice.

#### Practice Questions

- 0/1 Knapsack
- [Climbing Stairs](https://leetcode.com/problems/climbing-stairs/)
- [Coin Change](https://leetcode.com/problems/coin-change/)
- [Longest Increasing Subsequence](https://leetcode.com/problems/longest-increasing-subsequence/)
- [Longest Common Subsequence]()
- [Word Break Problem](https://leetcode.com/problems/word-break/)
- [Combination Sum](https://leetcode.com/problems/combination-sum-iv/)
- [House Robber](https://leetcode.com/problems/house-robber/) and [House Robber II](https://leetcode.com/problems/house-robber-ii/)
- [Decode Ways](https://leetcode.com/problems/decode-ways/)
- [Unique Paths](https://leetcode.com/problems/unique-paths/)
- [Jump Game](https://leetcode.com/problems/jump-game/)

## Geometry

- When comparing euclidean distance between two pairs of points, using dx<sup>2</sup> + dy<sup>2</sup> is sufficient. It is unnecessary to square root the value.
- To find out if two circles overlap, check that the distance between the two centers of the circles is less than the sum of their radii.

## Graph

- Be familiar with the various graph representations, graph search algorithms and their time and space complexities.
- You can be given a list of edges and tasked to build your own graph from the edges to perform a traversal on. The common graph representations are:
  - Adjacency matrix.
  - Adjacency list.
  - Hashmap of hashmaps.
- Some questions look like they are trees but they are actually graphs. In that case you will have to handle cycles and keep a set of visited nodes when traversing.
- Graph search algorithms:
  - **Common** - Breadth-first Search, Depth-first Search
  - **Uncommon** - Topological Sort, Dijkstra's algorithm
  - **Rare** - Bellman-Ford algorithm, Floyd-Warshall algorithm, Prim's algorithm, Kruskal's algorithm
- In coding interviews, graphs are commonly represented as 2-D matrices where cells are the nodes and each cell can traverse to its adjacent cells (up/down/left/right). Hence it is important that you be familiar with traversing a 2-D matrix. When recursively traversing the matrix, always ensure that your next position is within the boundary of the matrix. More tips for doing depth-first searches on a matrix can be found [here](https://discuss.leetcode.com/topic/66065/python-dfs-bests-85-tips-for-all-dfs-in-matrix-question/). A simple template for doing depth-first searches on a matrix goes like this:

```py
def traverse(matrix):
  rows, cols = len(matrix), len(matrix[0])
  visited = set()
  directions = ((0, 1), (0, -1), (1, 0), (-1, 0))
  def dfs(i, j):
    if (i, j) in visited:
      return
    visited.add((i, j))
    # Traverse neighbors
    for direction in directions:
      next_i, next_j = i + direction[0], j + direction[1]
      if 0 <= next_i < rows and 0 <= next_j < cols: # Check boundary
        # Add any other checking here ^
        dfs(next_i, next_j)

  for i in range(rows):
    for j in range(cols):
      dfs(i, j)
```

- Corner cases:
  - Empty graph.
  - Graph with one or two nodes.
  - Disjoint graphs.
  - Graph with cycles.

#### Practice Questions

- [Clone Graph](https://leetcode.com/problems/clone-graph/)
- [Course Schedule](https://leetcode.com/problems/course-schedule/)
- [Alien Dictionary](https://leetcode.com/problems/alien-dictionary/)
- [Pacific Atlantic Water Flow](https://leetcode.com/problems/pacific-atlantic-water-flow/)
- [Number of Islands](https://leetcode.com/problems/number-of-islands/)
- [Graph Valid Tree](https://leetcode.com/problems/graph-valid-tree/)
- [Number of Connected Components in an Undirected Graph](https://leetcode.com/problems/number-of-connected-components-in-an-undirected-graph/)
- [Longest Consecutive Sequence](https://leetcode.com/problems/longest-consecutive-sequence/)

## Interval

- Interval questions are questions where you are given an array of two-element arrays (an interval) and the two values represent a start and an end value. Interval questions are considered part of the array family but they involve some common techniques hence they are extracted out to this special section of their own.
- An example interval array: `[[1, 2], [4, 7]]`.
- Interval questions can be tricky to those who have not tried them before because of the sheer number of cases to consider when they overlap.
- Do clarify with the interviewer whether `[1, 2]` and `[2, 3]` are considered overlapping intervals as it affects how you will write your equality checks.
- A common routine for interval questions is to sort the array of intervals by each interval's starting value.
- Be familiar with writing code to check if two intervals overlap and merging two overlapping intervals:

```py
def is_overlap(a, b):
  return a[0] < b[1] and b[0] < a[1]

def merge_overlapping_intervals(a, b):
  return [min(a[0], b[0]), max(a[1], b[1])]
```

- Corner cases:
  - Single interval.
  - Non-overlapping intervals.
  - An interval totally consumed within another interval.
  - Duplicate intervals.

#### Practice Questions

- [Insert Interval](https://leetcode.com/problems/insert-interval/)
- [Merge Intervals](https://leetcode.com/problems/merge-intervals/)
- [Meeting Rooms](https://leetcode.com/problems/meeting-rooms/) and [Meeting Rooms II](https://leetcode.com/problems/meeting-rooms-ii/)
- [Non-overlapping Intervals](https://leetcode.com/problems/non-overlapping-intervals/)

## Linked List

- Like arrays, linked lists are used to represent sequential data. The benefit of linked lists is that insertion and deletion from anywhere in the list is O(1) whereas in arrays the following elements will have to be shifted.
- Adding a dummy node at the head and/or tail might help to handle many edge cases where operations have to be performed at the head or the tail. The presence of dummy nodes essentially ensures that operations will never have be done on the head or the tail, thereby removing a lot of headache in writing conditional checks to dealing with null pointers. Be sure to remember to remove them at the end of the operation.
- Sometimes linked lists problem can be solved without additional storage. Try to borrow ideas from reverse a linked list problem.
- For deletion in linked lists, you can either modify the node values or change the node pointers. You might need to keep a reference to the previous element.
- For partitioning linked lists, create two separate linked lists and join them back together.
- Linked lists problems share similarity with array problems, think about how you would do it for an array and try to apply it to a linked list.
- Two pointer approaches are also common for linked lists. For example:
  - Getting the k<sup>th</sup> from last node - Have two pointers, where one is k nodes ahead of the other. When the node ahead reaches the end, the other node is k nodes behind.
  - Detecting cycles - Have two pointers, where one pointer increments twice as much as the other, if the two pointers meet, means that there is a cycle.
  - Getting the middle node - Have two pointers, where one pointer increments twice as much as the other. When the faster node reaches the end of the list, the slower node will be at the middle.
- Be familiar with the following routines because many linked list questions make use of one or more of these routines in the solution:
  - Counting the number of nodes in the linked list.
  - Reversing a linked list in-place.
  - Finding the middle node of the linked list using fast/slow pointers.
  - Merging two lists together.
- Corner cases:
  - Single node.
  - Two nodes.
  - Cycle in linked list - Clarify whether there can be a cycle in the list? Usually the answer is no.

#### Practice Questions

- [Reverse a Linked List](https://leetcode.com/problems/reverse-linked-list/)
- [Detect Cycle in a Linked List](https://leetcode.com/problems/linked-list-cycle/)
- [Merge Two Sorted Lists](https://leetcode.com/problems/merge-two-sorted-lists/)
- [Merge K Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
- [Remove Nth Node From End Of List](https://leetcode.com/problems/remove-nth-node-from-end-of-list/)
- [Reorder List](https://leetcode.com/problems/reorder-list/)

## Math

- If code involves division or modulo, remember to check for division or modulo by 0 case.
- When a question involves "a multiple of a number", perhaps modulo might be useful.
- Check for and handle overflow/underflow if you are using a typed language like Java and C++. At the very least, mention that overflow/underflow is possible and ask whether you need to handle it.
- Consider negative numbers and floating point numbers. This may sound obvious, but under interview pressure, many obvious cases go unnoticed.
- If the question asks to implement an operator such as power, squareroot or division and want it to be faster than O(n), binary search is usually the approach to go.
- Some common formulas:
  - Sum of 1 to N = (n+1) * n/2
  - Sum of GP = 2<sup>0</sup> + 2<sup>1</sup> + 2<sup>2</sup> + 2<sup>3</sup> + ... 2<sup>n</sup> = 2<sup>n+1</sup> - 1
  - Permutations of N = N! / (N-K)!
  - Combinations of N = N! / (K! * (N-K)!)

#### Practice Questions

- [Pow(x, n)](https://leetcode.com/problems/powx-n/)
- [Sqrt(x)](https://leetcode.com/problems/sqrtx/)
- [Integer to English Words](https://leetcode.com/problems/integer-to-english-words/)

## Matrix

- A matrix is a 2-dimensional array. Questions involving matrices are usually related to dynamic programming or graph traversal.
- Corner cases:
  - Empty matrix. Check that none of the arrays are 0 length.
  - 1 x 1 matrix.
  - Matrix with only one row or column.
- For questions involving traversal or dynamic programming, you almost always want to make a copy of the matrix with the same dimensions that is initialized to empty values to store the visited state or dynamic programming table. Be familiar with such a routine:

```py
rows, cols = len(matrix), len(matrix[0])
copy = [[0 for _ in range(cols)] for _ in range(rows)]
```

- Many grid-based games can be modeled as a matrix, such as Tic-Tac-Toe, Sudoku, Crossword, Connect 4, Battleship, etc. It is not uncommon to be asked to verify the winning condition of the game. For games like Tic-Tac-Toe, Connect 4 and Crosswords, where verification has to be done vertically and horizontally, one trick is to write code to verify the matrix for the horizontal cells, transpose the matrix and reuse the logic for horizontal verification to verify originally vertical cells (which are now horizontal).
- Transposing a matrix in Python is simply:

```py
transposed_matrix = zip(*matrix)
```

#### Practice Questions

- [Set Matrix Zeroes](https://leetcode.com/problems/set-matrix-zeroes/)
- [Spiral Matrix](https://leetcode.com/problems/spiral-matrix/)
- [Rotate Image](https://leetcode.com/problems/rotate-image/)
- [Word Search](https://leetcode.com/problems/word-search/)

## Recursion

- Remember to always define a base case so that your recursion will end.
- Useful for permutation, generating all combinations and tree-based questions.
- Be familiar with how to generate all permutations of a sequence as well as how to handle duplicates.
- Recursion implicitly uses a stack. Hence all recursive approaches can be rewritten iteratively using a stack.
- Beware of cases where the recursion level goes too deep and causes a stack overflow (the default limit in Python is 1000).
- Recursion will never be O(1) space complexity because a stack is involved unless there is [tail-call optimization](https://stackoverflow.com/questions/310974/what-is-tail-call-optimization). Do find out if your chosen language supports tail-call optimization.

#### Practice Questions

- [Subsets](https://leetcode.com/problems/subsets/) and [Subsets II](https://leetcode.com/problems/subsets-ii/)
- [Strobogrammatic Number II](https://leetcode.com/problems/strobogrammatic-number-ii/)

## String

- Please read the above tips on [Sequence](#sequence) because they apply to strings too.
- Corner cases:
  - Strings with only one distinct character.
- Ask about input character set and case sensitivity. Usually the characters are limited to lower case Latin characters, i.e. a-z.
- When you need to compare strings where the order isn't important (like anagram), you may consider using a hash map as a counter. If your language has a built-in `Counter` class like Python, ask to use that instead.
- If you need to keep a counter of characters, a common mistake to make is to say that the space complexity required for the counter is O(n). The space required for a counter is O(1) not O(n), because the upper bound is the range of characters which is usually a fixed constant of 26 when the input set is just lower case Latin characters.
- Common data structures for looking up strings efficiently:
  - [Trie / Prefix Tree](https://en.wikipedia.org/wiki/Trie)
  - [Suffix Tree](https://en.wikipedia.org/wiki/Suffix_tree)
- Common string algorithms:
  - [Rabin Karp](https://en.wikipedia.org/wiki/Rabin%E2%80%93Karp_algorithm) for efficient searching of substring using a rolling hash.
  - [KMP](https://en.wikipedia.org/wiki/Knuth%E2%80%93Morris%E2%80%93Pratt_algorithm) for efficient searching of substring.

#### Non-repeating Characters

- Use a 26-bit bitmask to indicate which lower case latin characters are inside the string.

```py
mask = 0
for c in set(word):
  mask |= (1 << (ord(c) - ord('a')))
```

- To determine if two strings have common characters, perform `&` on the two bitmasks and if the result is non-zero, the two strings do have common characters: `mask_a & mask_b > 0`.

#### Anagram

- An anagram is direct word switch or word play, the result of rearranging the letters of a word or phrase to produce a new word or phrase, using all the original letters exactly once. In interviews, usually we are only bothered with words without spaces in them.
- Determine if two strings are anagrams:
  - Sorting both strings should produce the same resulting string.
  - If we map each character to a prime number and we multiply each mapped number together, anagrams should have the same multiple (prime factor decomposition).
  - Frequency counting of characters will help to determine if two strings are anagrams.

#### Palindrome

- A palindrome is a word, phrase, number, or other sequence of characters which reads the same backward as forward, such as madam or racecar.
- Ways to determine if a string is a palindrome:
  - Reverse the string and it should be equal to itself.
  - Have two pointers at the start and end of the string, move inwards till they meet. At any point in time the characters at both pointers should match.
- The order of characters within the string matters, so hash maps are usually not helpful.
- When a question is about counting the number of palindromes, a common trick is to have two pointer that move outwards, away from the middle. Note that palindromes can be even/odd length, and that for each middle pivot position, you would need to check twice, once including the character, and once without.
  - For substrings, you can terminate early once there is no match.
  - For subsequences, use dynamic programming as there are overlapping subproblems. Check out [this question](https://leetcode.com/problems/longest-palindromic-subsequence/).

#### Practice Questions

- [Longest Substring Without Repeating Characters](https://leetcode.com/problems/longest-substring-without-repeating-characters/)
- [Longest Repeating Character Replacement](https://leetcode.com/problems/longest-repeating-character-replacement/)
- [Minimum Window Substring](https://leetcode.com/problems/minimum-window-substring/description/)
- [Encode and Decode Strings](https://leetcode.com/problems/encode-and-decode-strings/)
- [Valid Anagram](https://leetcode.com/problems/valid-anagram)
- [Group Anagrams](https://leetcode.com/problems/group-anagrams/)
- [Valid Parentheses](https://leetcode.com/problems/valid-parentheses)
- [Valid Palindrome](https://leetcode.com/problems/valid-palindrome/)
- [Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/)
- [Palindromic Substrings](https://leetcode.com/problems/palindromic-substrings/)

## Tree

- A tree is an undirected, connected, acyclic graph.
- Recursion is a common approach for trees. When you notice the subtree problem can be used to solve the whole problem, you should try recursion.
- When using recursion, always remember to check for the base case, usually where the node is `null`.
- When you are asked to traverse a tree by level, use depth-first search.
- Sometimes it is possible that your recursive function needs to return two values.
- If the question involves summation of nodes along the way, be sure to check whether nodes can be negative.
- You should be very familiar with writing pre-order, in-order and post-order traversal recursively. As an extension, challenge yourself by writing them iteratively. Sometimes interviewers do ask candidates for the iterative approach, especially if the candidate finishes writing the recursive approach too fast.
- Corner cases:
  - Empty tree.
  - Single node.
  - Two nodes.
  - Very skewed tree (like a linked list).

**Binary Tree**

- In-order traversal of a binary tree is insufficient to uniquely serialize a tree. Pre-order or post-order traversal is also required.

**Binary Search Tree**

- In-order traversal of a BST will give you all elements in order.
- Be very familiar with the properties of a BST and validating that a binary tree is a BST. This comes up more often than expected.
- When a question involves a BST, the interviewer is usually looking for a solution which runs faster than O(n).

#### Practice Questions

- [Maximum Depth of Binary Tree](https://leetcode.com/problems/maximum-depth-of-binary-tree/)
- [Same Tree](https://leetcode.com/problems/same-tree/)
- [Invert/Flip Binary Tree](https://leetcode.com/problems/invert-binary-tree/)
- [Binary Tree Maximum Path Sum](https://leetcode.com/problems/binary-tree-maximum-path-sum/)
- [Binary Tree Level Order Traversal](https://leetcode.com/problems/binary-tree-level-order-traversal/)
- [Serialize and Deserialize Binary Tree](https://leetcode.com/problems/serialize-and-deserialize-binary-tree/)
- [Subtree of Another Tree](https://leetcode.com/problems/subtree-of-another-tree/)
- [Construct Binary Tree from Preorder and Inorder Traversal](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/)
- [Validate Binary Search Tree](https://leetcode.com/problems/validate-binary-search-tree/)
- [Kth Smallest Element in a BST](https://leetcode.com/problems/kth-smallest-element-in-a-bst/)
- [Lowest Common Ancestor of BST](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/)

## Trie

- Tries are special trees (prefix trees) that make searching and storing strings more efficient. Tries have many practical applications such as for searching and autocomplete. It will be helpful to know these common applications so that you can easily identify when a problem can be solved efficiently using a trie.
- Sometimes preprocessing a dictionary of words (given in a list) into a trie will improve the efficiency when searching for a word of length k among n words. Searching becomes O(k) instead of O(n).
- LeetCode has written a [very comprehensive article](https://leetcode.com/articles/implement-trie-prefix-tree/) on tries which you are highly encouraged to read.
- Be familiar with implementing a `Trie` class and its `add`, `remove` and `search` methods from scratch.

#### Practice Questions

- [Implement Trie (Prefix Tree)](https://leetcode.com/problems/implement-trie-prefix-tree)
- [Add and Search Word](https://leetcode.com/problems/add-and-search-word-data-structure-design)
- [Word Search II](https://leetcode.com/problems/word-search-ii/)

## Heap

- If you see a top/lowest K being mentioned in the question, it is usually a signal that a heap can be used to solve the problem.
- If you require the top K elements use a Min Heap of size K. Iterate through each element, pushing it into the heap. Whenever the heap size exceeds K, remove the minimum element, that will guarantee that you have the K largest elements.

#### Practice Questions

- [Merge K Sorted Lists](https://leetcode.com/problems/merge-k-sorted-lists/)
- [Top K Frequent Elements](https://leetcode.com/problems/top-k-frequent-elements/)
- [Find Median from Data Stream](https://leetcode.com/problems/find-median-from-data-stream/)

###### References

- http://blog.triplebyte.com/how-to-pass-a-programming-interview
- https://quip.com/q41AA3OmoZbC
- http://www.geeksforgeeks.org/must-do-coding-questions-for-companies-like-amazon-microsoft-adobe/
