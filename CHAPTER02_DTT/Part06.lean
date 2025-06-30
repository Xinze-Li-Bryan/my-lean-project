/-Consider the following three function definitions-/
def compose (α β γ : Type) (g : β → γ ) (f : α → β) (x : α) : γ :=
  g (f x)
def doTwice (α : Type) (h: α → α) (x : α) : α :=
  h (h x)
def doThrice (α : Type) (h : α → α) (x : α) : α :=
  h (h (h x))
/- Lean provides you with the variable command to make such
 declarations look more compact:-/
section v1
  variable (α β γ : Type)
  def composev (g : β → γ) (f : α → β) (x : α) : γ :=
    g (f x)
  def doTwicev (h : α → α) (x : α) : α :=
    h (h x)
  def doThricev (h : α → α) (x : α) : α :=
    h (h (h x))
end v1
/-You can declare variables of any type, not just Type itself:-/
section v2
  variable (α β γ : Type)
  variable (g : β → γ) (f : α → β) (h : α → α)
  variable (x : α)
  def composevv := g (f x)
  def doTwicevv := h (h x)
  def doThricevv := h (h (h x))
  #print composevv
  #print doTwicevv
  #print doThricevv
  -- #print用于显示定义的完整内容，包括定义体、类型等
end v2
