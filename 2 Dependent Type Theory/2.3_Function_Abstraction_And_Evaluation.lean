/-Lean provides a fun (or λ) keyword to create
a function from an expression as follows:-/
#check fun (x : Nat) => x + 5
-- λ and fun mean the same thing
#check λ (x : Nat) => x + 5
 /-The type Nat can be inferred in this example:-/
#check fun x => x + 5
#check λ x => x + 5
/-You can evaluate a lambda function by passing
 the required parameters:-/
#eval (λ x : Nat => x + 5) 10
