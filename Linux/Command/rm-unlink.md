> BSD General Commands Manual

# NAME
     rm, unlink -- 删除文件

# SYNOPSIS
     rm [-dfiPRrvW] file ...
     unlink file

# DESCRIPTION
     rm 删除非文件夹类型的文件，如果没有权限的话，会在终端进行确认

     可选参数:

     -d          删除其他类型的文件（如文件夹）.

     -f          强制删除，不管不顾，如果文件不存在，不会报错。覆盖之前的 `-i`参数

     -i          不管啥文件，都要确认，覆盖之前的 `-f` 参数

     -P          删除之前覆盖三次，分别是 ：byte pattern 0xff, then 0x00, and then 0xff again

     -R, -r      如果遇到文件夹，会循环删除文件夹所有数据，（也就是默认带上了 `-d`参数）

     -v          显示删除的详细信息

     -W          尝试恢复删除的文件，只能通过 whiteouts 恢复.

     删除链接，是删除他们自身，而不是指向的文件.

     试图删除 `.` or `..`是错误的.

     当作为 unlink调用的时候，只有一个不能是目录的参数，不能有可选参数.

     如果所有文件删除成功，以 0 退出。If an error occurs, rm exits with a value >0.

# NOTE
     The rm command uses getopt(3) to parse its arguments, which allows it to accept the `--' option which will cause it to stop processing flag options at that point.  This will
     allow the removal of file names that begin with a dash (`-').  For example:
           rm -- -filename
     The same behavior can be obtained by using an absolute or relative path reference.  For example:
           rm /home/user/-filename
           rm ./-filename

# SEE ALSO
     rmdir(1), undelete(2), unlink(2), fts(3), getopt(3), symlink(7)

# BUGS
     -P 参数是确认这个文件不是底层系统文件，只有普通文件可以被覆盖

# COMPATIBILITY
     The rm utility differs from historical implementations in that the -f option only masks attempts to remove non-existent files instead of masking a large variety of errors.
     The -v option is non-standard and its use in scripts is not recommended.

     Also, historical BSD implementations prompted on the standard output, not the standard error output.

# STANDARDS
     The rm command is almost IEEE Std 1003.2 (`POSIX.2`) compatible, except that POSIX requires rm to act like rmdir(1) when the file specified is a directory.  This implementa-
     tion requires the -d option if such behavior is desired.  This follows the historical behavior of rm with respect to directories.

     The simplified unlink command conforms to Version 2 of the Single UNIX Specification (`SUSv2`).
