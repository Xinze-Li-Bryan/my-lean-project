/-没有依赖类型会怎样？
想象一下，如果没有依赖类型，你需要为每种数据类型写单独的函数-/
-- 没有依赖类型的世界：
def consNat (a : Nat) (as : List Nat) : List Nat := a :: as
def consBool (a : Bool) (as : List Bool) : List Bool := a :: as
def consString (a : String) (as : List String) : List String := a :: as
-- 每种类型都要写一遍！
/-这样会有什么问题？
代码重复：同样的逻辑要写无数遍
无法处理新类型：每次定义新类型，都要重新写所有函数
维护困难：修改逻辑要在所有地方都改-/
/-依赖类型的好处
有了依赖类型，你只需要写一次：-/
def cons (α : Type) (a : α) (as : List α) : List α :=
  List.cons a as
#check cons Nat
-- 输出：cons Nat : Nat → List Nat → List Nat
-- 意思：给定类型 Nat 后，cons Nat 是一个函数，接受一个 Nat 和一个 List Nat，返回 List Nat
#check cons Bool
-- 输出：cons Bool : Bool → List Bool → List Bool
-- 意思：给定类型 Bool 后，cons Bool 是一个函数，接受一个 Bool 和一个 List Bool，返回 List Bool
#check cons
-- 输出：cons (α : Type) (a : α) (as : List α) : List α
-- 意思：cons 的完整类型签名
/-实际使用：-/
-- 创建数字列表
#check cons Nat 1
#eval cons Nat 1 []                    -- 结果：[1]
#eval cons Nat 1 [2, 3]               -- 结果：[1, 2, 3]
#eval cons Nat 42 [10, 20, 30]        -- 结果：[42, 10, 20, 30]

-- 创建布尔值列表
#eval cons Bool true []                -- 结果：[true]
#eval cons Bool false [true, true]     -- 结果：[false, true, true]

-- 创建字符串列表
#eval cons String "hello" ["world"]    -- 结果：["hello", "world"]

/-定义变量使用-/

-- 定义一些列表
def numList : List Nat := [10, 20, 30]
def boolList : List Bool := [true, false]

-- 使用 cons 添加元素
def newNumList := cons Nat 5 numList     -- [5, 10, 20, 30]
def newBoolList := cons Bool true boolList -- [true, true, false]

#eval newNumList   -- [5, 10, 20, 30]
#eval newBoolList  -- [true, true, false]

/-在函数中使用-/
-- 定义一个使用 cons 的函数
def addToFront (α : Type) (x : α) (xs : List α) : List α :=
  cons α x xs

#eval addToFront Nat 100 [1, 2, 3]        -- [100, 1, 2, 3]
#eval addToFront String "hi" ["bye"]       -- ["hi", "bye"]
#check addToFront
#check addToFront Nat
#check addToFront Nat 100
#check addToFront Nat 100 [1 , 2, 3]

/-依赖函数类型的理论基础-/
-- 给定：
/-
α : Type          -- 一个类型
β : α → Type      -- 一个"类型族"（对每个 a : α，都有一个类型 β a）
-/

-- 那么：(a : α) → β a 就是依赖函数类型
/-
关键概念：β 是一个类型族（family of types）

对于 α 中的每个值 a，都有一个对应的类型 β a
这些类型可能都不同
-/

-- 例子：Vector 类型
-- Vector α n 表示长度为 n 的 α 类型向量

-- 这里 β 就是 "fun n => Vector α n"
-- 对于每个自然数 n，β n = Vector α n
#check @List.cons
#check @List.nil
#check @List.append

/-依赖积类型（Dependent Product Types）-/
-- 普通的积类型（笛卡尔积）：
-- α × β  -- 第一个元素类型是 α，第二个元素类型是 β
-- 依赖积类型：
-- (a : α) × β a  -- 第二个元素的类型依赖于第一个元素的值！
-- 也可以写成：Σ a : α, β a
-- 例子：存储一个类型和该类型的一个值
def example1 : Σ t : Type, t := ⟨Nat, 42⟩
-- 第一个元素：Nat（这是一个类型）
-- 第二个元素：42（类型是 Nat，依赖于第一个元素）

def example2 : Σ t : Type, t := ⟨String, "hello"⟩
-- 第一个元素：String（这是一个类型）
-- 第二个元素：\"hello\"（类型是 String，依赖于第一个元素）
universe u v
  def f (α : Type u) (β : α → Type v) (a : α) (b : β a) : (a : α) × β a :=
    ⟨a, b⟩
  def g (α : Type u) (β : α → Type v) (a : α) (b : β a) : Σ a : α, β a :=
    Sigma.mk a b
  #check f
  #check g
  def h1 (x : Nat) : Nat :=
    (f Type (fun α => α) Nat x).2
  #eval h1 5
  def h2 (x : Nat) : Nat :=
    (g Type (fun α => α) Nat x).2
  #eval h2 5
