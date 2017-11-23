
#!/bin/bash
# 第一行表示以哪个shell执行
# 参见: http://en.wikipedia.org/wiki/Shebang_(Unix)
# #也用来注释

# 简单的你好世界例子
echo Hello world! # => Hello world!

# 每一行命令以新行或者分号开始
echo 'This is the first line'; echo 'This is the second line'
# => This is the first line
# => This is the second line

# 声明变量
Variable="Some string"

# 错误的声明变量方法
Variable = "Some string" # => 返回错误 "Variable: command not found"
# bash会认为Variable是一个命令而去执行，并且因为找到到这个命令而报错

# 另外一个错误的变量声明
Variable= 'Some string' # => 返回错误: "Some string: command not found"
# Bash will decide that 'Some string' is a command it must execute and give an
# error because it can't be found. (In this case the 'Variable=' part is seen
# as a variable assignment valid only for the scope of the 'Some string'
# command.)

# 使用变量:
echo $Variable # => Some string
echo "$Variable" # => Some string
echo '$Variable' # => $Variable
# 如果你要使用这个变量自身（赋值，导出，或者其他什么），不需要加上 $ ，
# 如果要使用变量的值，那么就需要 $ 
# 单引号特殊一点，就是变量这个名字的字符串

# 参数表达式 ${ }:
echo ${Variable} # => Some string
# 这是一个参数表达式的简单使用
# 从变量中获取一个值，然后对值进行一些操作
# 在这其中，可以对参数或者变量的值进行修改
# 下面是另外一些例子

# 字符串替换
echo ${Variable/Some/A} # => A string
# 用后面的替换前面的字符串

# 切片
Length=7
echo ${Variable:0:Length} # => Some st
# 只获取前7个字符

# 变量默认值
echo ${Foo:-"DefaultValueIfFooIsMissingOrEmpty"} 
# => DefaultValueIfFooIsMissingOrEmpty
# 当为 null (Foo=) 或者 空字符串(Foo="")的时候有用
# 如果foo是0，返回0
# 注意，他只是返回这个默认值，而不是改变变量的值为默认值

# Brace 表达式 { }
echo {1..10} # => 1 2 3 4 5 6 7 8 9 10
echo {a..z} # => a b c d e f g h i j k l m n o p q r s t u v w x y z
# This will output the range from the start value to the end value

# 内置变量:
echo "上一次程序返回值: $?"
echo "脚本 PID: $$"

# 脚本参数
echo "脚本参数的数量: $#"
echo "脚本的所有参数: $@"
echo "脚本的各个参数: $1 $2..."
echo "脚本第二个参数之后的参数：${@:2}"
echo "最后一个参数：${!#}"

# 变量就学完了

# `pwd` 获取当前目录
# 也可以使用内置变量 `$PWD` 获取当前目录
# We can also use the builtin variable `$PWD`.
# 下面的结果是相同的
echo "I'm in $(pwd)" # execs `pwd` and interpolates output
echo "I'm in $PWD" # interpolates the variable

# 如果你在terminal中有很多输出，可以使用 `clear` 清空屏幕

# 从输入中获取值
echo "What's your name?"
read Name # 不需要声明这个变量
echo Hello, $Name!

# We have the usual if structure:
# use 'man test' for more info about conditionals
# 条件判断
if [ $Name != $USER ]
then
    echo "Your name isn't your username"
else
    echo "Your name is your username"
fi

# 如果比较的一方为空，那么上面的表达式是：
if [ != $USER ]
# 这是一个不合法的表达式
# 所以安全的方式是使用下面的方式：
if [ "$Name" != $USER ] ...
这样的情况下，就算为空也不怕了
if [ "" != $USER ] ...

# 这也是一个条件式
echo "Always executed" || echo "Only executed if first command fails"
echo "Always executed" && echo "Only executed if first command does NOT fail"

# 如果要在条件表达式中使用 && 和 || ，需要在里面加上[]
if [ "$Name" == "Steve" ] && [ "$Age" -eq 15 ]
then
    echo "This will run if $Name is Steve AND $Age is 15."
fi

if [ "$Name" == "Daniya" ] || [ "$Name" == "Zach" ]
then
    echo "This will run if $Name is Daniya OR Zach."
fi

# 表达式 下面的格式表示
echo $(( 10 + 5 )) # => 15


# 这样使用来跨越目录（执行完之后仍然在第一个目录）
(echo "First, I'm here: $PWD") && (cd someDir; echo "Then, I'm here: $PWD")
pwd # still in first directory

# 重定向输入输出
# You can redirect command input and output (stdin, stdout, and stderr).
# Read from stdin until ^EOF$ and overwrite hello.py with the lines
# between "EOF":
cat > hello.py << EOF
#!/usr/bin/env python
from __future__ import print_function
import sys
print("#stdout", file=sys.stdout)
print("#stderr", file=sys.stderr)
for line in sys.stdin:
    print(line, file=sys.stdout)
EOF

python hello.py < "input.in" # input.in 作为输入
python hello.py > "output.out" # 重定向输出到 output.out
python hello.py 2> "error.err" # 重定向错误输出到 error.err
python hello.py >> "output.out" 2>> "error.err" # 输出和错误输出分别重定向到文件
python hello.py > "output-and-error.log" 2>&1 # 重定向输出和错误输出到 output-and-error.log
python hello.py > /dev/null 2>&1 # 忽略到输出和错误输出（重定向之后就看不见了）
# >  是覆盖
# >> 是添加


# Run a command and print its file descriptor (e.g. /dev/fd/123)
# see: man fd
echo <(echo "#helloworld")

# Overwrite output.out with "#helloworld":
cat > output.out <(echo "#helloworld")
echo "#helloworld" > output.out
echo "#helloworld" | cat > output.out
echo "#helloworld" | tee output.out >/dev/null

# $( ) 可以在一个命令中使用另外一个命令
echo "There are $(ls | wc -l) items here."

# ``也可以，但是不能嵌套，更推荐使用 $( )
echo "There are `ls | wc -l` items here."

# 使用 case 去 switch:
case "$Variable" in
    0) echo "There is a zero.";;
    1) echo "There is a one.";;
    *) echo "It is not null.";;
esac

# for 循环
for Variable in {1..3}
do
    echo "$Variable"
done
# => 1
# => 2
# => 3


# for循环
for
for ((a=1; a <= 3; a++))
do
    echo $a
done
# => 1
# => 2
# => 3

# for 循环
for Variable in file1 file2
do
    cat "$Variable"
done

# for 循环
for Output in $(ls)
do
    cat "$Output"
done

# while 循环:
while [ true ]
do
    echo "loop body here..."
    break
done
# => loop body here...

# 定义函数
function foo ()
{
    echo "Arguments work just like script arguments: $@"
    echo "And: $1 $2..."
    echo "This is a function"
    return 0
}

# 简单的定义函数
bar ()
{
    echo "Another way to declare functions!"
    return 0
}

# 调用函数
foo arg1 arg2
bar
foo "My name is" $Name
