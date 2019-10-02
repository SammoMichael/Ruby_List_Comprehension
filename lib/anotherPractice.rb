require './ruby_list_comprehension.rb'

l = ListComprehension.new
# p l['for x in 1..10 do x']
# l[for x in 1..10 do x + 1 end]
# p l
# p     l[for x in 1..10 do x + 1 end]
# p     l[for x in 1..10 do x + 1 end]
# p     l[for x in 1..10 do x + 1 end]
# p     l[for x in 1..10 do x + 1 end]
# p     l[for x in {"hi"=>"hi"} do {x[0]+"!"=>x[1]} end]
# p     l[for x in {"hi"=>"hi"} do {x[0]+"!"=>x[1]} end]
# p     l[for x in {"hi"=>2, } do {x[0]+"!"=>x[1]} end]
# p     l[for n in 1..3 do {n.succ =>n} end]
# p     (1..3).map(&->n do{n.succ => n}end)
# $chars = "sammy".chars
#
# p l[for char in "sammy".chars do char+"!" end]
$chars = %(a b c)
p l[for char in $chars.chars do char + "!" if char.ord> 30 end]