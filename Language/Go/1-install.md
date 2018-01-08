
## Mac Golang 安装
read  [https://golang.org/doc/install](https://golang.org/doc/install)

- 从[这个页面](https://golang.org/dl/)下载
- 按照提示安装上面下载的软件
- `echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.zshrc`
- `go version`

## Test install
`mkdir test_golang && cd test_golang && touch hello.go`
然后将下列内容写入`hello.go`
```go
package main

import "fmt"

func main() {
    fmt.Printf("hello, world\n")
}
```

```bash
go build
./test_golang
```
如果看见`hello, world`就表示成功了
