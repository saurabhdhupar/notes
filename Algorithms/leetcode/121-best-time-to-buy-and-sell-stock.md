> https://leetcode.com/problems/best-time-to-buy-and-sell-stock/description/

Say you have an array for which the ith element is the price of a given stock on day i.

If you were only permitted to complete at most one transaction (ie, buy one and sell one share of the stock), design an algorithm to find the maximum profit.

Example 1:
```
Input: [7, 1, 5, 3, 6, 4]
Output: 5
```

max. difference = 6-1 = 5 (not 7-1 = 6, as selling price needs to be larger than buying price)
Example 2:
```
Input: [7, 6, 4, 3, 1]
Output: 0
```

In this case, no transaction is done, i.e. max profit = 0.

- 最佳股票购买策略（先买后卖，只能买卖一次）
- 两层循环，i循环扫描，表示购买，j从i开始扫描，表示卖，记录i，j差值最大值

```go
func maxProfit(prices []int) int {
	m := 0
	for i := 0; i < len(prices); i++ {
		for j := i + 1; j < len(prices); j++ {
			t := prices[j] - prices[i]
			if t > m {
				m = t
			}
		}
	}
	return m
}
```