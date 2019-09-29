
require './ruby_list_comprehension.rb'
require 'prime'
require 'set'

l = ListComprehension.new
$var = [1,2,3]
p l['for x in $var; x**3 - 2 if $var.sum <= 6 end']
p l['for x in $var ;x+2 end'] == [1,2,3].map{@1+2}
p l['for x in 1..10 do x**2 if x > 5 end'] == (1..10).filter_map{@1 ** 2 if @1 > 5}
p arr = l['for x in 1..10 do x end'] == [for x in 1..10 do x end]
p arr2 = l['for x in 1..10 do x ** 2 if x % 2 == 0 end'] == (1..10).filter_map{@1**2 if @1 % 2 == 0}
p arr3 = l['for x in [1,2,3,4,5] do x if x % 2 == 0 end'] == [1,2,3,4,5].filter{@1 % 2 == 0}
p arr9 = l['for x in 1..10; x if x % 2 == 0 end'] == (1..10).filter{@1 % 2 == 0}
p arr9 = l['for x in 1..10 ; x if x % 2 == 0 end'] == (1..10).filter{@1 % 2 == 0}
# l = ListComprehension.new
# p l['for x in 1..[1,2,3].reduce{@1+@2} do x if x end']
# # p l["for x in {1=>1, 2=>2} do x if x end"]
# p l['for x in 1..10 do x if x end']
# p l['for x in Set.new(1..10) do x**2 if x > 2 end']
# p l['for x in 1..10 do x**2 if x > 5 end'] == (1..10).filter_map{@1 ** 2 if @1 > 5}
# p arr = l['for x in 1..10 do x end'] == [for x in 1..10 do x end]
# p arr2 = l['for x in 1..10 do x ** 2 if x % 2 == 0 end'] == (1..10).filter_map{@1**2 if @1 % 2 == 0}
# p arr3 = l['for x in [1,2,3,4,5] do x if x % 2 == 0 end'] == [1,2,3,4,5].filter{@1 % 2 == 0}
# p arr7 = l['for x in 1..10 do x if x % 2 == 0 end']
# p arr7 = l['for x in [*1..10] do x end']
# p arr7 = l['for x in (1..10) do x end']
# p arr9 = l['for x in 1..10 ; x if x % 2 == 0 end'] == (1..10).filter{@1 % 2 == 0}
# p arr9 = l['for x in 1..10; x if x % 2 == 0 end'] == (1..10).filter{@1 % 2 == 0}
# p arr9 = l[''] == []
# p l['for x in [] do x end']





# a = for x in Set.new([1,2,3]) do x**2 end
# Set.new([1,2,3]).filter_map(&->x{x+1 if x > 2})
# p a.each(&1.:p)
# p for x in Set.new([1,2,3]) do x**2 if x > 2 end
p l.version >= "2.3.0"
p l.cache
