> BSD General Commands Manual

# NAME
     touch -- 改变文件使用和修改时间

# SYNOPSIS
     touch [-A [-][[hh]mm]SS] [-acfhm] [-r file] [-t [[CC]YY]MMDDhhmm[.SS]] file ...

# DESCRIPTION
     touch 会修改文件的修改和使用时间，如果文件不存在，会使用默认的权限创建文件

     默认情况下，touch 既改变修改时间，有人会改变使用时间。
     `-a`(access time)和 `-m`(modification time)可以单独修改使用时间和修改时间，两个都用就和默认没有啥区别了
     默认使用当前时间的timestamps，可以使用 `-t`指定时间，`-r`指定这些文件的时间
     The -A flag adjusts the values by a specified amount

     可以使用下列选项

     -A      使用指定的值修改文件的 修改时间和使用时间，用于修改被设置为错误的时间的文件.
             格式：  `[-][[hh]mm]SS`

                   -       默认是 将时间调整为 `文件上面的旧时间` 后多少多少，加 `-`就是前.
                   hh      小时数, from 00 to 99.
                   mm      分钟数, from 00 to 59.
                   SS      秒数, from 00 to 59.

             默认包含 `-c` ,如果文件不存在，会被忽略

     -a      改变使用时间

     -c      如果文件不存在，不会去创建.

     -f      强制更新，即使权限不允许.

     -h      如果文件是一个链接，会改变链接本身，而不是它所指向的文件， Note that -h implies -c and thus will not create any new files.

     -m      改变修改时间.

     -r      使用指定文件的使用和修改时间来修改这个文件的 .. 时间

     -t      使用指定的时间修改，格式： `[[CC]YY]MMDDhhmm[.SS]`

                   CC      年的前两位 (即世纪).
                   YY      年的后两位. 如果 `YY`指定了，而 `CC`没有指定，那么 `YY`在 69 - 99 之间会导致 `CC`为 19，否则是20
                   MM      月（01 - 12）
                   DD      日（01 - 31）
                   hh      时（00 - 23）
                   mm      分（00 - 59）
                   SS      秒（00 - 61）

             如果 `CC` 和 `YY` 没有指定，就会使用`今年`，如果 `SS`没有指定，那么默认是 `0`

# EXIT STATUS
     The touch utility exits 0 on success, and >0 if an error occurs.

# SEE ALSO
     utimes(2)
