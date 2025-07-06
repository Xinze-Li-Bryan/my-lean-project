/-3.5 Classical Logic-/
open Classical
--"我要使用经典逻辑，而不是构造性逻辑"
variable (p q r : Prop)
-- em 是 "excluded middle"（排中律） 的缩写
-- 所谓“排中律” 对于任何陈述，要么它是真的，要么它是假的，没有中间状态
-- 这个定理的意思是：如果 p 的否定的否定是成立的，那么 p 也是成立的
-- 这就是经典逻辑中的双重否定
theorem dne {p : Prop} (h : ¬¬ p) : p :=
  -- 我们使用排中律来证明这个定理
  -- 如果 p 成立，那么我们直接得到 p
   Or.elim (em p)
   -- Or.elim 表示：我们要对两种情况分别处理
    -- 第一种情况是 p 成立
    (fun hp : p => hp)
    -- 第二种情况是 p 不成立
    -- 在这种情况下，我们可以得到 p 的否定 ¬p
    -- 然后我们可以使用 h 来得到 ¬¬p 的证明
    -- 这就意味着 p 必须成立，因为我们假设了 ¬¬p
    -- 所以我们可以得到 p 的证明
    (fun hnp : ¬ p => absurd hnp h)
    -- 结论： 用 absurd 指出矛盾，从矛盾可以推出任何结论

-- 下面的例子展示了如何使用 byCases 来处理双重否定
-- byCases 是 Lean 中的一个命令，用于按情况分类处理证明
-- 它的作用是将一个命题分为两种情况：成立和不成立
-- 在这种情况下，我们可以使用 byCases 来处理 ¬¬ p 的情况
-- 这个例子展示了如何使用 byCases 来证明 p
variable (p : Prop)
-- 这个例子的意思是：如果 ¬¬ p 成立，那么 p 也成立
-- 我们使用 byCases 来处理这个证明
-- byCases 的作用是将 ¬¬ p 分为两种情况：p 成立和 ¬ p 成立
-- 如果 p 成立，我们直接得到 p
-- 如果 ¬ p 成立，我们可以使用 h 来得到 ¬¬ p 的证明
-- 这就意味着 p 必须成立，因为我们假设了 ¬¬ p
-- 所以我们可以得到 p 的证明
example (h : ¬¬ p) : p :=
--byCases = "按情况分类" 或 "情况分析"
  byCases
    (fun h1 : p => h1)
    -- 第一种情况是 p 成
    (fun h1 : ¬ p => absurd h1 h)
    -- 结论： 用 absurd 指出矛盾，从矛盾可以推出任何结论

example (h : ¬¬ p) : p :=
  byContradiction
  -- byContradiction 是 "反证法" 的意思
  -- 它的作用是通过假设一个命题的否定来证明这个命题
  -- 在这种情况下，我们假设 ¬ p 成立
  -- 然后我们可以使用 h 来得到 ¬¬ p 的证明
  -- 这就意味着 p 必须成立，因为我们假设了 ¬¬ p
    (fun h1 : ¬ p =>
    show False from h h1)
-- 结论： 用 show False from h h1 指出矛盾，从矛盾可以推出任何结论

--如果不是(p且q)，那么要么不是p，要么不是q
example (h : ¬ (p ∧ q)) : ¬ p ∨ ¬ q :=
-- 我们使用排中律来处理这个证明
  -- Or.elim 是 "按情况分类" 的意思：如果你有 A ∨ B，想要证明 C，那么你需要：证明 A → C（如果A为真，则C为真，证明 B → C（如果B为真，则C为真）
  Or.elim (em p)
    (fun hp : p =>
      Or.inr
        (show ¬ q from fun hq : q => h ⟨hp, hq⟩))
    (fun hp : ¬ p => Or.inl hp)
-- 结论： 用 Or.inr 和 Or.inl 来分别处理两种情况
-- Or.inr 表示 "如果 p 成立，那么 ¬ q 成立"
-- Or.inl 表示 "如果 ¬ p 成立，那么 ¬ q 成立

example (h : ¬ (p ∧ q)) : ¬ p ∨ ¬ q :=
  byCases
    (fun hp : p =>
      Or.inr
        (show ¬ q from fun hq : q => absurd ⟨hp, hq⟩ h))
    (fun hp : ¬ p => Or.inl hp)

example (h : ¬ (p ∧ q)) : ¬ p ∨ ¬ q :=
  byContradiction (fun h1 : ¬(¬p ∨ ¬q) =>
    show False from h ⟨
      Classical.byContradiction (fun hnp => h1 (Or.inl hnp)),
      Classical.byContradiction (fun hnq => h1 (Or.inr hnq))
    ⟩)
