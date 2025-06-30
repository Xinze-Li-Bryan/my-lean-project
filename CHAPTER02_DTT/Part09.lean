/-Implicit Arguments铺垫隐式参数的必要性-/
universe u

def Lst (α : Type u) : Type u := List α
def Lst.cons {α : Type u} (a : α) (as : Lst α) : Lst α := List.cons a as
def Lst.nil {α : Type u} : Lst α := List.nil
def Lst.append {α : Type u} (as bs : Lst α) : Lst α := List.append as bs

#check Lst.cons 0 Lst.nil
#eval Lst.cons 0 Lst.nil

def as : Lst Nat := Lst.nil
def bs : Lst Nat := Lst.cons 5 Lst.nil
#eval Lst.append as bs
#check Lst.append as bs

-- 之前（显式参数）
def ident_explicit (α : Type u) (x : α) := x
-- 使用时：ident_explicit Nat 42

-- 之后（隐式参数）
def ident {α : Type u} (x : α) := x
-- 使用时：ident 42  -- α 自动推断为 Nat

#check (ident)
/-为什么需要括号？不加括号：#check ident 会显示完整的函数签名（包括隐式参数）
加括号：#check (ident) 只显示"用户看到的"类型-/
#check @ident
-- 输出：@ident : {α : Type u_1} → α → α
#check ident 1
#check ident "hello"


/-这段在讲解变量声明的隐式参数和类型推断的深层机制-/
section
  variable {α : Type u}  -- 声明 α 为隐式变量
  variable (x : α)       -- 声明 x 为显式变量
  def identv := x         -- 定义函数
end
#check identv
#check identv 2
#check identv "string"
--这是一种等价的函数定义方式

/-类型推断的限制和解决方案-/
#check (List.nil)
-- [] : List ?m.2
--           ^^^^^ 这是一个"洞"，类型未确定

#check (id)
-- id : ?m.4 → ?m.4
--      ^^^^    ^^^^  输入输出类型都未确定

/-类型注解的解决方案-/
#check (List.nil : List Nat)
-- [] : List Nat
-- 明确告诉编译器：这是 Nat 的空列表

#check (id : Nat → Nat)
-- id : Nat → Nat
-- 明确告诉编译器：这是从 Nat 到 Nat 的身份函数

/-类型注解的工作原理-/
#check 2
-- 2 : Nat (默认假设是自然数)

#check (2 : Nat)
-- 2 : Nat (显式指定为自然数)

#check (2 : Int)
-- 2 : Int (显式指定为整数)
-- 数学中的 2 可以是：
-- - 自然数 2 ∈ ℕ
-- - 整数 2 ∈ ℤ
-- - 有理数 2 ∈ ℚ
-- - 实数 2 ∈ ℝ
-- - 复数 2 ∈ ℂ

-- Lean 中同样支持：
#check (2 : Nat)    -- 自然数
#check (2 : Int)    -- 整数
-- #check (2 : Rat)    -- 有理数
-- #check (2 : Real)   -- 实数
/-还要import mathlib 暂时先不用-/

/-如何显式地使用隐式参数-/
--有时候你有一个带隐式参数的函数，但你想要明确指定那些隐式参数：
-- id 函数有隐式类型参数
def ide {α : Type} (x : α) : α := x

-- 通常我们这样用（隐式）：
#check ide 42        -- id 42 : Nat（α 自动推断为 Nat）
#check ide "hello"   -- id "hello" : String（α 自动推断为 String）
#check @ide
-- @id : {α : Sort u_1} → α → α
-- 显示完整的函数类型，包括隐式参数
#check @ide Nat
-- id : Nat → Nat
-- 给 id 提供类型参数 Nat，得到专门处理 Nat 的函数

#check @ide Nat 1

/-核心要点

@ 不改变函数，只改变调用方式
隐式参数变显式，给你完全控制权
类型推断失败时，@ 是救命稻草
调试和学习的好工具

这就像给汽车的自动挡加了手动模式——大部分时候自动就好，但需要精确控制时，手动模式就派上用场了！-/
