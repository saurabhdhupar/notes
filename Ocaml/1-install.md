mac:

## xcode

## ocaml pcre
```
brew update
brew install ocaml
brew install pcre
```

## opam
```
brew install opam
opam init

opam install utop

opam install core
opam install async
opam install core_extended
```

read [setting-up-and-using-utop](https://github.com/realworldocaml/book/wiki/Installation-Instructions#setting-up-and-using-utop)
appending the following to the top of your ~/.ocamlinit.
```ocaml
#use "topfind"
#camlp4o
#thread
#require "core.top"
#require "core.syntax"
```
appending the following to the end of your ~/.ocamlinit.
```ocaml
open Core.Std;;
```
