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
