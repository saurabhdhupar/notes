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

       如果没有 `{ action }` 就是说打印整行，如果 `pattern`少了，总是会匹配到，模式语法 通过换行符 或者 分号 分割.注意用的时候两边加引号 'pattern { action }'

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
              截取 s 的子串

       index(s, t)
              t 在 s 中出现的位置，如果没有就是 0

       match(s, r)
              正则表达式 r 在 s 中的位置，如果没有则为 0。 变量`RSTART`和`RLENGTH`被设置为匹配字符串的位置和长度。

       split(s, a, fs)
              将字符串 s 分解为数组元素 a[1]，a[2]，...，a[n]，并返回 n。 如果没有给出fs，则使用正则表达式fs或字段分隔符FS进行分离。 作为 字段分隔符的 空字符串 将字符串分割为 每个字符一个数组元素。

       sub(r, t, s)
              用 t 代替字符串 s 中正则表达式 r 的第一次出现。 如果 s 没有给出，则使用 $0。

       gsub   same as sub except that all occurrences of the regular expression are replaced; sub and gsub return the number of replacements.

       sprintf(fmt, expr, ... )
              the string resulting from formatting expr ...  according to the printf(3) format fmt

       system(cmd)
              executes cmd and returns its exit status

       tolower(str)
              returns a copy of str with all upper-case characters translated to their corresponding lower-case equivalents.

       toupper(str)
              returns a copy of str with all lower-case characters translated to their corresponding upper-case equivalents.

       function `getline` 将 $0 从当前输入文件设置为下一个输入记录; `getline <file` 将 $0设置为文件中的下一条记录。 `getline x`设置变量x。最后，`cmd | getline`将cmd的输出管道转换为getline; getline的每个调用返回cmd的下一行输出。 在所有情况下，getline返回 1:成功，0:文件结尾，-1:错误。

       模式(Patterns) 是 正则表达式(regular expressions) 和 关系表达式(relational expressions) 的任意布尔组合（`！` `||` `&&`）。 正则表达式在 re_format 中定义(参见 `man re_format`)。 模式中的隔离正则表达式适用于整行。 正则表达式也可能发生在关系表达式中，使用运算符`~`和`!~`。 `/re/`是一个常量正则表达式; 任何字符串（常量或变量）可以用作正则表达式，除了模式中的隔离正则表达式的位置。

       模式(A pattern) 可以由逗号(comma) 分隔的 两个模式(two patterns) 组成; 在这种情况下，从第一图案的出现而对所有行执行动作，但是出现第二图案。(the action is performed for all lines from an occurrence of the first pattern though an occurrence of the second.)

       关系表达式(relational expressions) 是下面的之一:

              expression matchop regular-expression
              expression relop expression
              expression in array-name
              (expr,expr,...) in array-name

       其中 relop 是C中的六个关系运算符中（`+ - * / % ^`）的任何一个，matchop是 `~`（匹配 matches）或 `!~`（不匹配）。 条件(conditional) 是算术表达式(arithmetic  expression)，关系表达式(relational expressions) 或这些 的布尔组合。


       特殊模式 `BEGIN` 和 `END` 可用于在 第一条输入行读取之前 和 之后 捕获控制。 `BEGIN`和`END`不结合其他模式。

       有特殊意义的变量名:

       CONVFMT
              转换数字时使用的转换格式（默认`％.6g`）

       FS     正则表达式用于分隔字段; 也可以通过选项 -Ffs 进行设置.

       NF     当前记录中的字段数

       NR     当前记录的序数

       FNR    当前文件中当前记录的序数

       FILENAME
              当前输入文件的名称

       RS     输入记录分隔符（默认换行符）

       OFS    输出字段分隔符（默认为空）

       ORS    输出记录分隔符（默认换行符）

       OFMT   数字输出格式（默认`％.6g`）

       SUBSEP 分离多个下标（默认为034）

       ARGC   argument count, assignable

       ARGV   参数数组，可分配; 非空成员将被视为文件名

       ENVIRON
              数组环境变量; 下标是名称.

       Functions 可以定义（在模式动作语句的位置）为：

              function foo(a, b, c) { ...; return x }

       参数通过值传递，如果是标量，并通过引用传递数组名称; 函数可以递归调用。 参数是函数本地的; 所有其他变量都是全局变量。 因此，可以通过在函数定义中提供过多的参数来创建局部变量。

       Parameters  are  passed by value if scalar and by reference if array name; functions may be called recursively.  Parameters are local to the function; all other variables are global.  Thus local variables may be created by providing excess parameters in the function definition.

# EXAMPLES
       length($0) > 72
              Print lines longer than 72 characters.
              > awk -F '\n'  'length($0) > 100' filename （自己加的）

       { print $2, $1 }
              Print first two fields in opposite order.
              > awk -F ' ' 'length($0) > 100 { print $4}'  Dev\ Tools\ Checklist.md

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
