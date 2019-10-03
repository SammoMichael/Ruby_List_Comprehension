require './ruby_list_comprehension.rb'
require 'prime'
require 'set'
l = ListComprehension.new
# $var = [1, 2, 3]


# p l['for x in {1=>1}']
# p l['for x in Set.new([1,2,3])']
#
# p l['for x in 1..10 do x']
# p l['for x in {1=>1}']
# p l['for x in Set.new([1,2,3])']


# p l['for x in 1..10  do x+1']
# p l['for x in {1=>1}  ;{x*3=>x.length*2}']
# p l['for x in {1=>1}  ;{x*3=>x.length*2} if x.sum']
# p l['for x in {1=>1,2=>2}  ;{x*3=>x.length*2} if x.sum']
# p l['for x in {1=>1}  ;{x*3=>x.length*2} if x.sum']
# p l['for x in {1=>1}  ;{x*3=>x.length*2} if x.sum']
require 'set'
# p l['for x in Set.new([[1,2,3],[4,5,6]]); {x=>x} if x.sum']
# p l['for x in Set.new([[1,2,3],[1,2,3],[4,5,6]]); {x=>x} if x.sum']
# p l['for x in Set.new([[1,2,3],[1,2,3],[4,5,6]]); {x=>x}']
# p l['for x in Set.new([[1,2,3],[4,5,6]]); {x=>x} if x.sum']
def other_method
  true
end

# p l['for num in (1..10) do num if other_method ']
# p $h.map{|e| {e*3 => e.length*2}}
# p l['for x in {1=>1, 2=>2, 3 => 3}  ']
# $h = {1=>1}
# p l['for x in Set.new([1,2,3])']
#
# for x in 1..10 do x + 1 if x.even? end
# p l['for x in {1=>1}']
# p l['for x in Set.new([1,2,3])']
require 'set'
require 'readline'
# p l['for x in 1..10']
# p l['for x in {1=>1}']
# x = {1=>1}
# p x.entries
# p l['for x in [1,2]']
# p l['for x in [1,2]']
# p l['for x in Set.new([1,2])']

# p l['for x in 1..10 do x + 1']
# p l['for my_var in 1..10 do my_var * my_var']
# arr = readlines($0)
# p arr
l = ListComprehension.new
# file = File.open($0)
# file_data = file.readlines.map(&:chomp)
# p l[file_data[37]]
# p file_data.index('for x in 1..10 do x + 1 if x.even? end')
l[for x in 1..10 do x if x != 1 end]
l[for x in 1..10 do x if x != 1 end]
# class Kernel
#   def [](args)
#     p 'hi'
#     l[args]
#   end
#
# end
# def [](args)
#   l = ListComprehension.new
#   p 'hi'
#   l[args]
# end

def *(args)
  l[args]
  end
# def `(args)
#   l = ListComprehension.new
#   l[args]
# end
# class Main
#   def *(args)
#     l[args]
#   end
#   def []args
#     p 'hi'
#   end
# end
# class BasicObject
#   def *(args)
#     # p 'hi'
#     l[args]
#   end
# end
#
# class Array
#   def initialize
#     p 'hi'
#   end
#   def []args
#     super
    l = ListComprehension.new
#     p l
#       # l.(args)
#   end
# end
# class Main
#   def self(args)
#     l[args]
#     end
#   def self.l
#     l[args]
#   end
# end
# p l[for x in 1..10 do x if x.even? end].sum + l[for x in 5..50 do x if x.even? end].sum + l[for x in 1..30 do x if x.even? end].sum
#
# p l[for x in 1..10 do x * 1 end] + l[for x in 1..10 do x - 1 end]  << l[for x in 1..10 do x - 10 end].sum
#
$a = [[1,2,3],[4,5,6]]

p l[for arr in $a do for i in arr do i end; end]
# @cache2 = []
# p l[for arr in [[1,2,3],[4,5,6]] do for i in arr do $* << i end; end]
# p $*
# p l[for arr in [[1,2,3],[4,5,6]] do for x in arr do x*2 end end]
# p l[for arr in [[1,2,3],[4,5,6],[7,8,9]] do for x in arr do x**2 end end]
# p l[for arr in [[1,2,3],[4,5,6]] do for x in arr do x*2 if x.even? end end]
# p l[for arr in [[1,2,3],[4,5,6]] do for x in arr ; x+2 if x end end]
# p l[for arr in [[1,2,3],[4,5,6]] ; for x in arr ; x if x % 2 == 0 end end]
# p l[for arr in [[1,2,3],[4,5,6]] do for x in arr do x if x % 2 == 0 end end]
# # p l[for arr in [[1,2,3],[4,5,6]] do for x in arr do x if x end end]
# p l[for arr in [[1,2,3],[4,5,6]] do for x in arr do x if x end end]
# p l[for arr in [[{1=>1},{2=>2}]] do for x in arr do x if x end end]
# # print *$a
#
# p l.op
# # p [[1,2,3],[4,5,6]].flat_map{@2*2}
# # p @cache2
#
#
#
#
#
#
#
# # p (2..20).filter(&:even?).sum * (1..10).sum
# # p l[for x in [1,2]; x + 2 end].sum
# # p [1,2].map{@1+2}.sum
# # p l[for x in 1..10 do x if x.even? end].sum + l[for x in 5..50 do x if x.even? end].sum
# # p l[for x in 1..10 do x if x.even? end]
# # p l[for x in 1..10 do x if x.even? end]
# # p for x in 1..10 do x if x.even? end
# # # p l.op
# # # p l['for x in {} do end']
# # # p l['for x in {} do end']
# # p l['for x in {1=>1} do end']
# # p l['for x in {1=>1} do']
# # p l['for x in {1=>true, 2=>false}  ;{x[0] => x[1]} ']
# # p l['for x in {1=>true, 2=>false}; {x[0] => x[1]} ']
# # p l['for x in {1=>true, 2=>false} ; {x[0] => x[1]} ']
# # p l['for x in {1=>1} do x if x end']
# # # p l['for x in {} do x if x end']
# # # p l['for x in {1=>1,2=>2,3=>3}; x if x end']
# # # p l['for x in {1=>1, 2=>2, 3=>3} do {1=>2} if x end']
# # # p l.op
# # # p l['for x in {1=>1, 2=>2, 3=>3} do {2=>2} if x end']
# # # p l['for x in {1=>1, 2=>2, 3=>3} do {x[0]**2 => x} if x end']
# # # p l['for x in {1=>1, 2=>2, 3=>3} do {x[0]**2 => x} if x end']
# # # p l['for x in {1=>1,2=>2,3=>3}; x if x end']
# # # p l['for x in 1..10 do x if x end']
# # # p l['for x in $var; x**3 - 2 if $var.sum <= 6 end']
# # # p l['for x in $var; x**3 - 2 if $var.sum <= 6 end']
# # # p l['for x in $var ;x+2 end'] == [1, 2, 3].map { |x| x + 2 }
# # # p l['for x in 1..10 do x**2 if x > 5 end'] == (1..10).map { |x| x**2 if x > 5 }.compact!
# # # p arr = l['for x in 1..10 do x end'] == [for x in 1..10 do x end]
# # # p arr2 = l['for x in 1..10 do x ** 2 if x % 2 == 0 end'] == [*1..10].map { |x| x**2 if x % 2 == 0 }.compact!
# # # p arr3 = l['for x in [1,2,3,4,5] do x if x % 2 == 0 end'] == [1, 2, 3, 4, 5].filter { |x| x % 2 == 0 }
# # # p arr9 = l['for x in 1..10; x if x % 2 == 0 end'] == (1..10).filter { |x| x % 2 == 0 }
# # # p arr9 = l['for x in 1..10 ; x if x % 2 == 0 end'] == (1..10).filter { |x| x % 2 == 0 }
# # # p l['for x in [1,[1,2,3].reduce{|x,y|x+y}] do x if x end'] == for x in [1, [1, 2, 3].reduce { |x, y| x + y }] do x if x end
# # # p l["for x in {1=>1, 2=>2} do x if x end"]
# # # p l['for x in 1..10 do x if x end']
# # # p l['for x in Set.new(1..10) do x**2 if x > 2 end']
# # # p l['for x in 1..10 do x**2 if x > 5 end'] == (1..10).map { |x| x**2 if x > 5 }.compact!
# # # p l['for x in 1..10 do x end']
# # # p l["for x in [1,2,3,4] do x end"]
# # # p l['for x in 1..10 do x ** 2 if x % 2 == 0 end'] == (1..10).map { |x| x**2 if x % 2 == 0 }.compact!
# # # p arr3 = l['for x in [1,2,3,4,5] do x if x % 2 == 0 end'] == [1, 2, 3, 4, 5].filter { |x| x % 2 == 0 }
# # # p arr7 = l['for x in 1..10 do x if x % 2 == 0 end']
# # # p arr7 = l['for x in [*1..10] do x end']
# # # p arr7 = l['for x in (1..10) do x end']
# # # p arr9 = l['for x in 1..10 ; x if x % 2 == 0 end'] == (1..10).filter { |x| x % 2 == 0 }
# # # p arr9 = l['for x in 1..10; x if x % 2 == 0 end'] == (1..10).filter { |x| x % 2 == 0 }
# # # p l[''] == []
# # # p l['for x in [] do x end']
# # # p l['for x in {1=>1} do x if x end']
# # # p l['for x in {} do x if x end']
# # # p l['for x in {1=>1,2=>2,3=>3}; x if x end']
# # # p l['for x in {1=>1, 2=>2, 3=>3} do {2=>2} if x end']
# # # p l['for x in {1=>1, 2=>2, 3=>3} ; {2=>2} if x end']
# # # p l['for x in {1=>1, 2=>2, 3=>3} do {x[0]**2 => x} if x end']
# # # p l['for x in {1=>1,2=>2,3=>3}; x if x end']
# # # p l['for x in 1..10 do x if x end']
# # # p l['for x in $var; x**3 - 2 if $var.sum <= 6 end']
# # # p l['for x in $var; x**3 - 2 if $var.sum <= 6 end']
# # # p l['for x in $var ;x+2 end'] == [1, 2, 3].map { |x| x + 2 }
# # # p l['for x in 1..10 do x**2 if x > 5 end'] == (1..10).map { |x| x**2 if x > 5 }.compact!
# # # p arr = l['for x in 1..10 do x end'] == [for x in 1..10 do x end]
# # # p arr2 = l['for x in 1..10 do x ** 2 if x % 2 == 0 end'] == [*1..10].map { |x| x**2 if x % 2 == 0 }.compact!
# # # p arr3 = l['for x in [1,2,3,4,5] do x if x % 2 == 0 end'] == [1, 2, 3, 4, 5].filter { |x| x % 2 == 0 }
# # # p arr9 = l['for x in 1..10; x if x % 2 == 0 end'] == (1..10).filter { |x| x % 2 == 0 }
# # # p arr9 = l['for x in 1..10 ; x if x % 2 == 0 end'] == (1..10).filter { |x| x % 2 == 0 }
# # # p l['for x in [1,[1,2,3].reduce{|x,y|x+y}] do x if x end'] == for x in [1, [1, 2, 3].reduce { |x, y| x + y }] do x if x end
# # # p l["for x in {1=>1, 2=>2} do x if x end"]
# # # p l['for x in 1..10 do x if x end']
# # # p l['for x in Set.new(1..10) do x**2 if x > 2 end']
# # # p l['for x in 1..10 do x**2 if x > 5 end'] == (1..10).map { |x| x**2 if x > 5 }.compact!
# # # p l['for x in 1..10 do x end']
# # # p l["for x in [1,2,3,4] do x end"]
# # # p l['for x in 1..10 do x ** 2 if x % 2 == 0 end'] == (1..10).map { |x| x**2 if x % 2 == 0 }.compact!
# # # p arr3 = l['for x in [1,2,3,4,5] do x if x % 2 == 0 end'] == [1, 2, 3, 4, 5].filter { |x| x % 2 == 0 }
# # # p arr7 = l['for x in 1..10 do x if x % 2 == 0 end']
# # # # p arr7 = l['for x in [*1..10] do x end']
# # # # p arr7 = l['for x in (1..10) do x end']
# # # # p arr9 = l['for x in 1..10 ; x if x % 2 == 0 end'] == (1..10).filter{|x|x % 2 == 0}
# # # # p arr9 = l['for x in 1..10; x if x % 2 == 0 end'] == (1..10).filter{|x|x % 2 == 0}
# # # # p arr9 = l[''] == []
# # # # p l['for x in [] do x end']
# # # p l['for x in [] do x end'] == for x in [] do x end
# # # p l.version >= "2.3.0"
# # # p l.cache
# # # $h = { 1 => 1, 2 => 2, 3 => 3 }
# # # p l['for x in 1..10 do 10 end ; p x']
# # # p l['for x in $h do {x.first.to_s => x.last/2} if x.first.is_a? Symbol']
# # # p $h.map { |k, v| { k.to_s => v / 2 } if k.is_a? Symbol }
# # # p $h.map do |k, v| { k**2 => v / 2 } if k.even? end
# # # p l['for x in 1..10 do 10 end ; p x']
# # # p l['for x in 1..10 do 10 end ; p x']
# # # p l['for x in 1..10 do 10 end ; p x']
# # # p l['for x in 1..10 do 10 end ; p x']
# # # #
# # # # # p Hash({"one":1})
# # # # $nums = [*1..10]
# # # # def list_comp(l, str)
# # # #   l[str]
# # # # end
# # # # # p list_comp l, 'for x in $h do {x => 1} '
# # # # # p list_comp l, 'for x in $nums do 10 if x.even?'
# # # # # p list_comp l, 'for x in $nums do 10 if x.is_a? Numeric'
# # # # # p l.op
# # # # # p 3.is_a? Numeric
# # # # # p list_comp l, 'for x in $nums do 10 if x.even?'
# # # # # p list_comp l, 'for x in 1..10; x.to_s if x > 2 '
# # # # $nums = 1..10
# # # # require 'set'
# # # # # p list_comp l, 'for graprefruit in $nums do graprefruit if graprefruit.odd?'
# # # # # p list_comp l, 'for graprefruit in $nums do graprefruit + 2 if graprefruit'
# # # # p list_comp l, 'for graprefruit in {1=>1, 2=>2} do graprefruit'
# # # # p list_comp l, 'for graprefruit in {1=>1, 2=>2} do graprefruit'
# # # # p l.op
# # # # p list_comp l, 'for graprefruit in $nums do graprefruit if $nums.sum.odd?'
# # # # p list_comp l, 'for graprefruit in $nums do graprefruit if ($nums.sum - graprefruit).odd?'
# # # # p list_comp(l, )
# # # # p list_comp l, '[]'
# # # # p list_comp l, 'for z in 1..10 do z'
# # # # p list_comp l, 'for z in 1..10 do z'
# # # # p list_comp l, 'for z in $nums do z.even? if z + $nums.sum > 5'
# # # # p list_comp l, 'for z in 1..10 ; z.to_s if z > 2 '
# # # # p list_comp l, 'for z in 1..10 ; z.to_s if z > 2 '
# # # # p list_comp l, 'for x in 1..10; x.to_s if x > 2 '
# # # # p list_comp l, 'for y in 1..10; y.to_s if y > 2'
# # # # p list_comp l, 'for z in 1..10; z.to_s if z > 2 '
# # # # p list_comp l, 'for z in 1..10; z.to_s if z > 2 '
# # # # p list_comp l, 'for z in 1..10; z.to_s if z > 2 '
# # # # p list_comp l, 'for z in 1..10; z.to_s if z > 2 '
# # # # p list_comp l, 'for z in 1..10; z.to_s if z > 2 '
# # # # p list_comp l, 'for z in 1..10; z.to_s if z > 2 '
# # # # p list_comp l, 'for z in 1..10; z.to_s if z > 2 '
# # # # p list_comp l, 'for z in 1..10; z.to_s if z > 2 '
# # # # p list_comp l, ' for z in 1..10 do z if z != 5   end'
# # # # p list_comp l, ' for z in 1..10 do z if z != 5   end'
# # # # p list_comp l, 'for x in 1..10 do 10 end'
# # p l.cache
# # # # p l.cache_count
#
#
#
