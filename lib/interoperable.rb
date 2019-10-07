require '../lib/junto'

include RubyList
# 3x the same identities
# p $l[for x in 1..10 do x end]
# p $l[for x in 1..10 do end]
# p [*1..10]

# map
# p $l[for x in 1..20 do x + 1 end]
# p $l[for x in 1..20 do x * x end]

# fill
# p $l[for x in 1..20 do true end]
# p Array.new(20, true)

# pseudo-filter(identity in disguise)
# p $l[for x in 1..20 do x if true end]

# filter
# p $l[for x in 1..100 do x if x > 70 end]

# filter_map
# p $l[for x in 1..100 do x**2 if x > 70 end]
# p $l[for x in 1..100 do 'hello' if x.even? end]
# p $l[for x in 1..100 do x**2 if x.is_a? Numeric end]

# reduce coming soon ...

# set comprehensions
require 'set'
# p $l[for x in Set.new([2,2,2,3,4,5]) do x.to_s end]
# p $l[for x in Set.new([1,2,2,3]) do x.chr end]

#hash comprehensions
# * or .entries a set
# p $l[for x in {1=>1, 2=>2} do end]
# * map an entry
# p $l[for x in {1=>1, 2=>2} do {x[0]*2=>x} end]

# nested_comps
# p [for x in 1..10 do for y in 1..10 do end end]
# p $l[for x in [[1,2,3],[4,5,6]] do for y in x do  y end  end ]
$a = 5
# p $l[for x in 1..10 do x-2 if $a>4  end]
# p $l[for x in 1..10 do $a**2  end]
# p $l[for x in 1..10 do $a  end]
#
# p $l[for x in 1..10 do x + 2 end]
# p $l[for x in 1..10 do    end]
# $nums = [[1,2,3],[4,5,6]]
# p $l[for cool in $nums do for c in $nums do c end end]
# p '   ;  '.match?(/(^A-Za-z1-9)/)

# p /\A\s*\Z/ === " f"
# a = $l[for x in ['a', 'b', 'c'] do p ('a'..x).map(&:ord) end]
# a = $l[for x in [1,2,3] do x + 2 if x > 2 end]
# a = $l[for x in ['a', 'b', 'c'] do x if x > 'a' end]
# a = $l[for x in ['a', 'b', 'c'] do x if x > 'a' end]
p $l[for x in 1..10 do x end]
# p a