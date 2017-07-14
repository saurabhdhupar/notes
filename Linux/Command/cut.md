> BSD General Commands Manual

# NAME
     cut -- 切出每一行的选择部分

# SYNOPSIS
     cut -b list [-n] [file ...]
     cut -c list [file ...]
     cut -f list [-d delim] [-s] [file ...]

# DESCRIPTION
     cut 从每个文件中的每一行（作为list） 选择所选部分，并将它们写入标准输出。 如果没有指定文件参数，或者文件参数是单个破折号（`-`），则从标准输入中读取。 由列表指定的项目可以是 列，也可以是以特殊字符分隔的 行。 列编号从1开始。

     list 参数是 逗号或空格 分隔的 数字 和/或 数字范围集合。 数字范围包括数字，破折号（`-`）和第二个数字，并从第一个数字到第二个数字（包括第一个数字）中选择字段或列。 数字 或 数字范围 之前 可以有一个破折号(`-`)，它可以选择从1到最后一个数字的所有字段或列。 数字或数字范围 后面 可以有一个破折号(`-`)，可以从最后一个数字到行尾的所有字段或列中选择。 数字和数字范围可以重复，重叠和任何顺序。 如果一个字段或列被多次指定，它将在输出中只显示一次。 选择输入行中不存在的字段或列不是错误.

     可选参数:

     -b list
             这个 list 指定的是 byte 位置.

     -c list
             这个 list 指定的是 character 位置.

     -d delim
             使用 delim 作为列分割符，而不是 tab character 制表符.

     -f list
             list 通过 `-d`指定的字符分割

     -n      不会拆分 多字节 字符。 如果选择了至少一个字节，字符将被输出，并且在零个或多个未选择字节的前缀之后，选择形成该字符的其余字节

     -s      禁止没有字段分隔符字符的行。 除非指定，否则没有分隔符的行通过未修改

# ENVIRONMENT
     `LANG`, `LC_ALL` and `LC_CTYPE`

# EXIT STATUS
     The cut utility exits 0 on success, and >0 if an error occurs.

# EXAMPLES
     Extract users' login names and shells from the system passwd(5) file as `name:shell` pairs:

           cut -d : -f 1,7 /etc/passwd

     Show the names and login times of the currently logged in users:

           who | cut -c 1-16,26-38

# SEE ALSO
     colrm(1), paste(1)
