> BSD General Commands Manual

# NAME
     wc -- word, line, character, and byte 计数

# SYNOPSIS
     wc [-clmw] [file ...]

# DESCRIPTION
     wc 显示 每个输入文件中包含的行数 或者 标准输入/文件 中的word和byte 数 到标准输出。 行被定义为由`<newline>`字符分隔的字符串。 最后一个`<newline>`之后的字符不会包含在行数中


     A word is defined as a string of characters delimited by white space characters.  White space characters are the set of characters for which the iswspace(3) function returns true.  If more than one input file is specified, a line of cumulative counts for all the files is displayed on a separate line after the output for the last file.

     The following options are available:

     -c      每个输入文件中的 字节数 number of byte 将写入标准输出 standard output。

     -l      The number of lines in each input file is written to the standard output.

     -m      每个输入文件中的字符数 number of characters 将写入标准输出 standard output。 如果当前的区域设置不支持多字节字符 multibyte characters，则这相当于-c选项。 这将取消-c选项的任何先前使用

     -w      The number of words in each input file is written to the standard output.

     When an option is specified, wc only reports the information requested by that option.  The order of output always takes the form of line, word, byte, and file name.  The default action is equivalent to specifying the -c, -l and -w
     options.

     If no files are specified, the standard input is used and no file name is displayed.  The prompt will accept input until receiving EOF, or [^D] in most environments.

# ENVIRONMENT
     The LANG, LC_ALL and LC_CTYPE environment variables affect the execution of wc as described in environ(7).

# EXIT STATUS
     The wc utility exits 0 on success, and >0 if an error occurs.

# EXAMPLES
     Count the number of characters, words and lines in each of the files report1 and report2 as well as the totals for both:

           wc -mlw report1 report2

# COMPATIBILITY
     Historically, the wc utility was documented to define a word as a ``maximal string of characters delimited by <space>, <tab> or <newline> characters''.  The implementation, however, did not handle non-printing characters correctly so that
     ``  ^D^E  '' counted as 6 spaces, while ``foo^D^Ebar'' counted as 8 characters.  4BSD systems after 4.3BSD modified the implementation to be consistent with the documentation.  This implementation defines a ``word'' in terms of the
     iswspace(3) function, as required by IEEE Std 1003.2 (``POSIX.2'').

# SEE ALSO
     iswspace(3)
