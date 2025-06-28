/-One way in which Lean's dependent type theory
 extends simple type theory is that types themselves
 -entites like Nat and Bool are first-class citizens,
which is to say that they themselves are objects. For
that to be the case, each of them also has to have a
type.-/

#check Nat
#check Bool
#check Nat → Bool
#check Nat × Bool
#check Nat → Nat
#check Nat × Nat → Nat
#check Nat → Nat → Nat
#check Nat → Nat → Nat
#check Nat → (Nat → Nat)
#check Nat → Nat → Bool
#check (Nat → Nat) → Nat

/-You can see that each one of the expressions above is
and object of type Type. You can also declare new
constants for types:-/

def α : Type := Nat
def β : Type := Bool
def F : Type → Type := List
def G : Type → Type → Type := Prod
#check α
#check F α
#check F Nat
#check G α
#check G α β

/- As the example above suggests, you have already seen
an example of a function of type Type → Type →
Type, Namely, the Cartesian produch Prod-/

#check Prod α β
#check α × β

#check Prod Nat Nat
#check Nat × Nat

/-Here is another example: given any type α, the type
List α denotes the type of lists of elements of type
α-/

#check List α
#check List Nat

/-Given that every expression in Lean has a type, it is
natural to ask: what type does Type itself have?-/

#check Type

/-You have actually come up against one of the most
subtle aspects of Lean's typing system. Lean's
underlying foundation has an infinite hierarchy of
types:-/
#check Type 1
#check Type 2
#check Type 3
#check Type 4

/- Think of Type 0 as a universe of “small” or
“ordinary” types. Type 1 is then a larger universe of
types, which contains Type 0 as an element, and
Type 2 is an even larger universe of types, which
contains Type 1 as an element. The list is infinite:
there is a Type n for every natural number n. Type
is an abbreviation for Type 0:-/

#check List
/-这里Prod.{u, v} (α : Type u) (β : Type v) : Type (max u v)
中的max是为了处理更高层级的宇宙体-/
#check Prod
/-To define polymorphic constants, Lean allows you
to declare universe variables explicitly using the
universe command:-/
universe u
def F' (α : Type u) : Type u := α × α
#check F'
/-You can avoid the universe command by providing
 the universe parameters when defining F:-/
def G'.{v} (α : Type v) : Type v := α × α
#check G'
