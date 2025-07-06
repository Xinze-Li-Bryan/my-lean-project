/-Exercises-/
variable (p q r : Prop)
-- commutativity of ∨ and ∧
-- 风格1：直接构造
example : p ∨ q ↔ q ∨ p :=
 Iff.intro
  (fun h : p ∨ q =>
    Or.elim h
      (fun hp : p => Or.inr hp) -- 如果 p 成立，则 q ∨ p 成立
      (fun hq : q => Or.inl hq)) -- 如果 q 成立，则 q ∨ p 成立
  (fun h : q ∨ p =>
    Or.elim h
      (fun hq : q => Or.inr hq) -- 如果 q 成立，则 p ∨ q 成立
      (fun hp : p => Or.inl hp)) -- 如果 p 成立，则 p ∨ q 成立
-- 风格2：显式步骤
example : p ∧ q ↔ q ∧ p :=
  Iff.intro
  (fun h : p ∧ q =>
    have hp : p := h.left -- 从合取 h 中提取左边部分
    have hq : q := h.right -- 从合取 h 中提取右边部分
    show q ∧ p from ⟨hq, hp⟩) -- 从合取 h 中提取 q 和 p，然后构造 q ∧ p
  (fun h : q ∧ p =>
    have hq : q := h.left -- 从合取 h 中提取左边部分
    have hp : p := h.right -- 从合取 h 中提取右边部分
    show p ∧ q from ⟨hp, hq⟩) -- 从合取 h 中提取 p 和 q，然后构

-- associativity of ∨ and ∧
-- 风格3：模式匹配风格
example : p ∨ (q ∨ r) ↔ (p ∨ q) ∨ r :=
  Iff.intro
    (fun h : p ∨ (q ∨ r) =>
      match h with
      | Or.inl hp      => Or.inl (Or.inl hp)
      | Or.inr (Or.inl hq) => Or.inl (Or.inr hq)
      | Or.inr (Or.inr hr) => Or.inr hr)
    (fun h : (p ∨ q) ∨ r =>
      match h with
      | Or.inl (Or.inl hp) => Or.inl hp
      | Or.inl (Or.inr hq) => Or.inr (Or.inl hq)
      | Or.inr hr          => Or.inr (Or.inr hr))
-- -- 风格2：显式步骤
example : p ∧ (q ∧ r) ↔ (p ∧ q) ∧ r :=
  Iff.intro
    (fun h : p ∧ (q ∧ r) =>
      have hp : p := h.left -- 从合取 h 中提取左边部分
      have hq : q := h.right.left -- 从合取 h 中提取右边部分的左边
      have hr : r := h.right.right -- 从合取 h 中提取右边部分的右边
      show (p ∧ q) ∧ r from ⟨⟨hp, hq⟩, hr⟩) -- 构造 (p ∧ q) ∧ r
    (fun h : (p ∧ q) ∧ r =>
      have hpq : p ∧ q := h.left -- 从合取 h 中提取左边部分
      have hr : r := h.right -- 从合取 h 中提取右边部分
      have hp : p := hpq.left -- 从合取 hpq 中提取左边部分
      have hq : q := hpq.right -- 从合取 hpq 中提取右边部分
      show p ∧ (q ∧ r) from ⟨hp, ⟨hq, hr⟩⟩) -- 构造 p ∧ (q ∧ r)

-- distributivity
example : p ∧ (q ∨ r) ↔ (p ∧ q) ∨ (p ∧ r) :=
  Iff.intro
    (fun h : p ∧ (q ∨ r) =>
      have hp : p := h.left -- 从合取 h 中提取左边部分
      Or.elim h.right -- 对 h 的右边部分（即 q ∨ r）进行情况分析
        (fun hq : q => Or.inl ⟨hp, hq⟩) -- 如果 q 成立，则构造 (p ∧ q)
        (fun hr : r => Or.inr ⟨hp, hr⟩)) -- 如果 r 成立，则构造 (p ∧ r)
    (fun h : (p ∧ q) ∨ (p ∧ r) =>
      Or.elim h -- 对 h 进行情况分析
        (fun hpq : p ∧ q =>
          have hp : p := hpq.left -- 从合取 hpq 中提取左边部分
          have hq : q := hpq.right -- 从合取 hpq 中提取右边部分
          show p ∧ (q ∨ r) from ⟨hp, Or.inl hq⟩) -- 构造 p ∧ (q ∨ r)
        (fun hpr : p ∧ r =>
          have hp : p := hpr.left -- 从合取 hpr 中提取左边部分
          have hr : r := hpr.right -- 从合取 hpr 中提取右边部分
          show p ∧ (q ∨ r) from ⟨hp, Or.inr hr⟩)) -- 构造 p ∧ (q ∨ r)

example : p ∨ (q ∧ r) ↔ (p ∨ q) ∧ (p ∨ r) :=
  Iff.intro
    (fun h : p ∨ (q ∧ r) =>
      Or.elim h -- 对 h 进行情况分析
        (fun hp : p => ⟨Or.inl hp, Or.inl hp⟩) -- 如果 p 成立，则构造 (p ∨ q) ∧ (p ∨ r)
        (fun hqr : q ∧ r =>
          have hq : q := hqr.left -- 从合取 hqr 中提取左边部分
          have hr : r := hqr.right -- 从合取 hqr 中提取右边部分
          ⟨Or.inr hq, Or.inr hr⟩)) -- 构造 (p ∨ q) ∧ (p ∨ r)
    (fun h : (p ∨ q) ∧ (p ∨ r) =>
      have hpq : p ∨ q := h.left -- 从合取 h 中提取左边部分
      have hpr : p ∨ r := h.right -- 从合取 h 中提取右边部分
      Or.elim hpq -- 对 hpq 进行情况分析
        (fun hp : p => Or.inl hp) -- 如果 p 成立，则直接返回 p
        (fun hq : q => Or.elim hpr -- 如果 q 成立，则对 hpr 进行情况分析
          (fun hp : p => Or.inl hp) -- 如果 p 成立，则直接返回 p
          (fun hr : r => Or.inr ⟨hq, hr⟩))) -- 如果 r 成立，则构造 q ∧ r
-- 结论：这个证明展示了如何使用情况分析和合取的性质来证明双向等价。

-- Other Properties
example : (p → (q → r)) ↔ (p ∧ q → r) :=
  Iff.intro
    (fun h : p → (q → r) =>
      fun hpq : p ∧ q =>
        h hpq.left hpq.right)
    (fun h : p ∧ q → r =>
      fun hp : p =>
        fun hq : q =>
          h ⟨hp, hq⟩)

example : ((p ∨ q) → r) ↔ (p → r) ∧ (q → r) :=
  Iff.intro
    (fun h : (p ∨ q) → r =>
      ⟨fun hp : p => h (Or.inl hp), fun hq : q => h (Or.inr hq)⟩)
    (fun h : (p → r) ∧ (q → r) =>
      fun hpq : p ∨ q =>
        Or.elim hpq
          (fun hp : p => h.left hp)
          (fun hq : q => h.right hq))

example : ¬(p ∨ q) ↔ ¬ p ∧ ¬ q :=
  Iff.intro
    (fun h : ¬(p ∨ q) =>
      ⟨fun hp : p => absurd (Or.inl hp) h, fun hq : q => absurd (Or.inr hq) h⟩)
    (fun h : ¬ p ∧ ¬ q =>
      fun hpq : p ∨ q =>
        Or.elim hpq
          (fun hp : p => absurd hp h.left)
          (fun hq : q => absurd hq h.right))

example : ¬p ∨ ¬q → ¬ (p ∧ q) :=
  fun h : ¬p ∨ ¬q =>
    Or.elim h
      (fun hp : ¬p => fun hpq : p ∧ q => absurd hpq.left hp)
      (fun hq : ¬q => fun hpq : p ∧ q => absurd hpq.right hq)

/-- 相当于证明example : (p ∧ ¬ p) → False :=-/
-- 方法1：直接证明（推荐）
example : ¬ (p ∧ ¬ p) :=
  fun h : p ∧ ¬ p =>
    absurd h.left h.right

-- 方法2：使用排中律
open Classical
example : ¬ (p ∧ ¬ p) :=
  fun h : p ∧ ¬ p =>
    Or.elim (em p)
      (fun hp : p =>
        have hnp : ¬ p := h.right
        show False from hnp hp)
      (fun hnp : ¬ p =>
        have hp : p := h.left
        show False from hnp hp)

example : p ∧ ¬q → ¬(p → q) :=
  fun h : p ∧ ¬q =>
    fun hpq : p → q =>
      have hp : p := h.left
      have hnq : ¬q := h.right
      have hq : q := hpq hp
      show False from hnq hq

example : ¬p → (p → q) :=
  fun hnp : ¬p =>
    fun hp :p =>
      absurd hp hnp

example : (¬p ∨ q) → (p → q) :=
  fun h : ¬p ∨ q =>
    fun hp : p =>
      Or.elim h
        (fun hnp : ¬p => absurd hp hnp)
        (fun hq : q => hq)

example : p ∨ False ↔ p :=
  Iff.intro
    (fun h : p ∨ False =>
      Or.elim h
        (fun hp : p => hp)
        (fun hf : False => False.elim hf))
    (fun h : p =>
      Or.inl h)

example : p ∧ False ↔ False :=
  Iff.intro
    (fun h : p ∧ False =>
      have hf : False := h.right
      False.elim hf)
    (fun h : False =>
      False.elim h)

example : ¬(p ↔ ¬p) :=
  fun h : p ↔ ¬p =>
    Or.elim (Classical.em p)
      (fun hp : p =>
        have hnp : ¬p := h.mp hp  -- 从 p 得到 ¬p
        show False from hnp hp)   -- ¬p 应用到 p 上得到矛盾
      (fun hnp : ¬p =>
        have hp : p := h.mpr hnp  -- 从 ¬p 得到 p
        show False from hnp hp)   -- ¬p 应用到 p 上得到矛盾

example : ¬(p ↔ ¬p) :=
  fun h : p ↔ ¬p =>
    -- 构造一个假设 p 的证明
    have hp : p := h.mpr (fun hp : p => h.mp hp hp)
    -- 然后推出矛盾
    h.mp hp hp

example : (p → q) → (¬ q → ¬ p) :=
  fun h : p → q =>
    fun hnq : ¬q =>
      fun hp : p =>
        have hq : q := h hp
        show False from hnq hq

-- These require classical reasoning
example : (p → r ∨ s) → ((p → r) ∨ (p → s)) :=
  fun h : p → r ∨ s =>
    Or.elim (Classical.em p)
      (fun hp : p =>
        match h hp with
        | Or.inl hr => Or.inl (fun _ => hr)
        | Or.inr hs => Or.inr (fun _ => hs))
      (fun hnp : ¬p =>
        Or.inl (fun hp' => absurd hp' hnp))

example : (p → r ∨ s) → ((p → r) ∨ (p → s)) :=
  fun h : p → r ∨ s =>
    Or.elim (Classical.em p)
      (fun hp : p =>
        let hrs : r ∨ s := h hp
        Or.elim hrs
          (fun hr : r =>
            let pr : p → r := fun _ => hr
            Or.inl pr)
          (fun hs : s =>
            let ps : p → s := fun _ => hs
            Or.inr ps))
      (fun hnp : ¬p =>
        let pr : p → r := fun hp => absurd hp hnp
        Or.inl pr)

example: (p → r ∨ s) → ((p → r) ∨ (p → s)) :=
  fun h : p → r ∨ s =>
    Or.elim (Classical.em p)
      (fun hp : p =>
        have hrs : r ∨ s := h hp
        Or.elim hrs
          (fun hr : r =>
            have pr : p → r := fun _ => hr
            Or.inl pr)
          (fun hs : s =>
            have ps : p → s := fun _ => hs
            Or.inr ps))
      (fun hnp : ¬p =>
        have pr : p → r := fun hp => absurd hp hnp
        Or.inl pr)

example : ¬(p ∧ q) → (¬p ∨ ¬q) :=
  fun h : ¬(p ∧ q) =>
    Or.elim (Classical.em p)
      (fun hp : p =>
        have hnpq : ¬q := fun hq : q => h ⟨hp, hq⟩
        Or.inr hnpq)
      (fun hnp : ¬p => Or.inl hnp)

example : ¬(p → q) → p ∧ ¬q :=
  fun h : ¬(p → q) =>
    Or.elim (Classical.em p)
      (fun hp : p =>
        have hnq : ¬q :=
          fun hq : q =>
            -- 如果 q 为真，那么我们可以构造 p → q
            have hpq : p → q := fun _ : p => hq
            -- 这与 h : ¬(p → q) 矛盾
            h hpq
        ⟨hp, hnq⟩)
      (fun hnp : ¬p =>
        -- 如果 p 为假，那么 p → q 为真（假前件使蕴含为真）
        have hpq : p → q := fun hp : p => False.elim (hnp hp)
        -- 这与 h : ¬(p → q) 矛盾
        False.elim (h hpq))
