from [Ocaml 99problems](http://ocaml.org/learn/tutorials/99problems.html)

### Working with lists

#### Write a function `last : 'a list -> 'a option` that returns the last element of a list. (easy)
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

#### Find the last but one (last and penultimate) elements of a list. (easy)
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

#### Find the `k`'th element of a list. (easy)
```ocaml
# at 3 [ "a" ; "b"; "c"; "d"; "e" ];;
- : string option = Some "c"
# at 3 [ "a" ];;
- : string option = None
```
```ocaml
????????
```

#### Find the number of elements of a list. (easy)
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

#### Reverse a list. (easy)
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

#### Find out whether a list is a palindrome. (easy)
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

#### Flatten a nested list structure. (medium)

```ocaml
type 'a node =
  | One of 'a
  | Many of 'a node list;;
```
```ocaml
# flatten [ One "a" ; Many [ One "b" ; Many [ One "c" ; One "d" ] ; One "e" ] ];;
- : string list = ["a"; "b"; "c"; "d"; "e"]
```
