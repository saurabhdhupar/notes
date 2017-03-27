# I. 语言概念

## 介绍和计算器
```ocaml
utop # 1 + 2;;
- : int = 3

utop # 1 +. 2;;
Error: This expression has type int but an expression was expected of type float

utop # 1 +. 2.;;
Error: This expression has type int but an expression was expected of type float

utop # 1.2 +. 2.;;
- : float = 3.2

utop # sqrt 9.;;
- : float = 3.

utop # sqrt 9;;
Error: This expression has type int but an expression was expected of type float

utop # let x = 1 + 2;;
val x : int = 3

utop # let y = x + x;;
val y : int = 6

```

标点符号只允许使用`_`和`'`，并且变量名只能以小写字母或下划线开头
注意默认情况下， **utop** 不会打印下划线开头的变量。
```ocaml
utop # let a = 2;;
val a : int = 2

utop # let _a = 3;;

utop # let a' = 4;;
val a' : int = 4

utop # let Chen = 1;;
Error: Unbound constructor Chen

utop # let 6a = 1;;
Error: Invalid literal 6a

utop # let a-a = 1;;
Error: Syntax error
```

## 函数
```ocaml
utop # let square x = x * x ;;
val square : int -> int = <fun>

utop # square 2;;
- : int = 4

utop # square (square 2);;
- : int = 16

utop # let ratio x y = Float.of_int x /. Float.of_int y;;
val ratio : int -> int -> float = <fun>

utop # ratio 4 7;;
- : float = 0.571428571429
```

## 类型推导
```ocaml
utop # let sum_if_true test first second = (if test first then first else 0) + (if test second then second else 0);;
val sum_if_true : (int -> bool) -> int -> int -> int = <fun>

utop # let even x = x mod 2 = 0;;
val even : int -> bool = <fun>

utop # sum_if_true even 2 4;;
- : int = 6
```

## 泛型类型推导
```ocaml
utop # let first_if_true test x y = if test x then x else y;;
val first_if_true : ('a -> bool) -> 'a -> 'a -> 'a = <fun>

utop # let string_greater_6 s = String.length s > 6;;
val string_greater_6 : string -> bool = <fun>

utop # first_if_true string_greater_6 "qwertyu" "qwer";;
- : string = "qwertyu"

utop # let number_greater_6 n = n > 6;;
val number_greater_6 : int -> bool = <fun>

utop # first_if_true number_greater_6 5 10;;
- : int = 10

utop # first_if_true number_greater_6 5 "10";;
Error: This expression has type string but an expression was expected of int
```

## 元组，列表，option 和模式匹配

### 元组
构建和分解
```ocaml
utop # let a = (1, "one");;
val a : int * string = (1, "one")

utop # let (x, y) = a;;
val x : int = 1
val y : string = "one"

utop # let distance (x1, y1) (x2, y2) = sqrt((x1 -. x2) ** 2. +. (y1 -. y2) ** 2.);;
val distance : float * float -> float * float -> float = <fun>
```
### 列表
不能混用类型
```ocaml
utop # let languages = ["OCaml";"Perl";"C"];;
val languages : string list = ["OCaml"; "Perl"; "C"]

utop # let numbers = [3;"four";5];;
Error: This expression has type string but an expression was expected of int
```

### `Core` - `List`模块
```ocaml
utop # List.length languages;;
- : int = 3
```
```ocaml
utop # List.map languages ~f:String.length;;
- : int list = [5; 4; 1]
```
函数参数`List.length`通过标签`-f`传入，`-f`标志的是名字而不是位置，所以可以调换位置
```ocaml
utop # List.map ~f:String.length languages;;
- : int list = [5; 4; 1]
```

### `::`构造列表(参考`python` `append`)

实际上这里，还有上面，都是产生新的数据，而没有改变原来的数据
```ocaml
utop # "Python" :: languages;;
- : string list = ["Python"; "OCaml"; "Perl"; "C"]

utop # languages;;
- : string list = ["OCaml"; "Perl"; "C"]
```
等效：
```ocaml
utop # [1; 2; 3];;
- : int list = [1; 2; 3]

utop # 1 :: 2 :: 3 :: [];;
- : int list = [1; 2; 3]

utop # 1 :: ( 2 :: ( 3 :: []));;
- : int list = [1; 2; 3]
```

### 列表使用`;`，元组使用`,`
```ocaml
utop # 1,2,3;;
- : int * int * int = (1, 2, 3)
```
### 使用`@`构造列表（`python` `extend`）
```ocaml
utop # [1;2;3] @ [4;5;6];;
- : int list = [1; 2; 3; 4; 5; 6]
```
> 有一点必须记住，和`::`不同，`@`的时间复杂度不是常数级的，拼接两个列表的时间和第一个列表的长度成正比。

### 使用match的列表模式
```ocaml
utop # let my_favorite_language (my_favorite :: the_rest) = my_favorite;;
Characters 25-64
Warning 8: this pattern-matching is not exhaustive
Here is an example of a case that is not matched
[]

utop # my_favorite_language languages;;
- : string = "OCaml"

utop # my_favorite_language [];;
Exception: "Match_failure //toplevel//:1:25
Called from file "toplevel/toploop.ml", line 180, characters 17-56
```

使用`match xx with | xxx -> xxxx | yyy -> yyyy`
`(* A good default! *)`是注释
注释用`(*`和`*)`包围，可以任意嵌套，可以跨多行
```ocaml
utop # let my_favorite_language languages =
    match languages with
    | first :: the_rest -> first
    | [] -> "[]" (* A good default! *)
 ;;

utop # my_favorite_language [];;
- : string = "[]"
```

### 递归列表函数
必须使用`rec`关键字才能使`sum`可以调用自身
按照 OCaml 惯用法，我们使用`hd`引用列表头，用`tl`引用列表尾
```ocaml
utop # let rec sum l =
    match l with
    | [] -> 0                   (* base case *)
    | hd :: tl -> hd + sum tl   (* inductive case *)
  ;;
val sum : int list -> int = <fun>

utop # sum [1; 2; 3];;
- : int = 6
```

下面是一个消除列表中连续重复的函数：
```ocaml
utop # let rec destutter list =
    match list with
    | [] -> []
    | hd1 :: hd2 :: tl ->
      if hd1 = hd2 then destutter (hd2 :: tl)
      else hd1 :: destutter (hd2 :: tl)
  ;;

Characters 29-171:
Warning 8: this pattern-matching is not exhaustive. Here is an example of a value that is not matched:
_::[]val destutter : 'a list -> 'a list = <fun>
```

```ocaml
utop # let rec destutter list =
    match list with
    | [] -> []
    | [hd] -> [hd]
    | hd1 :: hd2 :: tl ->
      if hd1 = hd2 then destutter (hd2 :: tl)
      else hd1 :: destutter (hd2 :: tl)
  ;;
val destutter : 'a list -> 'a list = <fun>
# destutter ["hey";"hey";"hey";"man!"];;
- : string list = ["hey"; "man!"]
```
`[hd]`匹配只有一个元素的列表
`[x;y;z]`匹配有三个元素的列表，并且绑定到x, y, z
`hd1 :: hd2 :: tl`的意思是将`list`的前两个赋给`hd1` `hd2`，剩下的给`tl`

### Options
`option`用以表示一个可能存在或不存在的值
```ocaml
utop # let divide x y = if y = 0 then None else Some (x/y) ;;
val divide : int -> int -> int option = <fun>

```
