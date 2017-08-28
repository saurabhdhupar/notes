from [Ocaml 99problems](http://ocaml.org/learn/tutorials/99problems.html)

### Working with lists

#### 1 Write a function `last : 'a list -> 'a option` that returns the last element of a list. (easy)
```ocaml
# last [ "a" ; "b" ; "c" ; "d" ];;
- : string option = Some "d"
# last [];;
- : 'a option = None
```
```ocaml
let rec last l =
  match l with
    | [] -> None
    | [x] -> Some x
    | hd::tl -> last tl
;;
```

#### 2 Find the last but one (last and penultimate) elements of a list. (easy)
```ocaml
# last_two [ "a" ; "b" ; "c" ; "d" ];;
- : (string * string) option = Some ("c", "d")
# last_two [ "a" ];;
- : (string * string) option = None
```
```ocaml
let rec last_two l =
  match l with
    | [] | [_] -> None
    | [x; y] -> Some (x, y)
    | hd::tl -> last_two tl
;;
```

#### 3 Find the `k`'th element of a list. (easy)
```ocaml
# at 3 [ "a" ; "b"; "c"; "d"; "e" ];;
- : string option = Some "c"
# at 3 [ "a" ];;
- : string option = None
```
```ocaml
????????
```

#### 4 Find the number of elements of a list. (easy)
OCaml standard library has List.length but we ask that you reimplement it. Bonus for a tail recursive solution.
```ocaml
# length [ "a" ; "b" ; "c"];;
- : int = 3
# length [];;
- : int = 0
```
```ocaml
let rec length l =
  match l with
    | [] -> 0
    | hd::tl -> 1 + length tl
;;
```

#### 5 Reverse a list. (easy)
OCaml standard library has `List.rev` but we ask that you reimplement it.
```ocaml
# rev ["a" ; "b" ; "c"];;
- : string list = ["c"; "b"; "a"]
```
```ocaml
let rec rev l = match l with
  | [] -> []
  | [x] -> [x]
  | hd::tl -> (rev tl) @ [hd]
;;
```

#### 6 Find out whether a list is a palindrome. (easy)
HINT: a palindrome is its own reverse.
```ocaml
# is_palindrome [ "x" ; "a" ; "m" ; "a" ; "x" ];;
- : bool = true
# not (is_palindrome [ "a" ; "b" ]);;
- : bool = true
```
```ocaml
let is_palindrome l =
  let rec rev l = match l with
    | [] -> []
    | [x] -> [x]
    | hd::tl -> (rev tl) @ [hd]
  in
  let l_rev = rev l
  in
  l_rev = l
;;
```

#### 7 Flatten a nested list structure. (medium)
```ocaml
type 'a node =
  | One of 'a
  | Many of 'a node list;;
```
```ocaml
# flatten [ One "a" ; Many [ One "b" ; Many [ One "c" ; One "d" ] ; One "e" ] ];;
- : string list = ["a"; "b"; "c"; "d"; "e"]
```
```ocaml
?????
```

#### 8 Eliminate consecutive duplicates of list elements. (medium)
```ocaml
# compress ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"];;
- : string list = ["a"; "b"; "c"; "a"; "d"; "e"]
```
```ocaml
let rec compress l = match l with
  | [] | [_] as x -> x
  | hd1::hd2::tl -> if hd1 = hd2 then compress (hd2::tl) else hd1::(compress (hd2::tl))
;;
```

#### 9 Pack consecutive duplicates of list elements into sublists. (medium)
```ocaml
# pack ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"d";"e";"e";"e";"e"];;
- : string list list = [["a"; "a"; "a"; "a"]; ["b"]; ["c"; "c"]; ["a"; "a"]; ["d"; "d"]; ["e"; "e"; "e"; "e"]]
 ```
 ```ocaml
let rec pack l =
  in
  let rec compress_list l list = match l with
    | [] -> list, []
    | [x] -> x::list, []
    | hd1::hd2::tl -> if hd1 = hd2 then compress_list (hd2::tl) (hd1::list) else (hd1::list), (hd2::tl);;
  in
  let a, b = compress_list l []

？？？？？？？？
```

#### 10 Run-length encoding of a list. (easy)
```ocaml
# encode ["a";"a";"a";"a";"b";"c";"c";"a";"a";"d";"e";"e";"e";"e"];;
- : (int * string) list = [(4, "a"); (1, "b"); (2, "c"); (2, "a"); (1, "d"); (4, "e")]
```
```ocaml
let rev encode l = match l with

```
