/- Recall that the def keyword provides one
 important way of declaring new named objects.-/
 def double (x : Nat) : Nat :=
  x + x
#eval double 3
/- In this case you can think of def as a
kind of named fun. The following yields the
same result:-/
def double2 : Nat → Nat :=
  fun x => x + x
#eval double2 4

/-You can omit the type declarations when has
enough information to infer it. Type inference
is an important part of lean:-/

def double3 :=
  fun (x : Nat) => x + x

/-The right hand side bar can be any expression,
not just a lambda. So def can also be used to simply
name a value like this-/

def pi := 3.14
/-def can take multiple input parameters. Let's create
one that adds two natural numbers:-/
def add (x y : Nat) :=
  x + y
#eval add 4 5
/-The parameter list can be separated like this:-/
def add2 (x : Nat) (y : Nat) :=
  x + y
#eval add2 10 2

/-Notice here we called the double function to create
the first parameter to add. You can use other more interesting
expression inside a def:-/
def greater (x y : Nat) :=
  if x > y then x
  else y

#eval greater 10 13

/-You can also define a function that takes another function as
input. The following calls a given function twice passing the
output of the first invocation to the second-/

def doTwice (f: Nat → Nat) (x : Nat) : Nat :=
  f (f x)
#eval doTwice double 2

/-Now to get a bit more abstract, you can also specifiy arguments
that are like type parameters:-/
def compose (α β γ : Type) (g : β → γ) (f : α → β) (x : α) : γ :=
  g (f x)
def square (x : Nat) : Nat :=
  x * x
#eval compose Nat Nat Nat double square 3
