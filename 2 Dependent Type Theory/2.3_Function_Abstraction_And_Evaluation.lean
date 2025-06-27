/-Lean provides a fun (or λ) keyword to create
a function from an expression as follows:-/
#check fun (x : Nat) => x + 5
-- λ and fun mean the same thing
#check λ (x : Nat) => x + 5
 /-The type Nat can be inferred in this example:-/
#check fun x => x + 5
#check λ x => x + 5
/-You can evaluate a lambda function by passing
 the required parameters:-/
#eval (λ x : Nat => x + 5) 10

#check fun x : Nat => fun y : Bool => if not y then x + 1 else x + 2
/-总结：第一个箭头创建了一个"函数工厂"，
给它参数，它就给你一个新的专用函数！-/
#check fun (x : Nat) (y : Bool) => if not y then x + 1 else x + 2
#check fun x y => if not y then x + 1 else x + 2
/-为什么有三种写法？

写法1：展示了函数的数学本质（嵌套lambda）
写法2：更符合编程习惯（多参数）
写法3：最简洁（类型推断）

类比理解：就像中文可以说"我去商店买苹果"、
"我到商店购买苹果"、"我买苹果去商店"——
意思相同，表达方式不同！-/
-- 可以"部分使用"函数
def myFunc := fun x : Nat => fun y : Bool => if not y then x + 1 else x + 2
-- 创建专用版本
def add1or2to10 := myFunc 10
-- 重复使用
#eval add1or2to10 true
#eval add1or2to10 false
--更符合编程习惯（多参数）的计算案例
def myFunc2 := fun (x : Nat) (y : Bool) => if not y then x + 1 else x + 2
#eval myFunc2 30 true

/-介绍一些用lambda抽象来描述的常见函数操作。-/
-- 函数f：把数字变成字符串
def f (n : Nat) : String := toString n
-- 函数g：检查字符串是否非空
def g (s : String) : Bool := s.length > 0
#eval f 42
#eval g ""
#eval g "lean"
/-用这两个函数能做什么操作-/
--嵌套函数：先把数字转字符串，再检查是否非空
--我们可以直接写成以下形式简单形式
def compose1 := fun n => g (f n)
--也可以传统写法
def compose2 (n : Nat) : Bool := g (f n)
--带类型注解的写法
def compose3 : Nat → Bool := fun n => g (f n)
#eval compose1 10
#eval compose1 0
#eval compose2 20
#check fun x : Nat => x
--自然数的恒等映射
def natIdentity : Nat → Nat := fun x => x
#eval natIdentity 20

-- 高阶函数和类型参数详解

-- ==== 第一个例子：函数作为参数 ====
#check fun (g : String → Bool) (f : Nat → String) (x : Nat) => g (f x)
-- 分解理解：
-- 参数1：g : String → Bool  （一个从String到Bool的函数）
-- 参数2：f : Nat → String   （一个从Nat到String的函数）
-- 参数3：x : Nat            （一个自然数）
-- 返回：g (f x)             （先用f处理x，再用g处理结果）
-- 完整类型：(String → Bool) → (Nat → String) → Nat → Bool
-- 意思是：给我两个函数和一个数，我返回一个布尔值
-- ==== 实际使用第一个例子 ====
-- 定义一些具体的函数
    --第一个是从Nat变成String.
def toString_func : Nat → String := fun n => toString n
    --第二个是从String变成Bool
def isLong : String → Bool := fun s => s.length > 2
    -- 使用高阶函数
def myComposer := fun (g : String → Bool) (f : Nat → String) (x : Nat) => g (f x)
    -- 测试高阶函数
#eval myComposer isLong toString_func 123  /-123的长度大于2-/
#eval myComposer isLong toString_func 5    /-5的长度小于2-/
-- ==== 第二个例子：类型也可以作为参数！ ====
/-在上一个例子中，我们指定了type是Nat, String, Bool
 这里我们把Type也当成参数，这让函数变得完全通用！可以
 处理任何类型的组合-/
#check fun (α β γ : Type) (g : β → γ) (f : α → β) (x : α) => g (f x)
-- 分解理解：
-- 参数1：α : Type          （一个类型）
-- 参数2：β : Type          （另一个类型）
-- 参数3：γ : Type          （第三个类型）
-- 参数4：g : β → γ         （从β到γ的函数）
-- 参数5：f : α → β         （从α到β的函数）
-- 参数6：x : α             （α类型的值）
-- 返回：g (f x)            （组合函数的结果）

-- 完整类型：(α β γ : Type) → (β → γ) → (α → β) → α → γ
-- 定义通用的函数组合器
#check (fun x : Nat => x) 1
