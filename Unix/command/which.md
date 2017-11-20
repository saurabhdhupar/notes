> BSD General Commands Manual
> WHICH(1)

# NAME
     which -- 找出程序路径

# SYNOPSIS
     which [-as] program ...

# DESCRIPTION
     which 输入一个 command 列表，返回他们的路径

     可选参数:

     -a      列出所有的 (而不是第一个).

     -s      没有输出，如果找到了返回0，否则返回1

     有一些命令返回说 内置的，参见：builtin(1) .

# SEE ALSO
     builtin(1), csh(1), find(1), locate(1), whereis(1)
