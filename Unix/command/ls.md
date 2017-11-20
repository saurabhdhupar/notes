> BSD General Commands Manual

# NAME
ls -- 列出文件夹内容

# SYNOPSIS
ls [-ABCFGHLOPRSTUW@abcdefghiklmnopqrstuwx1] [file ...]

# DESCRIPTION
对于非文件夹，显示所有相关的，请求的信息；对于文件夹，显示文件夹内文件列表，也包括相关的所请求的信息。

如果没有 operands 给出，当前目录的信息被展示；如果给了超过一个 operand ，非文件夹 operand 将会被首先展示；文件夹和非文件夹将分别根据字典序排序

可以使用下列 options

#### -@
Display extended attribute keys and sizes in long (-l) output

#### -1
输出的结果每行只有一个（对于非输出到 terminal的，这个是默认选项）

意思就是 ls > ls.txt，ls.txt里面就是默认有 `-1` 参数

#### -A
列出除了 `.` / `...` 外的所有文件

#### -a
还包括以 `.` 开头的文件夹

#### -B
Force printing of non-printable characters (as defined by ctype(3) and current locale settings) in file names as \xxx, where xxx is the numeric value of the character in octal

#### -b
和 -B一样，但尽可能使用 C 转码

#### -C
强制输出多行，在 terminal 的时候，是默认选项

#### -c
Use time when file status was last changed for sorting (-t) or long printing (-l).

#### -d
文件夹作为文件处理，不会搜索里面的内容

#### -e
显示 Access Control List (ACL)

#### -F
- 文件夹后显示 `/`
- 可执行文件后显示 `*`
- 链接后显示 `@`
- socket后显示 `=`
- whiteout 后显示 `%`
- FIFO 后显示 `|`

#### -f
结果不排序，这个会打开 `-a`(显示.开头的)

#### -G
显示颜色

#### -g
This option is only available for compatibility with POSIX; it is used to display the group name in the long (-l) format output (the owner name is suppressed).

#### -H
Symbolic links on the command line are followed.  This option is assumed if none of the -F, -d, or -l options are specified

#### -h
如果和 `-l` 一起用，会显示文件大小 B,K,M,G,T的单位，以减少显示的数字（以2为底）

#### -i
在每一行打印文件序列号 file serial number (inode number).

#### -k
If the -s option is specified, print the file size allocation in kilobytes, not blocks.  This option overrides the environment variable BLOCKSIZE

#### -L
遵循所有符号链接到最终目标，并列出链接引用的文件或目录，而不是链接本身。 该选项取消-P选项

#### -l
以长模式列出，如果输出在terminal上，文件占用的总空间大小将会被输出到最上面的一行

#### -m
流式输出，以逗号作为分隔符列出所有的文件

#### -n
以数字方式显示用户和组的id，而不是以 `-l`方式将其转会为它的名字，这个选项会打开 `-l`

#### -O
Include the file flags in a long (-l) output

#### -o
去掉了 group id 的 `-l`模式

#### -P
如果参数是一个符号链接，那么列出链接本身，而不是他所指向的对象
这个选项会取消 `-H`和 `-L`

#### -p
如果是目录，在后面加上一个 `/`

#### -q
强制打印 文件名中 的 非图形字符（non-graphic characters） 为 `?`，如果是输出到 terminal，这是默认选项

#### -R
递归打印所有文件夹和文件

#### -r
反向排序（Reverse the order of the sort to get reverse lexicographical order or the oldest entries first (or largest files last, if combined with sort by size）

#### -S
以文件大小排序

#### -s
显示每个文件实际占用的 系统文件块 system blocks，以 512-byte 为单位，向上取整。
如果是输出到终端，那么在所有行的上面加一行总块数，环境变量 BLOCKSIZE 将会覆盖 512

#### -T
使用 `-l`模式的时候，会显示文件的所有时间的信息，包括 month, day, hour, minute, second, and year

#### -t
在按字典排序之前，先用修改时间排序（最近修改的在前面）

#### -u
使用最后使用时间排序

#### -U
使用创建时间。。

#### -v
强制直接打印非可可打印字符 unedited printing ，如果输出不是终端，那么这是默认的

#### -W
Display whiteouts when scanning directories.  (-S) flag).

#### -w
Force raw printing of non-printable characters.  This is the default when output is not to a terminal

#### -x
和 `-C`一样的，除了：`-C`是按照行来组织数据的，而 `-x`是按照列来组织数据

### 注意
- `-1`, `-C`, `-x`, and `-l`会相互覆盖掉，使用最后一个选项
- `-c`, `-u` 同上
- `-B`, `-b`, `-w`, and `-q`对于 non-printable characters 也是
- `-H`, `-L` and `-P`也是
- 默认每一行一个条目，除非是 输出到终端 / `-C` / `-x`
- 可以使用 `-i`, `-s`, and `-l` 选项来以 <blank>s 显示文件信息

# The Long Format
  ...

# DIAGNOSTICS
The ls utility exits 0 on success, and >0 if an error occurs.

# SEE ALSO
chflags(1), chmod(1), sort(1), xterm(1), compat(5), termcap(5), symlink(7), sticky(8)
