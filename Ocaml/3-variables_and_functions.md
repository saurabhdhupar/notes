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
