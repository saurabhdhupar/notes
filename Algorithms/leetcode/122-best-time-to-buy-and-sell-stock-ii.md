> https://leetcode.com/problems/best-time-to-buy-and-sell-stock-ii/solution/


Say you have an array for which the ith element is the price of a given stock on day i.

Design an algorithm to find the maximum profit. You may complete as many transactions as you like (ie, buy one and sell one share of the stock multiple times). However, you may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).

- 和121一样，求股票收益最大
- 但是允许多次买入卖出，但是同一时间最多持有一个股票
- 股票是升降的，只要在波谷买入，波峰卖出，即可赚钱

- 方法一
  - 一个循环，先找出一个波谷，再找出一个波峰
  - 因为需要先买入，所以先找波谷

```go
func maxProfit(prices []int) int {
	i := 0
	_max := 0
	_min := 0
	m := 0
	for i < len(prices)-1 {
		for i < len(prices)-1 && prices[i] >= prices[i+1] {
			i++
		}
		_min = prices[i]

		for i < len(prices)-1 && prices[i] <= prices[i+1] {
			i++
		}
		_max = prices[i]

		m += _max - _min
	}

	return m
}
```

- 方法二
  - 和方法一的思想是一致的
  - 想想一下求积分的那个阶梯

```go
func maxProfit(prices []int) int {
	i := 0
	m := 0
	for i < len(prices)-1 {
		cha := prices[i+1] - prices[i]
		if cha > 0 {
			m += cha
		}
		i++
	}

	return m
}
```