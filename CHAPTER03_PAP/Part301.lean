/-3.1. Propositions as Types-/
#check And
#check Or
#check Not
def Implies (p q : Prop) : Prop := p → q
#check Implies

variable (p q r : Prop)
#check And p q
#check Or (And p q) r
#check Implies (And p q) (And q p)
def Proof (p : Prop) : Prop := p
/-展示传统的逻辑系统是如何用类型论表示的，然后为了引出"为什么要简化"-/
--合取是可交换的
axiom and_commut (p q : Prop) : Proof (Implies (And p q) (And q p))
/-这是一个公理（axiom），不需要证明，直接假设存在
对于任意命题 p 和 q
存在一个证明，证明了"p 且 q 蕴含 q 且 p"
换句话说：合取是可交换的-/
-- 用现代 Lean 4 语法：不需要显式的 Proof 类型
example (p q : Prop) : (p ∧ q) → (q ∧ p) :=
  fun h => ⟨h.2, h.1⟩
--检查公理的使用：
variable (p q : Prop)
#check and_commut p q
--这表示对于具体的 p 和 q，我们有一个具体的证明。
/-演绎推理规则：From a proof of Implies p q and a proof of p,
we obtain a proof of q-/
--We could represent this as follows:
axiom modus_ponens (p q : Prop) :
  Proof (Implies p q) → Proof p →
  Proof q
/-经典逻辑解读：
大前提：如果 p，那么 q
小前提：p 为真
结论：因此 q 为真
类型论解读：
给我一个 "p 蕴含 q" 的证明
再给我一个 "p" 的证明
我就能构造出一个 "q" 的证明-/
-- 这就是函数应用！
example (p q : Prop) (hpq : p → q) (hp : p) : q := hpq hp
/-Suppose that, assuming p as a hypothesis,
we have a proof of q. Then we can "cancel" the
hypothesis and obtain a proof Implies p q-/
--We could render this as follows:
/-蕴含引入规则：-/
axiom implies_intro (p q : Prop) :
  (Proof p → Proof q) → Proof (Implies p q)
/-逻辑解读：
如果假设 p 为真，我能证明 q 为真
那么我就证明了 "p 蕴含 q"
类型论解读：
如果我有一个函数：从 p 的证明到 q 的证明
那么我就有了 "p 蕴含 q" 的证明-/
/-用现代 Lean 4 语法：-/
-- 这就是 lambda 抽象！
example (p q : Prop) : (p → q) → (p → q) := fun f => f
-- 或者更有意义的例子：
-- 无法无条件证明 (p → q)，除非有更多假设，因此移除该例子以避免 sorry 错误
-- example (p q : Prop) : (p → q) := fun hp => sorry -- 需要具体构造
/-This approach would provide us with a reasonable
way of building assertions and proofs. Determining
that an expression t is a correct proof of
assertion p would then simply be a matter
of checking that t has type Proof p.-/
/-4. 完整的推理示例-/
-- 用传统方式推理，假设我们有这些
axiom Implies1 : Prop → Prop → Prop
axiom Proof1 : Prop → Type
axiom And1 : Prop → Prop → Prop
axiom modus_ponens1 (p q : Prop) :
  Proof1 (Implies1 p q) → Proof1 p →
  Proof1 q

variable (p q r : Prop)

-- 有了这些公理，我们可以进行推理：
variable (h1 : Proof1 (Implies1 p q))  -- p → q 的证明
variable (h2 : Proof1 p)              -- p 的证明
#check modus_ponens1 p q h1 h2     -- 这是 Proof q
-- 用现代 Lean 4 方式
variable (p q r : Prop)
variable (hpq : p → q)  -- p 蕴含 q
variable (hp : p)       -- p 为真

-- 直接函数应用得到 q
#check hpq hp          -- 这是 q : Prop 的证明
/-6. 核心洞察
这段代码想说明：

传统逻辑系统可以在类型论中表示
但这很繁琐：需要显式的证明类型和推理规则
Curry-Howard 同构告诉我们：可以直接用函数类型表示蕴含
这就是为什么：Lean 选择了简化的方式-/
