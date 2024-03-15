Require Import Ltac2.Ltac2.

Ltac2 foo1 x := ().

Ltac2 foo2 x := fun y => ().

(* we also warn on _ prefixed variable unlike ocaml *)
Ltac2 foo3 _x := ().

Ltac2 Notation "foo4" x(constr) := ().

(* questionable behaviour: unused variable in untyped notation warns at notation use time *)
Unset Ltac2 Typed Notations.
Ltac2 Notation "foo5" x(constr) := ().
Set Ltac2 Typed Notations.
Ltac2 foo6 () := foo5 1.

Ltac2 foo7 x := match x with y => () end.

Ltac2 foo8 x := match x with Some x => 1 | None => 2 end.

Ltac2 foo9 x := match x with (a,b) => a end.

Ltac2 foo10 := let x := () in ().

Ltac2 foo11 () := let (x,y) := (1,2) in ().

Ltac2 foo12 () := let (x,y) := (1,2) in x.

Ltac2 foo13 () := let rec x () := 1 with y () := 2 in x.

Ltac2 foo14 () := let rec x () := y () with y () := 2 in x.

(* missing warning for unused letrec (bug?) *)
Ltac2 foo15 () := let rec x () := y () with y () := x () in ().

Ltac2 mutable bar () := ().

(* missing warning for unused "Set as" (bug?) *)
Ltac2 Set bar as bar0 := fun () => ().

Ltac2 foo16 () := ltac1:(ltac2:(x |- ())).

(* no warning for y even though it's bound in the ltac2 context
   (ltac2 can't tell that the notation isn't eg "ltac2:(...) + y") *)
Notation foo17 x y := ltac2:(exact $preterm:x) (only parsing).
