# Ruby_List_Comprehension
## An idiosyncratic Ruby approach to list comprehensions
[![Gem Version](https://badge.fury.io/rb/ruby_list_comprehension.svg)](https://badge.fury.io/rb/ruby_list_comprehension)
#### Ruby Tracker Feature request page https://bugs.ruby-lang.org/issues/16147 
#### Ruby Gem home  https://rubygems.org/gems/ruby_list_comprehension
#### Summary: List comprehensions are a powerful and flexible prototyping tool and have various iterations in multiple languages. While Ruby is already equipped with powerful enumerable methods, list comprehensions have some unique benefits: [] brackets make array return more intuitive, ruby_list_comprehension automatically determines whether to map, filter, or filter_map(>=2.7.0) which means less syntax and method names to memorize to start off with, and beginners or experienced programmers from languages such as Python or Julia, where list comprehensions feature prominently, may find it easier to adapt to Ruby. Currently supporting range, set, hash, and array type iterables.
## Instructions:
#### ~> gem install ruby_list_comprehension

#### # require in IRB or Ruby file
#### require 'ruby_list_comprehension'
#### # instantiate a list comprehension object
#### l = ListComprehension.new
#
#### Now you can pass a string to the list_comp object using bracket notation

### Syntax: l + [] + 'for x in 1..10 do x if x end' (map and filter condition optional)

#### N.B. main block parameter(the for 'x' part) can be anything but other variables (e.g. your iterable) must be $ globals!(prefixed with dollar sign)         
#### e.g. $nums = [1,2,3]
### l['for x in $nums do x ** 3 - 2 if $nums.sum < 6 end'] #=> [-1, 6, 25]
### l['for num in $nums do num ** 3 - 2 if $nums.sum < 6 end'] #=> [-1, 6, 25]


## 1. List Comprehension Identity (Splat a range or call .entries on a hash)
### l['for x in 1..10'] #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
### l['for x in 1..10'] #=> [[1, 1]]
### l['for x in {1=>1}'] #=> [1, 2]
### l['for x in [1,2]'] #=> [1, 2]
### l['for x in [1,2]'] #=> [1, 2]
### l['for x in Set.new([1,2])'] #=> [1, 2]

## 2. List Comprehension (Map)
### l['for x in 1..10 do x + 1'] #=> [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
### l['for my_var in 1..10 do my_var * my_var'] #=> [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]

## 3. List Comprehension (Filter)
#### l['for x in 1..10 do x if x > 5 end'] 
#### l['for x in 1..10 do x 2 if x % 2 == 0 end'] 


## 4. List Comprehension (FilterMap/Map&Compact for Ruby < 2.7)
#### l['for x in 1..10 do x**2 if x > 5 end'] 
#### l['for x in 1..10 do x ** 2 if x % 2 == 0 end'] 




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

#### l['for x in [1,[1,2,3].reduce{|x,y|x+y}] do x if x end']
for x in [1,[1,2,3].reduce{|x,y|x+y}] do x if x end  #(test if parser can distinguish hash {1=>1} from block {|x|x})

## Expanding support for hash comprehensions try it out let me know of any bugfixes needed
#### l['for x in {1=>1, 2=>2, 3=>3} do {x[0]**2 => x} if x end']


### caching is defaulted to true you can change that with "l.caching = false" or print out the cache with p l.cache
### there are also instance variables for a list of operators (l.op) and some other utilities in the ListComprehension object
