/-展示命题即类型范式的实际应用，说明逻辑证明和函数编程本质上是同一件事-/
--学写推理规则：
set_option linter.unusedVariables false
---
variable {p q : Prop}

/-以下的，这两个定理在逻辑上是等价的，
都证明了同一个命题 p → q → p，
但它们使用了不同的语法形式：-/
-- t1 使用显式 lambda 函数语法：
theorem t1 : p → q → p :=
  fun hp : p =>
  fun hq : q =>
  show p from hp
-- t2 使用简化的参数语法：
  /-We use show p from hp to improve
   the clarity of a proof and help detect
   errors when writing a proof. This command
   does NOTHING more than annotate the type
  -/
 theorem t2 (hp : p) (hq : q) : p := hp
 #print t2
 /-本质关系：两者在类型论中是完全等价的。
 Lean 的类型检查器会将 t2 的简化语法自
 动转换为类似 t1 的 lambda 表达式。
 这体现了 Curry-Howard 对应中命题与函数类型的
 一致性。-/
--axiom hp : p
--theorem t3 : q → p := t2 hp
--#print t3
/-这完美展示了柯里化的工作原理：

p → q → p 实际上是 p → (q → p)
当提供第一个参数后，得到一个新函数 q → p

实际意义：
t3 现在是一个函数，它接受任何 q 类型的证明，
然后返回我们已有的 p 的证明（hp）。这正是逻
辑中的弱化规则——如果我们已经有了 p，那么无
论额外假设什么（q），我们仍然有 p。
这个例子很好地说明了在类型论中，逻辑推理和
函数应用是如何统一的！RetryClaude can
make mistakes. Please double-check
responses.Research Sonnet 4-/

axiom unsound : False
-- Everything follows from False
theorem ex : 1 = 0 := False.elim unsound
/-在 Lean 中，False.elim 是一个特殊的函数，
它接受一个 False 类型的参数，并返回任何类型的值。
这体现了逻辑中的爆炸原则（ex falso quodlibet）：
从矛盾中可以推出任何结论。-/
theorem ex1 : 2 + 2 = 5 := False.elim unsound
/-We can also rewrite t1 as follows:-/
theorem t1' {p q : Prop} (hp : p) (hq : q) : p := hp
#print t1'
#print t2
theorem t1'' : ∀ {p q : Prop}, p → q → p :=
  fun {p q : Prop} (hp : p) (hq : q) => hp
/- If p and q have been declared as variables, Lean
will generalize them for us automatically-/
variable {p q : Prop}
theorem t1''' : p → q → p :=
 fun (hp : p) (hq : q) =>
 hp
/-这表明 Lean 可以自动处理类型变量的泛化，
使得我们可以在证明中使用更通用的形式。-/
theorem t1'''' (p q : Prop) (hp : p)(hq : q) : p := hp

variable (p q r s : Prop)

#check t1'''' p q
#check t1'''' r s
#check t1'''' (r → s) (s → r)

variable (h : r → s)
#check t1'''' (r → s) (s → r) h

variable (p q r s : Prop)
theorem t5 (h₁ : q → r) (h₂ : p → q) : p → r :=
  fun h₃ : p =>
  show r from h₁ (h₂ h₃)
/-在这个定理中，我们使用了两个假设 h₁ 和 h₂，
它们分别是 q → r 和 p → q。
我们需要证明 p → r。
我们首先假设 h₃ 是 p 的一个证明，然后通过
使用 h₂ 得到 q 的证明，接着使用 h₁ 得到 r 的证明。
这展示了如何在 Lean 中使用假设来构建复杂的逻辑推理-/
