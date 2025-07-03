/-Lean defines all standard logical connectives
 and notation. The propositional connectives
 comes with the following notation:-/

variable (p q : Prop)
#check p → q → p ∧ q
#check ¬ p → p ↔ False
#check p ∨ q → q ∨ p
