/-Consider the following three function definitions-/
def compose (α β γ : Type) (g : β → γ ) (f : α → β) (x : α) : γ :=
  g (f x)
def doTwice (α : Type) (h: α → α) (x : α) : α :=
  h (h x)
def doThrice (α : Type) (h : α → α) (x : α) : α :=
  h (h (h x))
/- Lean provides you with the variable command to make such
 declarations look more compact:-/
variable (α β γ)
