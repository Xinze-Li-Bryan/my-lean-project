/-Lean provides you with the ability to group
 definitions into nested, hierarchical namespace:-/

namespace Foo
  def a: Nat := 5
  def f (x : Nat) : Nat := x + 7

  def fa : Nat := f a
  def ffa : Nat := f (f a)

#check a
#check f
#check fa
#check ffa
#print a
#print f
#print fa
#print ffa

end Foo
#check Foo.a
open Foo
#check a

#check List.nil
#check List.cons
#check List.map

open List
  #check nil
  #check cons
  #check map

/-Like sections, namespaces can be nested:-/
namespace Fooo
  def a : Nat := 5
  def f (x : Nat) : Nat := x + 7
  def fa : Nat := f a
  namespace Bar
    def ffa : Nat := f (f a)
    #check fa
    #check ffa
  end Bar
  #check fa
  #check Bar.ffa
end Fooo
#check Fooo.fa
#check Fooo.Bar.ffa
