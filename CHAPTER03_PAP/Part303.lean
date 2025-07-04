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

/-3.3.3 Negation and Falsity-/
variable (p q : Prop)
example (hpq : p → q) (hnq : ¬ q) : ¬ p :=
    fun hp : p =>
    show False from hnq (hpq hp)
/-这行代码在证明一个逻辑定理：
如果同时有 p 和 ¬p（非p），那么可以推出任何结论 q。-/
example (hp : p) (hnp : ¬ p) : q :=
    False.elim (hnp hp)
/-下面这行代码和前面那行在做完全相同的事情，只是用了不同的方法！
absurd 是 Lean 中的一个内置函数
它接受两个参数：一个命题的证明 (hp) 和这个命题否定的证明 (hnp)
直接识别出这是矛盾，从矛盾可以推出任何结论-/
example (hp : p) (hnp : ¬ p) : q :=
    absurd hp hnp
/-这里 hqp hq 返回p 和hnp矛盾，可以直接使用absurd-/
example (hnp : ¬ p) (hq : q) (hqp : q → p) : r :=
    absurd (hqp hq) hnp
/-3.3.4 Logical Equivalence-/
theorem and_swap : p ∧ q ↔ q ∧ p :=
    Iff.intro
    (fun h : p ∧ q =>
    show q ∧ p from And.intro (And.right h) (And.left h))
    (fun h : q ∧ p =>
    show p ∧ q from And.intro (And.right h) (And.left h))

#check and_swap p q
#check Iff.mp (and_swap p q)
-- Iff.mp的作用是将一个 Iff 从左到右提取之后应用到一个证明上
variable (h : p ∧ q)
-- 这是在说："假设我们有一个变量h，它是p∧q的证明"
example : q ∧ p := Iff.mp (and_swap p q) h
/-下面是利用语法糖构造的更简单的写法，这里Lean会自动推断你要构造什么类型-/
variable (p q: Prop)
theorem and_swap' : p ∧ q ↔ q ∧ p :=
    ⟨ fun h => ⟨h.right, h.left⟩, fun h => ⟨h.right, h.left⟩⟩
example (h : p ∧ q) : q ∧ p :=
    (and_swap' p q).mp h

variable (p q r : Prop)
theorem assoc_example : (p ∧ q) ∧ r ↔ p ∧ (q ∧ r) :=
    ⟨ fun h => ⟨h.left.left, ⟨h.left.right, h.right⟩⟩,
      fun h => ⟨⟨h.left, h.right.left⟩, h.right.right⟩⟩
