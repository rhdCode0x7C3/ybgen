[@@@ocaml.doc
  "_"]

val f : int -> int -> int
  [@@cold] [@@inline never] [@@local never] [@@specialise never]

external unsafe_memset : t -> pos:int -> len:int -> char -> unit
  = "bigstring_memset_stub"
  [@@noalloc]
