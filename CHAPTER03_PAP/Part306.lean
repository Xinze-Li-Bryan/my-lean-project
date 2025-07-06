/-Examples of Propositional Validities-/
open Classical
-- "我要使用经典逻辑，而不是构造性逻辑"
-- distributivity
example (p q r : Prop) : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) :=
  /-
  这个证明要证明一个双向等价（↔），所以需要证明两个方向：
    正向：p ∧ (q ∨ r) → (p ∧ q) ∨ (p ∧ r)
    反向：(p ∧ q) ∨ (p ∧ r) → p ∧ (q ∨ r)
  -/
  Iff.intro -- 这表示我们要构造一个双向等价，需要提供两个函数（正向和反向）。
    (fun h : p ∧ (q ∨ r) => -- 假设我们有 h : p ∧ (q ∨ r)，现在要证明 (p ∧ q) ∨ (p ∧ r)。
      have hp : p := h.left --从合取 h 中提取左边部分，得到 p 为真。
      Or.elim (h.right)
      /-对 h 的右边部分（即 q ∨ r）进行情况分析。
      Or.elim 的意思是：要证明某个结论，当你有 A ∨ B 时，
      你需要分别在 A 为真和 B 为真的情况下都能证明这个结论。-/
        (fun hq : q =>
          show (p ∧ q) ∨ (p ∧ r) from Or.inl ⟨hp, hq⟩)
          /-情况1：如果 q 为真，那么我们有 p（从 hp）和 q（从 hq），
          所以可以构造 p ∧ q，然后用 Or.inl 选择析取的左边，
          得到 (p ∧ q) ∨ (p ∧ r)。-/
        (fun hr : r =>
          show (p ∧ q) ∨ (p ∧ r) from Or.inr ⟨hp, hr⟩))
          /-情况2：如果 r 为真，那么我们有 p（从 hp）和 r（从 hr），
          所以可以构造 p ∧ r，然后用 Or.inr 选择析取的右边，
          得到 (p ∧ q) ∨ (p ∧ r)。-/
    (fun h : (p ∧ q) ∨ (p ∧ r) => -- 假设我们有 h : (p ∧ q) ∨ (p ∧ r)，现在要证明 p ∧ (q ∨ r)。
      Or.elim h -- 对 h 进行情况分析。
        (fun hpq : p ∧ q =>
          have hp : p := hpq.left
          have hq : q := hpq.right
          show p ∧ (q ∨ r) from ⟨hp, Or.inl hq⟩)
          /-情况1：如果 h 是 p ∧ q，那么：
          提取 p（hp）和 q（hq）
          构造 q ∨ r（选择左边 q）
          最终得到 p ∧ (q ∨ r)-/
        (fun hpr : p ∧ r =>
          have hp : p := hpr.left
          have hr : r := hpr.right
          show p ∧ (q ∨ r) from ⟨hp, Or.inr hr⟩))
          /-情况2：如果 h 是 p ∧ r，那么：
          提取 p（hp）和 r（hr）
          构造 q ∨ r（选择右边 r）
          最终得到 p ∧ (q ∨ r)-/
-- 结论：这个证明展示了如何使用情况分析和合取的性质来证明双向等价。

example (p q : Prop) : ¬(p ∧ ¬ q) → (p → q) :=
  -- 这个证明的意思是：如果不是(p且不是q)，那么如果p成立，则q也成立
  fun h : ¬(p ∧ ¬ q) =>
  fun hp : p =>
  show q from
    Or.elim (em q)
      (fun hq : q => hq)
      (fun hnq : ¬ q => absurd ⟨hp, hnq⟩ h)
-- 结论：这个证明展示了如何使用排中律和矛盾来
