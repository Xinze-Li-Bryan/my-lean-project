/-Lean also allows you to introduce "local" definitions
using the let keyword. The expression let α := t1; t2 is
definitionally equal to the result of replacing every
occurrence of α in t2 by t1-/
#check let y := 2 + 2 ; y * y
#eval let y := 2 + 2 ; y * y
def twice_double (x : Nat) : Nat :=
  let y := x + x ; y * y
#eval twice_double 4
#check let y := 2 + 2; let z := y + y ; z * z
#eval let y := 2 + 2; let z := y + y ; z * z
/- The ; can be omitted when a line break is used.-/
def t (x : Nat) : Nat :=
  let y := x + x
  y * y
#eval t 7
