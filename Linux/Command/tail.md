> BSD General Commands Manual

# NAME
     tail -- 显示文件的最后一部分

# SYNOPSIS
     tail [-F | -f | -r] [-q] [-b number | -c number | -n number] [file ...]

# DESCRIPTION
     tail 展示文件内容 或者 标准输入 到 标准输出.

     The display begins at a byte, line or 512-byte block location in the input.  Numbers having a leading plus (`+') sign are relative to the beginning of the input, for example,
     ``-c +2'' starts the display at the second byte of the input.  Numbers having a leading minus (`-') sign or no explicit sign are relative to the end of the input, for example,
     ``-n 2'' displays the last two lines of the input.  The default starting location is ``-n 10'', or the last 10 lines of the input.

     可选参数:

     -b number
             显示最后 b 个 512-byte blocks.

     -c number
             显示最后 c 个 byte.

     -f      读到文件末尾也不会停止，而是等待新的数据加入，当标输入时一个 pipe 的时候 -f 被忽略（为什么），而不是 FIFO

     -F      和 -f 是一样的，但是会检测文件是否会被更改，改名啊什么的。The -F option implies the -f option, but tail will also check to see if the file being followed has been renamed or rotated.  The file is closed and reopened when tail
             detects that the filename being read from has a new inode number.  The -F option is ignored if reading from standard input rather than a file.

     -n number
             显示最后的 n 行.

     -q      当检查多个文件时，禁止标题的打印

     -r      反转 要显示的内容，这个时候需要显示指定  -b, -c and -n ，否则显示所有数据

     如果指定了多个文件，在每个内容块钱会显示 `==> XXX <==`，除非指定了 -q

# EXIT STATUS
     The tail utility exits 0 on success, and >0 if an error occurs.

# SEE ALSO
     cat(1), head(1), sed(1)

# STANDARDS
     The tail utility is expected to be a superset of the IEEE Std 1003.2-1992 (``POSIX.2'') specification.  In particular, the -F, -b and -r options are extensions to that stan-
     dard.

     The historic command line syntax of tail is supported by this implementation.  The only difference between this implementation and historic versions of tail, once the command
     line syntax translation has been done, is that the -b, -c and -n options modify the -r option, i.e., ``-r -c 4'' displays the last 4 characters of the last line of the input,
     while the historic tail (using the historic syntax ``-4cr'') would ignore the -c option and display the last 4 lines of the input.
