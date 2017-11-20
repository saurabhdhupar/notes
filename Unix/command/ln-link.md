> BSD General Commands Manual

# NAME
     link, ln -- make links

# SYNOPSIS
     ln [-Ffhinsv] source_file [target_file]
     ln [-Ffhinsv] source_file ... target_dir
     link source_file target_file

# DESCRIPTION
     `ln`会创建具有目标文件、目录相同mode的链接（links），对于各个文件分散到不同地方，可以用这种方法收集起来。有两种链接（links），硬链接（hard links）和软链接（symbolic links）。

     可选参数:

     -F    如果目标文件以及存在，并且是一个文件夹，然后删除他所以这个链接就可以成功建立了。`-F`应该和`-f`或者`-i`一起使用。如果没有任何一个被指定，默认就是`-f`。除非指定了`-s`，否则`-F`就是一个没什么用的参数。

     -h    如果目标文件或者目标文件夹是一个软连接，那么 do not follow it 。This is most useful with the -f option, to replace a symlink which may point to a directory.

     -f    如果目标文件以及存在，然后会 unlink他，以使链接成功，`-f`参数会覆盖之前的`-i`参数。

     -i    如果目标文件存在，那么就像标准错误写入提示。如果标准输入的响应以 `y` 或者 `Y`开头，那么久unlink这个文件以使链接成功，否则，不再重试链接。`-i`参数会覆盖之前的任何`-f`参数

     -n    和`-h`一样，和其他的`ln`兼容.

     -s    创建软链接.

     -v    显示详细信息.

     默认：创建硬链接。硬链接和原始文件无法区分；任何修改都和引用这个文件的链接无关。硬链接不能指向目录，也不能夸文件系统。

     软链接包含他指向的文件的名字，当打开一个链接的时候，会使用这个文件。软链接上面的`stat(2)`将会显示指向的文件的。`lstat(2) `包含了链接的信息。`readlink(2)`可以被调用以读取软链接的内容。软链接可以跨文件系统，可以指向目录。

     给定一个或者两个参数，`ln`创建一个指向存在文件的链接。如果目标文件给了，那么链接就是那个名字；目标文件也可以是一个防止链接的目录；否则，他会指向当前目录。如果只有目录指定了，那么链接会到最后一个资源？？？？？

     给定多余两个参数，`ln`会在目标目录里面创建链接，指向所有的资源文件。链接个被指向的文件具有相同的名字。

     当本程序使用`link`调用的时候，必须执行两个参数，这两个参数都不能指定目录。No options may be supplied in this simple mode of operation, which performs a link(2) operation using the two passed arguments.？？？？、

# COMPATIBILITY
     The -h, -i, -n and -v options are non-standard and their use in scripts is not recommended.  They are provided solely for compatibility with other ln implementations.

     The -F option is FreeBSD extention and should not be used in portable scripts.

# SEE ALSO
     link(2), lstat(2), readlink(2), stat(2), symlink(2), symlink(7)
