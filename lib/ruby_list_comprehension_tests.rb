require './ruby_list_comprehension'

include RubyListComprehension

p $l[] == []
p $l[for x in 1..10 do end] == [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
p $l[for x in 1..3 do x + 2 end] == [3, 4, 5]
p $l[for x in 1..3 do x + 2 if x > 3 end] == [3, 4, 5]
p $l[for arr in [[1,2],[3,4]] do arr[0] end] == [1, 3]
([[1, 2], [3, 4]]).map{| arr |( arr[0] )}
p $l[[for j in 1..5 do end], for i in 1..5 do end]
p $l[for x in 1..10 do Math.sqrt(x) if (x**2).even? end] == [1.4142135623730951, 2.0, 2.449489742783178, 2.8284271247461903, 3.1622776601683795]
# (1..10).filter_map{| x |( Math.sqrt(x) )  if  ( (x**2).even? )} # > 2.7.0
@nums = [1,2,3]
p $l[for x in @nums do x end]
p $l[for x in @nums do x + 2 end]
$nums = [[1,2],[3,4],[5,6]]
p $l[for x in $nums do x[0] ** 3 - 2 if $nums[0].sum <= 6 end] #=> [-1, 25, 123]
# p ([[1, 2], [3, 4], [5, 6]]).filter_map{| x |( x[0] ** 3 - 2 )  if  ( $nums[0].sum <= 6 )} # > 2.7.0
# p ([1, 2, 3]).filter_map{| x |( x ** 3 - 2 )  if  ( @nums.sum <= 6 )} # > 2.7.0
p $l[for x in (1..10).map{ |x| x ** 2 } do x if x end] #=> [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
p $l[for x in 1..10 do end] #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
p $l[for x in 1..10 do end] #=> [[1, 1]]
p $l[for x in {1=>1} do end] #=> [1, 2]
p $l[for x in [1,2] do end] #=> [1, 2]
p $l[for x in [1,2] do end] #=> [1, 2]
p $l[for x in Set.new([1,2]) do end] #=> [1, 2]
p $l[for my_var in 1..10 do my_var * my_var end] #=> [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]
(1..10).map{| my_var |( my_var * my_var )}
p $l[for x in {1=>1, 2=>2, 3=>3} do {x[0]**2 => x} if x end] #=> [{1=>[1,1]}, {4=>[2,2]}, {9=>[3,3]}]
p $l[for x in [1,2,3]; x**x; p x end] + ([1, 2, 3]).map{| x |(  x**x; p x )} == [1, 2, 3, 1, 2, 3]
([1, 2, 3]).map{| x |(  x**x; x )}
$l[for x in [1,2,3] ; x**x; x end]
$l[for x in [1,2,3]; x**x; x end]
