> https://leetcode.com/problems/count-primes/description/


Count the number of prime numbers less than a non-negative number, n.

Example:

```
Input: 10
Output: 4
Explanation: There are 4 prime numbers less than 10, they are 2, 3, 5, 7.
```

* 统计小于一个正数n的素数的个数（204）
  * 初始化一个n-1的数组m，每一个为true
  * 最小的素数是2，从2开始循环，直到n-1
    * 数组m中，下标i的倍数（跳过i本身）全部置为false
    * 跳过i本身：从`j=i*i`开始（本来是`2i`开始，但是2的循环已经把所有的i的2倍遍历掉了）:`j+=i`
    * 最后统计true的个数


```
package main

import "math"

func countPrimes(n int) int {
	if n <= 1 {
		return 0
	}
	var m = make([]bool, n-1)
	for i := 0; i < n-1; i++ {
		m[i] = true
	}
	// 0 > 1
	// 2 > 2
	// n-2 > n-1
	m[0] = false

	res := 0
	limit := int(math.Sqrt(float64(n)))

	for i := 2; i <= limit; i++ {
		if m[i-1] {
			for j := i * i; j < n; j += i {
				m[j-1] = false
			}
		}
	}
	for j := 0; j < n-1; j++ {
		if m[j] {
			res++
		}
	}
	return res
}

func main() {
	if x := countPrimes(10); x != 4 {
		panic(x)
	}
	if x := countPrimes(0); x != 0 {
		panic(x)
	}
}

```