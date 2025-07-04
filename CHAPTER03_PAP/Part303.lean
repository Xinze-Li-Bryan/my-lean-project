/-Lean defines all standard logical connectives
 and notation. The propositional connectives
 comes with the following notation:-/

variable (p q : Prop)
#check p → q → p ∧ q
#check ¬ p → p ↔ False
#check p ∨ q → q ∨ p
/-3.3.1 Conjection-/
variable (p q : Prop)
example (hp : p) (hq : q) : p ∧ q := And.intro hp hq
#check fun (hp : p) (hq : q) => And.intro hp hq

variable (p q : Prop)

example (h : p ∧ q) : p := And.left h
example (h : p ∧ q) : q := And.right h
example (h : p ∧ q) : q ∧ p :=
    And.intro (And.right h) (And.left h)

variable (hp : p) (hq : q)
#check (⟨hp, hq⟩ : p ∧ q)
/-这个 ⟨⟩ 符号叫做匿名构造器（anonymous constructor）。
它是 And.intro hp hq 的简写形式！-/

variable (xs : List Nat)
#check List.length xs
#check xs.length

example (h : p ∧ q) : q ∧ p :=
    ⟨h.right, h.left⟩
example (h : p ∧ q) : q ∧ p ∧ q :=
    ⟨h.right, h.left, h.right⟩
example (h : p ∧ q) : p ∧ q ∧ p :=
    ⟨h.left, h.right, h.left⟩
/-3.3.2 Disjunction-/
example (hp : p) : p ∨ q := Or.intro_left q hp
example (hq : q) : p ∨ q := Or.intro_right p hq

variable(p q r : Prop)
example (h : p ∨ q) : q ∨ p :=
    Or.elim h
        (fun hp : p => Or.intro_right q hp)
        (fun hq : q => Or.intro_left p hq)

variable (p q r : Prop)
example (h : p ∨ q) : q ∨ p :=
    Or.elim h (fun hp => Or.intro_right q hp) (fun hq => Or.intro_left p hq)
example (h : p ∨ q) : q ∨ p :=
    Or.elim h (fun hp => Or.inr hp) (fun hq => Or.inl hq)
example (h : p ∨ q) : q ∨ p :=
    h.elim (fun hp => Or.inr hp) (fun hq => Or.inl hq)
