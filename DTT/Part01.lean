/- Define some constants.-/
def m : Nat := 1 --- m is a natural number
def n : Nat := 0
def b1 : Bool := true
def b2 : Bool := false


/- Check their types. -/
#check m
#check n
#check n + 0
#check m * (n + 0)
#check b1
-- "&&" is the boolean and
#check b1 && b2
-- Boolean or
#check b1 || b2
-- Boolean "true"
#check true

/-Evaluate -/
#eval 5 * 4
#eval m + 2
#eval b1 && b2
#eval b1 || b2

#check Nat -> Nat
#check Nat → Nat
#check Nat × Nat
#check Prod Nat Nat
#check Nat → Nat → Nat
#check Nat → (Nat → Nat)
#check Nat × Nat → Nat
#check (Nat → Nat) → Nat
#check Nat.succ
#check (0, 1)
#check Nat.succ 2
#check Nat.add 3
#check Nat.add 5 2
#check (5, 9).1
#check (5, 9).2
#eval (5, 9).1
#eval (5, 9).2
#eval Nat.add 4 3
#eval Nat.succ 2
