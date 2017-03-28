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
`Some`和`None`是`option`值的构造器，就和`::`和`[]`是列表的构造器一样
```ocaml
utop # let divide x y = if y = 0 then None else Some (x/y) ;;
val divide : int -> int -> int option = <fun>
```

```ocaml
utop # let logger t m =
let time =
match t with
| Some x -> x
| None -> Time.now()
in
Time.to_sec_string time ^ " -- " ^ m
;;

```
### 使用`let`和`in`实现嵌套`let`
```ocaml
utop # let x = 7
in
x + x
;;
- : int = 14
```

```ocaml
utop # let a = 1 in
let b  = a + a in
a * b
;;
- : int = 2
```

### 记录(`Record`)和变体(`Variant`)
通过名字而不是位置标识
```ocaml
utop # type point2d = {x: float; y: float};;
type point2d = { x : float; y : float; }

utop # let p = {x = 2.; y = -1.2};;
val p : point2d = {x = 2.; y = -1.2}

utop # let p = {y = 2.; x = -1.2};;
val p : point2d = {x = -1.2; y = 2.}
```

`{x=..; y=..}`标识这是一个`point2d`，并且按照位置分配给了`x_pos`和`y_pos`
```ocaml
utop # let magnitude {x = x_pos; y = y_pos} =
sqrt(x_pos ** 2.0 +. y_pos ** 2.);;
val magnitude : point2d -> float = <fun>
```

双关绑定
```ocaml
utop # let magnitude {x; y} = sqrt(x ** 2.0 +. y ** 2.);;
val magnitude : point2d -> float = <fun>
```

使用`.`访问记录的字段
```ocaml
utop # let magnitude point = sqrt(point.x ** 2.0 +. point.y ** 2.);;
val magnitude : point2d -> float = <fun>
```

嵌套
```ocaml
utop # type circle = {center: point2d; radius: float}
type circle_desc  = { center: point2d; radius: float }
type rect_desc    = { lower_left: point2d; width: float; height: float }
type segment_desc = { endpoint1: point2d; endpoint2: point2d } ;;

type circle = { center : point2d; radius : float; }
type circle_desc = { center : point2d; radius : float; }
type rect_desc = { lower_left : point2d; width : float; height : float; }
type segment_desc = { endpoint1 : point2d; endpoint2 : point2d; }s
```

### 命令式编程
> OCaml 中默认的是函数式代码，使用变量绑定，大多数数据结构都是不可变的
> 但 OCaml 也为命令式编程提供了很好的支持，包含可变数据结构，如数组和哈希表等，还有像for和while循环这样的控制流结构

#### 数组（Array）
下面的例子说明数组是可变的
```ocaml
utop # let numbers = [| 1;2;3;4 |];;
val numbers : int array = [|1; 2; 3; 4|]

utop # numbers.(2);;
- : int = 3

utop # numbers.(2) <- 10;;
- : unit = ()

utop # numbers.(2);;
- : int = 10
```
.(i)语法用来引用一个数组元素，<-语法用以修改
> 上面出现的unit类型很有意思，它只能有一个值，就是()。这意味着unit的值不能传递任何信息，所以通常被用作占位符。因此，我们用uint作为设置可变字段这类操作的返回值，这类操作使用副作用而不是返回值和外界通信。它也被用作函数参数，表明函数不需要任何输入。和 C 语言以及 Java 语言中void的角色类似。

#### 可变记录字段
```ocaml
utop # type sum =
{ mutable sum: float;
  mutable sum_sq: float; (* sum of squares *)
  mutable samples: int;
};;

type sum = {
  mutable sum : float;
  mutable sum_sq : float;
  mutable samples : int;
}

utop # let mean rsum = rsum.sum /. float rsum.samples
       let stdev rsum = sqrt (rsum.sum_sq /. float rsum.samples -. (rsum.sum /. float rsum.samples) ** 2. );;

val mean : sum -> float = <fun>
val stdev : sum -> float = <fun>

utop # let create() = { sum = 0.; sum_sq = 0.; samples = 0 }
       let update rsum x =
         rsum.samples <- rsum.samples + 1;
         rsum.sum     <- rsum.sum     +. x;
         rsum.sum_sq  <- rsum.sum_sq  +. x *. x
       ;;

val create : unit -> sum = <fun>
val update : sum -> float -> unit = <fun>
```
> 注意上面代码中操作序列之间单引号的使用。当我们之写纯函数式代码时，这是不需要的，但是当写命令式代码时，就要开始使用它了

使用
```ocaml
utop # s;;
- : sum = {sum = 0.; sum_sq = 0.; samples = 0}

utop # List.iter [1.;3.;2.;-7.;4.;5.] ~f:(fun x -> update s x);;
- : unit = ()

utop # mean s;;
- : float = 1.33333333333

utop # stdev s;;
- : float = 3.94405318873
```
> 需要指出的是上面的算法在数学上是很幼稚的，面对删除操作时精度很底。你可以看看维基百科上的 [Algorithms for calculating variance](http://en.wikipedia.org/wiki/Algorithms_for_calculating_variance) ，特别关注一下加权增量和并行算法。


#### 引用（Ref）

我们可以使用`ref`创建一个单独的可变值。`ref`类型是标准库中预定义的，并没有什么特别的，它只是一个普通的记录类型，拥有一个名为`contents`的单独的可变字段:
```ocaml
utop # let x = {contents = 0};;
val x : int ref = {contents = 0}

utop # x.contents <- x.contents + 1;;
- : unit = ()
```
为了让`ref`更方便使用，定义了几个函数和操作符：
```ocaml
utop # let x = ref 0;; (* set a ref *)
val x : int ref = {contents = 0}

utop # !x;; (* get a ref: x.contents *)
- : int = 0

utop # x := !x + 1;; (* x.contents <- 1 *)
- : unit = ()

utop # !x;;
- : int = 1
```

自己实现上面的`ref`和操作符
```ocaml
utop # type 'a ref = { mutable contents : 'a }

       let ref x = { contents = x }
       let (!) r = r.contents
       let (:=) r x = r.contents <- x
       ;;

type 'a ref = { mutable contents : 'a; }
val ref : 'a -> 'a ref = <fun>
val ( ! ) : 'a ref -> 'a = <fun>
val ( := ) : 'a ref -> 'a -> unit = <fun>
```
`ref`前面的`'a`表示`ref`类型是多态的，和列表多态一样，指可以持有任何类型的值。
`!`和`:=`周围的括号是必须的，因为它们是操作符，而不是普通函数。

通过`ref`实现累加：
```ocaml
utop # let sum list =
         let sum = ref 0 in
         List.iter list ~f:(fun x -> sum := !sum +x);
         !sum
       ;;
val sum : int list -> int = <fun>
```

## For和while循环
使用`Random`模块作为随机源。`Random`从一个默认种子开始，但是你也可以调用`Random.self_init`来选择一个新的随机种子
`for`循环的关键字：`for`、`to`、`do`和`done`
```ocaml
utop # let permute array =
         let length = Array.length array in
         for i = 0 to length -2 do
           let j = i + 1 + Random.int (length - i - 1) in (* j is after i and before the and of the array *)
           let tmp = array.(i) in
           array.(i) <- array.(j);
           array.(j) <- tmp
         done
       ;;

val permute : 'a array -> unit = <fun>
```
使用
```ocaml
utop # let ar = Array.init 20 ~f:(fun i -> i);;
val ar : int array = [|0; 1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19|]
```

## 一个完整的程序
下面是代码，你可以保存到一个名为 sum.ml 的文件中。注意我们没有使用;;来结束表达式，因为在 toplevel 之外这是不需要的：
```ocaml
open Core.Std

let rec read_and_accumulate accum =
  let line = In_channel.input_line In_channel.stdin in
  match line with
  | None -> accum
  | Some x -> read_and_accumulate (accum +. Float.of_string x)

let () =
  printf "Total: %F\n" (read_and_accumulate 0.)
```
这是我们首次使用 OCaml 的输入输出例程。read_and_accumulate是一个递归函数，用In_channel.input_line来按行读取标准输入，每次迭代都使用更新后的累加值sum调用自身。input_line返回一个option值，None表明输入流结束。

read_and_accumulate返回后，需要打印和。这是使用printf命令完成的，它提供了类型安全的格式化字符串支持，就和你在许多其它语言看到的一样。格式化字符串由编译器解析并用以确定剩余参数的数量和类型。这里只有一个单独的格式化指令，%F，所以printf还需要一个float类型的参数。

编译和运行

我们使用 corebuild来编译我们的程序，这是一个在 ocamlbuild基础上的小包装器， ocamlbuild是一个使用 OCaml 编译器的构建工具。 corebuild脚本随Core一起安装，目的是传递使用Core的程序所需的标志：

`corebuild sum.native`

.native 后缀表示我们要构建本地可执行代码，我们会在第4章文件、模块和程序中详细讨论。构建完成后，我们就可以像其它命令行工具一样使用产生的结果。我们向 sum.native 输入一系列数字，一行一个，敲 Ctrl-D结束输入：

```
➜  2-file git:(ocaml-2-a_guide_tour-day-2) ✗ ./sum.native
12
23
45
Total: 80.
```
要创建一个真正有用的命令行程序还有许多工作要做，包括一个合适的命令行解析接口和更好的错误处理，所有这些会在第14章命令行解析中介绍。

## 下一步干什么

导览到此为止！还有许多特性没有介绍，许多细节需要解释，但我们希望你已经建立了对 OCaml 的大致印象，并在本书接下来的阅读中更舒服。
