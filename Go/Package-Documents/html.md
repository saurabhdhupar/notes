## Overview
转码 HTMl

## Function
```go
func EscapeString(s string) string
/*
转码 <, >, &, ' and "
UnescapeString(EscapeString(s)) == s 恒成立，反之不恒成立
*/
```

```go
func UnescapeString(s string) string
/*
是上面那个函数的反函数
但是范围比上面那个函数的范围要大，比如 "&aacute;" unescapes to "á"，但是上面那个函数不能这样
*/
```

## Subdirectories
template
