> BSD General Commands Manual

# NAME
     cat -- 连接和打印文件

# SYNOPSIS
     cat [-benstuv] [file ...]

# DESCRIPTION
     cat 从文件中读数据，然后输出到 `standard output`。The file operands are processed in command-line order。如果没有文件名或者是一个 `-`，那么就会从 `standard input` 读取。
     如果文件是 `UNIX domain socket`，那么连上他，然后直到 `EOF` 之前读取。This complements the UNIX domain binding capabil-ity available in inetd(8).

     可选参数:

     -b      输出 非空行 的行号，从1开始

     -e      显示非打印字符（`non-printing characters`）(see the -v option)，并且在每一行的最后显示一个 `$`

     -n      和 `-b`一样，不过这个显示所有行的行号

     -s      把连续的多个空行 替换为 一个空行

     -t      显示非打印字符 (see the -v option), 将 tab 显示为 `^I`

     -u      禁用输出缓冲（`output buffering`）

     -v      Display non-printing characters so they are visible.  Control characters print as `^X` for control-X; the delete character (octal 0177) prints as `^?` .  Non-ASCII
             characters (with the high bit set) are printed as `M-` (for meta) followed by the character for the low 7 bits.

# EXIT STATUS
     The cat utility exits 0 on success, and >0 if an error occurs.

# EXAMPLES
     命令:

           cat file1

     将打印 file1 的内容到 standard output.

     命令:

           cat file1 file2 > file3

     将按照顺序读取 file1 和 file2 的内容，然后输出到 file3，如果file3 已经存在，那么会覆盖。阅读手册获取更多信息

     命令:

           cat file1 - file2 - file3

     will print the contents of file1, print data it receives from the standard input until it receives an EOF (`^D`) character, print the contents of file2, read and output con-
     tents of the standard input again, then finally output the contents of file3.  Note that if the standard input referred to a file, the second dash on the command-line would
     have no effect, since the entire contents of the file would have already been read and printed by cat when it encountered the first `-` operand.

# SEE ALSO
     head(1), more(1), pr(1), sh(1), tail(1), vis(1), zcat(1), setbuf(3)

# STANDARDS
     The flags [-benstv] are extensions to the specification.

# HISTORY
     A cat utility appeared in Version 1 AT&T UNIX.  Dennis Ritchie designed and wrote the first man page.  It appears to have been cat(1).

# BUGS
     Because of the shell language mechanism used to perform output redirection, the command `cat file1 file2 > file1` will cause the original data in file1 to be destroyed!

     The cat utility does not recognize multibyte characters when the -t or -v option is in effect.
