/-3.4 Introducing Auxiliary Subgoals-/
-- 假设我们有两个命题 p 和 q
-- 我们想要证明 q ∧ p
-- 我们可以使用辅助子目标来帮助我们完成这个证明
variable (p q : Prop)
-- 下面的例子展示了如何使用辅助子目标来证明 q ∧ p
example (h : p ∧ q) : q ∧ p :=
-- 我们首先假设 h 是 p ∧ q 的证明
-- 然后我们从 h 中提取出 p 和 q 的证明
  have hp : p := h.left
  have hq : q := h.right
-- 最后我们使用 And.intro 来构造 q ∧ p 的证明
  show q ∧ p from And.intro hq hp

example (h : p ∧ q) : q ∧ p :=
-- 我们首先假设 h 是 p ∧ q 的证明
-- 然后我们从 h 中提取出 p 的证明
  have hp : p := h.left
-- 我已经有: hp : p
  suffices hq : q from And.intro hq hp
-- 我们使用 suffices 来引入一个新的子目标 hq
-- 我声明: 如果能得到 hq : q，那么 And.intro hq hp 就是 q ∧ p 的证明
-- 系统说: 好，那你现在只需要证明 q
  show q from h.right
