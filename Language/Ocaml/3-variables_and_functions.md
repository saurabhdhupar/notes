# 第二章 变量和函数

## 变量
注意：所有的变量名字和必须以小写字母或者下划线开头
顶层绑定
```ocaml
utop # let x = 1;;
val x : int = 1
```
作用域定义并仅限于特定表达式
```ocaml
utop # let languages = "C,Python,Ocaml";;
val languages : string = "C,Python,Ocaml"

utop # let dashed_languages =
         let language_list = String.split languages ~on:',' in
           String.concat ~sep:"-" language_list (* need " not ' *)
       ;;
val dashed_languages : string = "C-Python-Ocaml"
```
`language_list`的作用域仅限于`String.concat ~sep:"-" language_list`，外部无法访问

内层作用域的绑定会遮蔽，或者说隐藏外层作用域中的定义 : 下面使用 `languages`代替`language_list`
```ocaml
utop # let dashed_languages =
         let languages = String.split languages ~on:',' in
           String.concat ~sep:"-" languages
       ;;
val dashed_languages : string = "C-Python-Ocaml"

utop # languages;;
- : string = "C,Python,Ocaml"
```

有一个惯用法就是使用一系列的`let`/`in`表达式来构建一个大型计算的各个组件。因此，我们可以这样写：
```ocaml
utop # let area_of_ring inner_radius outer_radius =
         let pi = acos(-1.) in
           let area_of_circle r = pi *. r *. r in
             area_of_circle outer_radius -. area_of_circle inner_radius
       ;;
val area_of_ring : float -> float -> float = <fun>

utop # area_of_ring 1. 3.;;
- : float = 25.1327412287
```

下面的代码会重新定义pi，但是对结果却没有影响，因为我们要使用的pi=3.14的地方的定义是正确的，重新定义的地方，对原来的地方不影响：
```ocaml
utop # let area_of_ring inner_radius outer_radius =
         let pi = acos (-1.) in
           let area_of_circle r = pi *. r *. r in
             let pi = 0. in
               area_of_circle outer_radius -. area_of_circle inner_radius
       ;;

Characters 144-146:
Warning 26: unused variable pi.
val area_of_ring : float -> float -> float = <fun>
```

在 OCaml中，let绑定是不可变的。OCaml 中有许多可变的值，我们会在第8章命令式编程中讨论，但是却没有可变的变量。
> 为什么变量不能变化

> OCaml 初学者的一个困惑就是变量是不可变的。这在语言学上也很奇怪，难道变量不是就可以变化的意思吗?

> 答案是，OCaml（通常还有其它函数式编程语言）中的变量更像是方程式中的变量，而非命令式语言中的变量。如果你考虑数学方程式x(y+z)=xy+xz，那么变量x、y和z就没有可变的意思。可变的意思是你可以给变量不同的值来实例化这个方程式，但是方程式依然是成立的。

> 在函数式语言中也是这样的。一个函数可以作用于不同的输入，因此其变量即使不能改变也会具有不同的值。

### 模式匹配和let
let绑定的另一个有用特性是支持在左边使用 模式
(List.unzip，这个函数可以将一个序对（pair）列表转变成两个列表的序对)
```ocaml
utop # let (ints, strings) = List.unzip [(1,"one"); (2,"two"); (3,"three")];;

val ints : int list = [1; 2; 3]
val strings : string list = ["one"; "two"; "three"]
```
其中(ints,strings)是一个模式，let绑定会赋值模式中出现的标识符

在let绑定中使用模式对于 **确凿的（irrefutable）** 模式更有意义，即，此类型的任何值都能保证匹配这个模式。元组和记录模式是确凿的，但列表模式不是

下面的代码，其实现了一个函数，将一个逗号分割的列表的第一个元素变成大写：
```ocaml
utop # let upcase_first_entry line =
         let (first :: rest) = String.split ~on:',' line in
           String.concat ~sep:"," (String.uppercase first :: rest)
       ;;

Characters 43-58:
Warning 8: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
[]
val upcase_first_entry : string -> string = <fun>
```
这种情况实际上永远不会发生，因为String.split总是会返回一个至少有一个元素的列表。但是编译器不知道这一点，所以它给出了警告。通常，使用match语句显式处理这种情况会更好：

```ocaml
utop # let upcase_first_entry line =
         match String.split ~on:',' line with
         | [] -> assert false (* String.split returns at least one element *)
         | first :: rest -> String.concat ~sep:"," (String.uppercase first :: rest)
       ;;
val upcase_first_entry : string -> string = <fun>
```
这是我们首次使用assert，它在标注不可能出现的情况时很有用。我们会在第7章错误处理中详细讨论。

## 函数

### 匿名函数
它们可以使用fun关键字声明，如下所示：
```ocaml
utop # (fun x -> x + 1);;
- : int -> int = <fun>

utop # (fun x -> x + 1) 9;;
- : int = 10

utop # List.map ~f:(fun x -> x + 1) [1;2;3];;
- : int list = [2; 3; 4]
```

```ocaml
utop # let increments = [ (fun x -> x + 1); (fun x -> x + 2) ] ;;
val increments : (int -> int) list = [<fun>; <fun>]

utop # List.map ~f:(fun g -> g 5) increments;;
- : int list = [6; 7]
```
使用let绑定，我们甚至可以像命名其它值一样命名函数：
```ocaml
utop # let jia_1 = (fun x -> x + 1);;
val jia_1 : int -> int = <fun>

utop # jia_1 2;;
- : int = 3
```
下面定义函数是语法糖，是简写：
```ocaml
utop # let jia_1 x = x + 1;;
val jia_1 : int -> int = <fun>
```
这是声明函数更常用也更方便的方法，不过抛开语法细节不说，这两种定义函数的方式是完全等价的。

> let和fun
>
> 函数和let绑定有许多互通性。在某种意义上，你可以把函数参数看成是一个由调用者绑定了输入值的变量。实际上，下面两个表达式几乎是一样的：
>
> # (fun x -> x + 1) 7;;
> - : int = 8
> # let x = 7 in x + 1;;
> - : int = 8
> 这种联系很重要，这在单子(monadic)风格编程中更明显，详见第18章使用Async 并行编程。

### 多参数函数
```ocaml
utop # let jueduizih a b = abs(a - b);;
val jueduizih : int -> int -> int = <fun>
```
```ocaml
utop # let juiduizhi = (fun x -> (fun y -> abs(x - y)));;
val juiduizhi : int -> int -> int = <fun>
```
```ocaml
utop # let jueduizih = (fun x y -> abs(x - y));;
val jueduizih : int -> int -> int = <fun>
```
这种风格的函数称为 **柯里化（curried）** 函数。(`Currying`是以 `Haskell Curry` 命名的，一位对编程语言设计和理论都有重大影响的逻辑学家。)解释柯里化函数签名的关键是`->`是右结合的。
柯里化也不仅仅是理论玩具。应用柯里化，你可以只提供一部分参数来特化一个函数。下面的例子中，我们创建了一个abs_diff的特化版本，来求给定的数到3的距离：

```ocaml
utop # let len_to_3 = jueduizih 3;;
val len_to_3 : int -> int = <fun>
```
这种在柯里化函数上应用部分参数得到一个新函数的实践叫 偏特化应用（partial application）。
在 OCaml 中，以完整参数调用一个柯里化的函数没有任何额外开销。（当然，偏特化函数会产生一点点额外的开销。）

柯里化不是 OCaml 中写多参数函数的唯一方法。使用元组不同字段作为不同参数也是可以的。
```ocaml
utop # let jueduizih (x, y) = abs(x - y);;
val jueduizih : int * int -> int = <fun>
```

OCaml处理这种调用约定也非常高效。特别是，通常都不必为了传递元组形式的参数而分配一个元组。当然，这时你就不能使用偏特化应用了。

这两种方法差异很小，但是大多数时候你都应该使用柯里化形式，因为它是 OCaml 中默认的风格。

### 递归函数
定义中又调用了自己的函数就是递归的。递归在任何编程语言中都很重要，但对函数式语言尤为如此，因为递归是函数式语言实现循环结构的手段。（第8章命令式编程中我们会详细介绍，OCaml 也支持像for和while这样的命令式循环结构，但是它们只在使用 OCaml 的命令式编程特性时才有用。）

要定义递归函数，你需要使用rec关键字将let绑定标记成递归的，下面是一个例子，是一个查找列表第一个重复元素序列的函数：
```ocaml
utop # let rec find_first_cf list =
         match list with
         | [] | [_] -> None
         | x :: y :: tl -> if x=y then Some x else find_first_cf (y :: tl)
       ;;
val find_first_cf : 'a list -> 'a option = <fun>
```
模式`[] | [_]` 是一个 或模式，是两个模式的组合，只要任何一个模式匹配即可。这里`[]`匹配空列表，`[_]`匹配只有一个元素的列表

使用let rec和and配合我们也能定义多个交互递归的值。下面是一个（天生低效的）例子：
```ocaml
utop # let rec
         is_even x = if x = 0 then true else is_old(x - 1)
         and is_old x = if x = 0 then false else is_even(x - 1)
       ;;
val is_even : int -> bool = <fun>
val is_old : int -> bool = <fun>
```
```ocaml
utop # List.map ~f:is_even [0;1;2;3;4;5];;
- : bool list = [true; false; true; false; true; false]

utop # List.map ~f:is_old [0;1;2;3;4;5];;
- : bool list = [false; true; false; true; false; true]
```

OCaml 需要区分非递归定义（用let）和递归定义（用let rec）主要是技术原因：类型推导算法需要知道何时一组函数定义是交互递归的，并且出于一些像 Haskell 这样的纯函数式语言中没有原因，这需要程序员自己显式标注。

> 到底是啥原因呢?:( Lisp 也不纯啊！ by clark。

但这个决策也有一些好处。一个原因是，递归（特别是交互递归）定义比非递归更难推理。所以如果在没有显式rec的地方，你就可以认为这个let绑定一定只能是基于之前的绑定，这一点是有意义的。

另外，有一个单独的非递归形式也使得通过遮蔽来创建一个新的定义以替代一个已存在的定义更为容易。

### 前缀和中缀操作符
前缀
```ocaml
utop # Int.max 3 4;;
- : int = 4
```
中缀
```ocaml
utop # 3 + 4;;
- : int = 7
```
如果给中缀操作符加上括号，就可以像普通前缀函数一样使用了：
```ocaml
utop # (+) 3 4;;
- : int = 7

utop # List.map ~f:((+) 3) [4;5;6];;
- : int list = [7; 8; 9]
```
第二个表达式中，我们通用偏特化(+)创建了一个将参数加3的函数。

如果函数名是下面的标识符，就会被当成操作符，也包括完全由多个下面字符组成的标识符：
```ocaml
! $ % & * + - . / : < = > ? @ ^ | ~
```

还有几个预先确定的字符串也是操作符，包括mod，取模操作符，和lsl，表示“逻辑左移（logical shift left）”，一个位移操作符。
我们可以定义（或重定义）一个操作符的含义。下面例子中是一个作用于int序对的向量加法操作符：
int * int 表示一个包含两个int的元组
```ocaml
utop # let (+!) (x1,y1) (x2,y2) = (x1 + x2, y1 + y2);;
val ( +! ) : int * int -> int * int -> int * int = <fun>

utop # (1,2) +! (3,4);;
- : int * int = (4, 6)
```

处理包含*的操作符要小心。看下面的例子：
```ocaml
utop # let (***) x y = (x ** y) ** y;;
Error: Unbound value x
```
上面的错误是因为`(***)`没有被解析成操作符，而是被看成了注释！要正确工作，我们需要在*前面 **或** 后面加上空格：
```ocaml
utop # let ( *** ) x y = (x ** y) ** y;;
val ( *** ) : float -> float -> float = <fun>
```
操作符的语法角色主要是前一到两个字符决定的，鲜有例外。下表将不同的操作符和其它语法形式按优先级从高到低分组，并分别解释了其语法行为。我们用!...来表示以!开头的这类操作符。

| Prefix                                           |Usage |
| ------------------------------------------------ | ---- |
|`!..., ?..., ~...` 	                           |前缀  |
|`., .(, .[`                                       |   -   |
|`function application, constructor, assert, lazy` |左结合|
|`-, -.` 	                                       |前缀  |
|`**..., lsl, lsr, asr` 	                       |右结合|
|`*..., /..., %..., mod, land, lor, lxor` 	       |左结合|
|`+..., -...` 	                                       |左结合|
|`::` 	                                           |右结合|
|`@..., ^...` 	                                   |右结合|
|`=..., <..., >...,` &#124;..., `&..., $...` 	   |左结合|
|`&, &&` 	                                       |右结合|
|`or`, &#124;&#124;                                |右结合|
|`,` 	                                           | -     |
|`<-, :=` 	                                       |右结合|
|`if` 	                                           | -     |
|`;` 	                                           |右结合|

有一个很重要的特殊情况：-和-.，整数和浮点数减法运算符，可以即当前缀操作符（负数）也当中缀操作符（减法），因此-x和x - y都是正确的表达式。
还有一点要注意的就是负数操作的优先比函数调用低，就是说你需要括号来传递一个负数，如下所示:
```ocaml
utop # Int.max 3 (-4);;
- : int = 3

utop # Int.max 3 -4;;
Error: This expression has type int -> int
       but an expression was expected of type int
```
第二个会被解释为
```ocaml
utop # (Int.max 3) -4;;
```


下面的例子中是一个非常有用的操作符，来自标准库，其行为严格依赖上面提到的优先级规则：
```ocaml
utop # let (|>) x f  = f x;;
val ( |> ) : 'a -> ('a -> 'b) -> 'b = <fun>
```
乍一看其作用并不明显：它只是接收一个值和一个函数，然后把函数应用到值上。尽管这个描述听起来平淡无奇，它却在顺序操作时扮演重要角色，这和 UNIX 管道神似。

考虑下面的代码，可以无重复地打印出你PATH中的元素。
下面的List.dedup通过使用给定的比较函数排序来从一个列表中消除重复：
```ocaml
utop # let path = "/Users/chyroc/.opam/system/bin:/Users/chyroc/.nvm/versions/node/v7.6.0/bin:/opt/local/bin:/Users/chyroc/Desktop/software/command:/Users/chyroc/.pyenv/shims:/Users/chyroc/.opam/system/bin:/opt/local/bin:/Users/chyroc/Desktop/software/command:/Users/chyroc/.pyenv/shims:/Users/chyroc/.opam/system/bin:/opt/local/bin:/Users/chyroc/Desktop/software/command:/Users/chyroc/.pyenv/shims:/Users/chyroc/.opam/system/bin:/opt/local/bin:/Users/chyroc/Desktop/software/command:/Users/chyroc/.pyenv/shims:/Users/chyroc/.rvm/gems/ruby-2.4.0/bin:/Users/chyroc/.rvm/gems/ruby-2.4.0@global/bin:/Users/chyroc/.rvm/rubies/ruby-2.4.0/bin:/Users/chyroc/.opam/system/bin:/opt/local/bin:/Users/chyroc/Desktop/software/command:/Users/chyroc/.pyenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Applications/Wireshark.app/Contents/MacOS:/Users/chyroc/.local/bin:/Users/chyroc/.cabal/bin:/Applications/ghc-7.10.3.app/Contents/bin:/usr/local/bin/hadoop:/Users/chyroc/Desktop/software/lib/ngrok:/Users/chyroc/Desktop/software/lib/sqoop2/bin:/Users/chyroc/.yarn/bin";;

utop # String.split ~on:':' path
         |> List.dedup ~compare:String.compare
           |> List.iter ~f:print_endline
       ;;

/Applications/Wireshark.app/Contents/MacOS
/Applications/ghc-7.10.3.app/Contents/bin
/Users/chyroc/.cabal/bin
/Users/chyroc/.local/bin
/Users/chyroc/.nvm/versions/node/v7.6.0/bin
/Users/chyroc/.opam/system/bin
/Users/chyroc/.pyenv/shims
/Users/chyroc/.rvm/gems/ruby-2.4.0/bin
/Users/chyroc/.rvm/gems/ruby-2.4.0@global/bin
/Users/chyroc/.rvm/rubies/ruby-2.4.0/bin
/Users/chyroc/.yarn/bin
/Users/chyroc/Desktop/software/command
/Users/chyroc/Desktop/software/lib/ngrok
/Users/chyroc/Desktop/software/lib/sqoop2/bin
/bin
/opt/local/bin
/sbin
/usr/bin
/usr/local/bin
/usr/local/bin/hadoop
/usr/sbin
- : unit = ()
```

注意我们不用|>也能做到这一点，但是会有一些冗长：
```ocaml
utop # let split_path = String.split ~on:':' path in
         let deduped_path = List.dedup ~compare:String.compare split_path in
           List.iter ~f:print_endline deduped_path
       ;;
```

这里有一个很重要的方面就是偏特化应用。如，List.iter正常会接收两个参数：一个是对列表的每一个元素都调用的函数，还有一个用以迭代的列表。我们可以用完整的参数调用List.iter：
```ocaml
utop # List.iter ~f:print_endline ["Two"; "lines"];;
Two
lines
- : unit = ()
```
或者。我们可以只传给它函数参数，这样就会得到一个打印字符串列表的函数：
```ocaml
utop # List.iter ~f:print_endline;;
- : string list -> unit = <fun>
```
后面这个形式就是我们在上面|>管道中使用的。

注意|>能以预定的方式工作，因为它是左结合的。让我们看看如果使用右结合操作符会发生什么，比如(^>)：
```ocaml
utop # let (^>) x f = f x;;
val ( ^> ) : 'a -> ('a -> 'b) -> 'b = <fun>
```

```ocaml
utop # Sys.getenv_exn "PATH"
         ^> String.split ~on:':' path
           ^> List.dedup ~compare:String.compare
             ^> List.iter ~f:print_endline
       ;;
Error: This expression has type string list -> unit
but an expression was expected of type (string list -> string list) -> 'a
Type string list is not compatible with type string list -> string list
```
上面的类型错误乍一看挺迷惑人的。
事情是这样的，由于`^>`是右结合的，所以会试图把`List.dedup ~compare:String.compare`传给`List.iter ~f:print_endline`。
但是`List.iter ~f:print_endline`需要一个字符串列表作为输入，而不是一个函数。

除了类型错误，这个例子还强调了小心选择操作符的重要性，特别是结合性方面。


### 使用function声明函数
定义函数还有一个方法就是使用function关键字。和支持声明多参数（柯里化的）函数语法不同，function内建了模式匹配。例如：

```ocaml
utop # let some_or_zero = function
         | Some x -> x
         | None -> 0
       ;;
val some_or_zero : int option -> int = <fun>
```

```ocaml
utop # let some_or_zero num_opt =
         match num_opt with
           | Some x -> x
           | None -> 0
       ;;
val some_or_zero : int option -> int = <fun>
```

我们也可以把不同的函数声明风格组合在一起，下面的例子中，我们声明了一个有两个参数（柯里化）的函数，第二个参数使用模式匹配：
```ocaml
utop # let some_or_default default = function
         | Some x -> x
         | None -> default
       ;;
val some_or_default : 'a -> 'a option -> 'a = <fun>

utop # some_or_default 3 (Some 5);;
- : int = 5
utop # List.map ~f:(some_or_default 100) [Some 3; None; Some 4];;
- : int list = [3; 100; 4]
```

再一次注意使用偏特化创建了一个函数传给List.map这种用法。换句话说，some_or_default 100是通过只给some_or_default第一个参数来创建的函数。

### 标签参数

到目前为止，我们定义的函数都是通过位置，即，参数传给函数的顺序，来区分参数的。OCaml 也支持标签参数，允许你可以使用名称来标识参数。实际上，我们已经碰到过 Core 中一些使用标签参数的函数，如List.map。标签参数用一个波浪号前缀标注，并在需要标签的变量前使用一个标签（后面跟着一个分号）。下面是一个例子：

```ocaml
utop # let ratio ~num ~denom = float num /. float denom;;
val ratio : num:int -> denom:int -> float = <fun>

utop # ratio ~num:3 ~denom:10;;
- : float = 0.3

utop # ratio ~denom:10 ~num:3;;
- : float = 0.3
```
OCaml 也支持 标签双关（label punning），如果标签和和变量名同名，那么你就可以不用:及后面的部分了。实际上，上面在定义ratio时我们已经使用了标签双关。下面展示了如何在函数调用中使用双关：

```ocaml

```
