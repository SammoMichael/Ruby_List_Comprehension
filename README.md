# Ruby_List_Comprehension
## An idiosyncratic Ruby approach to list comprehensions
[![Gem Version](https://badge.fury.io/rb/ruby_list_comprehension.svg)](https://badge.fury.io/rb/ruby_list_comprehension)
#### Ruby Tracker Feature request page https://bugs.ruby-lang.org/issues/16147 
#### Ruby Gem home  https://rubygems.org/gems/ruby_list_comprehension
#### Summary: List comprehensions are a powerful and flexible prototyping tool and have various iterations in multiple languages. While Ruby is already equipped with powerful enumerable methods, list comprehensions have some unique benefits: [] brackets make array return more intuitive, ruby_list_comprehension automatically determines whether to map, filter, or filter_map(>=2.7.0) which means less syntax and method names to memorize to start off with, and beginners or experienced programmers from languages such as Python or Julia, where list comprehensions feature prominently, may find it easier to adapt to Ruby. Currently supporting range, set, and array type iterables.
## Instructions:
#### ~> gem install ruby_list_comprehension

#### # require in IRB or Ruby file
#### require 'ruby_list_comprehension'
#### # instantiate a list comprehension object
#### l = ListComprehension.new
#
#### Now you can pass a string to the list_comp object using bracket notation
### Syntax: l + [] + 'for x in 1..10 do x if x' (map and filter condition optional)
# N.B. as of now please use x as your block parameter and other variables must be $ globals!(prefixed with dollar sign)
e.g. $nums = [1,2,3]
l['for x in $nums do x**3 - 2 if $nums.sum < 6 end'] #=> [-1, 6, 25]

#### # these examples are equivalent to the line below

#### l['for x in 1..10 do x**2 if x > 5 end'] 
(1..10).filter_map{@1 ** 2 if @1 > 5} (both map and filter so under the hood we use filter_map or map with compact)
#
#### l['for x in 1..10 do x end'] 
[for x in 1..10 do x end]  (exactly the same because no map or filter condition)
#
#### l['for x in 1..10 do x ** 2 if x % 2 == 0 end'] 
(1..10).filter_map{@1**2 if @1 % 2 == 0}
#
#### require 'set'
#### l['for x in Set.new([1,2,3,4,5]) do x if x % 2 == 0 end'] 
Set.new([1,2,3,4,5]).filter{@1 % 2 == 0}

#
#### l['for x in 1..10; x if x % 2 == 0 end'] #(use "do" keyword if possible but there is support for semicolons)
(1..10).filter{@1 % 2 == 0}
#
#### l['for x in 1..10 ; x if x % 2 == 0 end']  #(use "do" keyword if possible but there is support for semicolons)
(1..10).filter{@1 % 2 == 0}

### caching is defaulted to true you can change that with "l.caching = false" or print out the cache with p l.cache