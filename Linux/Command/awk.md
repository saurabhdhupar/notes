> AWK

# NAME
       awk - 面向模式的扫描和处理语言

# SYNOPSIS
       awk [ -F fs ] [ -v var=value ] [ 'prog' | -f progfile ] [ file ...  ]

# DESCRIPTION
       awk 扫描每一行，当匹配到某一行的时候执行操作。文件名是标准输入，任何 var=value 被视为是赋值而不是文件名，如果是文件名就会被打开。The option -v followed by var=value is an assignment to be done before prog is  executed; any number of -v options may be present.  The -F fs option defines the input field separator to be the regular expression fs.

       输入的行通常用 空白符 或者 正则表达式FS 分开，然后分别用 $1, $2, ..., 表示，$0指整行。如果 FS 为 null，则每个字符都被分开

       模式语法

              pattern { action }

       如果没有 `{ action }` 就是说打印整行，如果 `pattern`少了，总是会匹配到，模式语法 通过换行符 或者 分号 分割

       `action`是一系列 statement，可以是下面之一:

              if( expression ) statement [ else statement ]
              while( expression ) statement
              for( expression ; expression ; expression ) statement
              for( var in array ) statement
              do statement while( expression )
              break
              continue
              { [ statement ... ] }
              expression              # commonly var = expression
              print [ expression-list ] [ > expression ]
              printf format [ , expression-list ] [ > expression ]
              return [ expression ]
              next                    # skip remaining patterns on this input line
              nextfile                # skip rest of this file, open next, start at top
              delete array[ expression ]# delete an array element
              delete array            # delete all elements of array
              exit [ expression ]     # exit immediately; status is expression

       statement 以分号、换行符、右括号结尾。一个空的 statement-list 相当于 $0。字符串用 双引号（" "）括起来，with the usual C escapes  recognized  within。Expressions take 字符串或者数字，使用 操作符 `+` `-` `*` `/` `%` `^` 计算，然后用 空格 build （todo）起来。这些操作符：`!` `++` `--` `+=` `-=` `*=` `/=` `%=` `^=` `>` `>=` `<` `<=` `==` `!=` `?:`也是可以的哇。Variables may be  scalars,  array  elements  (denoted  x[i])  or fields.Variables 初始化为 null string。数组下标可以是任何字符串，不一定是数字。this allows for a form of associative memory。多个下标[i,j,k]是允许的，他们会 通过 SUBSEP 值 被连接起来。

       `print` 语法输出到标准输出中，如果有 `>file >>file`就输出到文件中，如果有 `|cmd`就输出到pipe中, 以the current  output field  separator分割,  并由输出记录分隔符终止。文件和cmd可以是字符串表示的名字 或者 括号表达式，在不同的表达式里的相同的字符串表示同一个打开的文件。`printf` 语法 格式化输出。内置函数 `close` 关闭文件或管道，内置函数 fflush  刷新缓冲为文件或者pipe。

       数学函数： `exp`, `log`, `sqrt`, `sin`, `cos`, `atan2` 已经内置. 其他的内置函数还有:

       length 获取输入参数的长度，没有参数就是 $0 的长度

       rand   (0,1) 之间的随机数

       srand  为随机设置种子，并返回之前的种子.

       int    转为整数

       substr(s, m, n)
              the n-character substring of s that begins at position m counted from 1.

       index(s, t)
              the position in s where the string t occurs, or 0 if it does not.

       match(s, r)
              the  position  in  s  where  the  regular expression r occurs, or 0 if it does not.  The variables RSTART and RLENGTH are set to the position and length of the matched
              string.

       split(s, a, fs)
              splits the string s into array elements a[1], a[2], ..., a[n], and returns n.  The separation is done with the regular expression fs or with the field separator FS  if
              fs is not given.  An empty string as field separator splits the string into one array element per character.

       sub(r, t, s)
              substitutes t for the first occurrence of the regular expression r in the string s.  If s is not given, $0 is used.

       gsub   same as sub except that all occurrences of the regular expression are replaced; sub and gsub return the number of replacements.

       sprintf(fmt, expr, ... )
              the string resulting from formatting expr ...  according to the printf(3) format fmt

       system(cmd)
              executes cmd and returns its exit status

       tolower(str)
              returns a copy of str with all upper-case characters translated to their corresponding lower-case equivalents.

       toupper(str)
              returns a copy of str with all lower-case characters translated to their corresponding upper-case equivalents.

       The ``function'' getline sets $0 to the next input record from the current input file; getline <file sets $0 to the next record from file.  getline x sets variable x instead.
       Finally, cmd | getline pipes the output of cmd into getline; each call of getline returns the next line of output from cmd.  In all cases, getline returns 1 for a  successful
       input, 0 for end of file, and -1 for an error.

       Patterns  are  arbitrary Boolean combinations (with ! || &&) of regular expressions and relational expressions.  Regular expressions are as defined in re_format(7).  Isolated
       regular expressions in a pattern apply to the entire line.  Regular expressions may also occur in relational expressions, using the operators ~ and !~.  /re/  is  a  constant
       regular expression; any string (constant or variable) may be used as a regular expression, except in the position of an isolated regular expression in a pattern.

       A  pattern  may consist of two patterns separated by a comma; in this case, the action is performed for all lines from an occurrence of the first pattern though an occurrence
       of the second.

       A relational expression is one of the following:

              expression matchop regular-expression
              expression relop expression
              expression in array-name
              (expr,expr,...) in array-name

       where a relop is any of the six relational operators in C, and a matchop is either ~ (matches) or !~ (does not match).  A conditional is an  arithmetic  expression,  a  rela-
       tional expression, or a Boolean combination of these.

       The special patterns BEGIN and END may be used to capture control before the first input line is read and after the last.  BEGIN and END do not combine with other patterns.

       Variable names with special meanings:

       CONVFMT
              conversion format used when converting numbers (default %.6g)

       FS     regular expression used to separate fields; also settable by option -Ffs.

       NF     number of fields in the current record

       NR     ordinal number of the current record

       FNR    ordinal number of the current record in the current file

       FILENAME
              the name of the current input file

       RS     input record separator (default newline)

       OFS    output field separator (default blank)

       ORS    output record separator (default newline)

       OFMT   output format for numbers (default %.6g)

       SUBSEP separates multiple subscripts (default 034)

       ARGC   argument count, assignable

       ARGV   argument array, assignable; non-null members are taken as filenames

       ENVIRON
              array of environment variables; subscripts are names.

       Functions may be defined (at the position of a pattern-action statement) thus:

              function foo(a, b, c) { ...; return x }

       Parameters  are  passed by value if scalar and by reference if array name; functions may be called recursively.  Parameters are local to the function; all other variables are
       global.  Thus local variables may be created by providing excess parameters in the function definition.

# EXAMPLES
       length($0) > 72
              Print lines longer than 72 characters.

       { print $2, $1 }
              Print first two fields in opposite order.

       BEGIN { FS = ",[ \t]*|[ \t]+" }
             { print $2, $1 }
              Same, with input fields separated by comma and/or blanks and tabs.

            { s += $1 }
       END  { print "sum is", s, " average is", s/NR }
              Add up first column, print sum and average.

       /start/, /stop/
              Print all lines between start/stop pairs.

       BEGIN     {    # Simulate echo(1)
            for (i = 1; i < ARGC; i++) printf "%s ", ARGV[i]
            printf "\n"
            exit }

# SEE ALSO
       lex(1), sed(1)
       A. V. Aho, B. W. Kernighan, P. J. Weinberger, The AWK Programming Language, Addison-Wesley, 1988.  ISBN 0-201-07981-X

# BUGS
       There are no explicit conversions between numbers and strings.  To force an expression to be treated as a number add 0 to it; to force it to be treated as a  string  concate-
       nate "" to it.
       The scope rules for variables in functions are a botch; the syntax is worse.
