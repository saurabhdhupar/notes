> https://leetcode.com/problems/island-perimeter/description/

You are given a map in form of a two-dimensional integer grid where 1 represents land and 0 represents water. Grid cells are connected horizontally/vertically (not diagonally). The grid is completely surrounded by water, and there is exactly one island (i.e., one or more connected land cells). The island doesn't have "lakes" (water inside that isn't connected to the water around the island). One cell is a square with side length 1. The grid is rectangular, width and height don't exceed 100. Determine the perimeter of the island.

Example:
```
[[0,1,0,0],
 [1,1,1,0],
 [0,1,0,0],
 [1,1,0,0]]

Answer: 16
Explanation: The perimeter is the 16 yellow stripes in the image below:

![island](./463.png)
```

- 每一个正方形都有四个边，所以4N
- 但是相邻的时候，会小时两个，一个是因为重叠，一个是因为在内部
- 所以逐行扫描，如果其「上部」左边或者上边有1，那么就认为是重叠

```go
func islandPerimeter(grid [][]int) int {
	s := 0
	for k1, v1 := range grid {
		for k2, v2 := range v1 {
			if v2 == 1 {
				s += 4
				if k1 > 0 && grid[k1-1][k2] == 1 {
					s -= 2
				}
				if k2 > 0 && grid[k1][k2-1] == 1 {
					s -= 2
				}
			}
		}
	}
	return s
}

func main() {
	fmt.Printf("%s\n", islandPerimeter([][]int{{0, 1, 0, 0}, {1, 1, 1, 0}, {0, 1, 0, 0}, {1, 1, 0, 0}}) == 16)
	fmt.Printf("%s\n", islandPerimeter([][]int{{1, 0}}) == 4)
}
