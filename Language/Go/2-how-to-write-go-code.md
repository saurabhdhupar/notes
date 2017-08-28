## [怎么写Go代码](https://golang.org/doc/code.html)

### 介绍
这个文档介绍了一个简单的go包和[go tool](https://golang.org/cmd/go/)，fetch,build,install go packages的标准方式和命令行。

go tool需要你用指定的方法来组织你的代码，请仔细阅读这份文档，他包含了最简单的方式来开始你的go

这里有一个最简单的例子[视频](https://www.youtube.com/watch?v=XCsL89YtqCs)

### 代码组织方式

#### 概述
- Go程序员通常将他们的Go代码放在一个工作区
- 一个代码库包含很多版本控制的代码库（例如Git）
- 一个代码库包括一个或者多个包
- 一个代码库在一个文件里会有一个或者多个go源代码
- 一个包的路径决定了他的导入路径

请注意,这不同于其他编程环境中：每一个项目都有一个独立的工作空间，工作空间与版本控制存储库密切相关

#### 工作空间
工作区是一个目录层次结构，其根目录有三个目录。
- `src`包含了go眼袋吗
- `pkg`包含package objects
- `bin`包含了执行命令

`go tool`编译源代码到`pkg`和`bin`目录

`src`子目录通常包含多个版本控制的repo，来跟踪一个或者多个源码包

为了给你一个直观的感受，下面是一个例子：
```
bin/
    hello                          # command executable
    outyet                         # command executable
pkg/
    linux_amd64/
        github.com/golang/example/
            stringutil.a           # package object
src/
    github.com/golang/example/
        .git/                      # Git repository metadata
	hello/
	    hello.go               # command source
	outyet/
	    main.go                # command source
	    main_test.go           # test source
	stringutil/
	    reverse.go             # package source
	    reverse_test.go        # test source
    golang.org/x/image/
        .git/                      # Git repository metadata
	bmp/
	    reader.go              # package source
	    writer.go              # package source
    ... (many more repositories and packages omitted) ...
```

上面的树形结构包含了两个repo（`example`和`image`）。`example`repo有两个command(hello和outyet)和一个库（stringutil）。`image`repo包括bmp包和[一些其他的](https://godoc.org/golang.org/x/image)

一个工作空间通常包含许多含有许多packages和commands的源repo，大多数Go程序员把他们的源代码和依赖放在一个工作空间。

Commands and libraries是从不同的源代码构建的，[稍后](https://golang.org/doc/code.html#PackageNames)我们会讨论他们的不同

#### GOPATH系统变量

To use a custom workspace location, [set the GOPATH environment variable](https://golang.org/wiki/SettingGOPATH).

#### 导入路径

`import path`是一个唯一标识一个`package`的字符串，一个包的`import path`对应于他在本地或者远程的位置。

标准库可以使用简写模式，比如："fmt" and "net/http"。对于你自己的包，你需要选择一个不会和未来要加入份标准库或者第三方库冲突的`base path`。

在github上，`github.com/user`应该是`base path`。

so ,run: `mkdir -p $GOPATH/src/github.com/Chyroc`



#### 第一个程序

#### 第一个库

#### 包名

### 测试

### 远程包

### 下一步是什么

### 获取帮助
