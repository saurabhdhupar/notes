> BSD General Commands Manual

# NAME
     pwd -- 返回当前目录的名字

# SYNOPSIS
     pwd [-L | -P]

# DESCRIPTION
     输出当前目录的绝对路径.

     可选参数：

     -L      （默认是这个）显示 logical 路径.

     -P      显示 physical 路径 (all symbolic links resolved).

# ENVIRONMENT
     这个命令使用下列环境变量:

     PWD  Logical current working directory.

# EXIT STATUS
     The pwd utility exits 0 on success, and >0 if an error occurs.

# SEE ALSO
     builtin(1), cd(1), csh(1), sh(1), getcwd(3)

# BUGS
     In csh(1) the command dirs is always faster because it is built into that shell.  However, it can give a different answer in the rare case that the current directory or a con-
     taining directory was moved after the shell descended into it.

     The -L option does not work unless the PWD environment variable is exported by the shell.
