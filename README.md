# Ruby_List_Comprehension
## An idiosyncratic Ruby approach to list comprehensions => 
## `$l[for x in 1..10 do math.sqrt(x) if (x**2).even? end]`
[![Gem Version](https://badge.fury.io/rb/ruby_list_comprehension.svg)](https://badge.fury.io/rb/ruby_list_comprehension)
### Ruby Tracker Feature request page https://bugs.ruby-lang.org/issues/16147 
### Ruby Gem home  https://rubygems.org/gems/ruby_list_comprehension
### Summary: List comprehensions are a flexible prototyping tool having iterations in multiple languages. While Ruby is already equipped with powerful enumerable methods, list comprehensions have some unique benefits: [] brackets make array return more intuitive, ruby_list_comprehension automatically determines whether to map, filter, or filter_map(>=2.7.0) which means less syntax to memorize, and beginners or experienced programmers from languages such as Python or Julia, where list comprehensions feature prominently, may find it easier to adapt to Ruby. 
## Instructions:

# N.B. some changes in 0.2.0
#### `~> gem install ruby_list_comprehension`
#### `require 'ruby_list_comprehension'`
#### # `include RubyListComprehension`

### Syntax: `$l[for x in 1..10 do x if x end]` (map and filter condition optional)

#### N.B. main block parameter(the for 'x' part) can be anything.
#### Other variables (e.g. your iterable) must be @instance or $globals variables      
#### e.g. @nums = [1,2,3]
### `$l[for x in @nums do x ** 3 - 2 if @nums.sum < 6 end] #=> [-1, 6, 25]`
### `$l[for num in $nums do num ** 3 - 2 if $nums.sum < 6 end] #=> [-1, 6, 25]`
### `$l[for x in (1..10).map{@1**2} do x if x end] #=> [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]`

## 1. List Comprehension Identity (Splat a range or call .entries on a hash)

### `$l[for x in 1..10 do end] #=> [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]`
### `$l[for x in 1..10 do end] #=> [[1, 1]]`
### `$l[for x in {1=>1} do end] #=> [1, 2]`
### `$l[for x in [1,2] do end] #=> [1, 2]`
### `$l[for x in [1,2] do end] #=> [1, 2]`
### `$l[for x in Set.new([1,2]) do end] #=> [1, 2]`

## 2. List Comprehension (Map)
### `$l[for x in 1..10 do x + 1 end] #=> [2, 3, 4, 5, 6, 7, 8, 9, 10, 11]`
### `$l[for my_var in 1..10 do my_var * my_var end] #=> [1, 4, 9, 16, 25, 36, 49, 64, 81, 100]`

## 3. List Comprehension (Filter)
#### `$l[for x in 1..10 do x if x > 5 end]`
#### `$l[for x in 1..10 do x 2 if x % 2 == 0 end]`

## 4. List Comprehension (FilterMap/Map&Compact for Ruby <= 2.7)
#### `$l[for x in 1..10 do x**2 if x > 5 end]`
#### `$l[for x in 1..10 do x ** 2 if x % 2 == 0 end]` 

#### # these examples are equivalent to the line below
#### `$l[for x in 1..10 do x**2 if x > 5 end]`
`(1..10).filter_map{@1 ** 2 if @1 > 5}` (both map and filter so under the hood we use filter_map or map with compact)
#
### `$l[for x in 1..10 do x end]` 
`[for x in 1..10 do x end]`  (exactly the same because no map or filter condition)
#
### `$l[for x in 1..10 do x ** 2 if x % 2 == 0 end]` 
`(1..10).filter_map{@1**2 if @1 % 2 == 0}`
#
#### require 'set'
#### `$l[for x in Set.new([1,2,3,4,5]) do x if x % 2 == 0 end]` 
`Set.new([1,2,3,4,5]).filter{@1 % 2 == 0}`

#### `$l[for x in [1,[1,2,3].reduce{|x,y|x+y}] do x if x end]`
`for x in [1,[1,2,3].reduce{|x,y|x+y}] do x if x end`  #(test if parser can distinguish hash {1=>1} from block {|x|x})

### Expanding support for nested comprehensions try it out let me know of any bugfixes needed
#### `$l[[for j in 1..5 do end], for i in 1..5 do end] => [[1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5], [1, 2, 3, 4, 5],  [1, 2, 3, 4, 5]]`

#### `$l[for x in 1..10; x if x % 2 == 0 end]` #(use `do` keyword if possible but there is support for semicolons)
`(1..10).filter{@1 % 2 == 0}`
#
#### `$l[for x in 1..10 ; x if x % 2 == 0 end]`  #(use `do` keyword if possible but there is support for semicolons)
`(1..10).filter{@1 % 2 == 0}`

#### `$l[for x in [1,2,3].reduce{|x,y|x+y}] do x if x end]`
`for x in [1,2,3].reduce{|x,y|x+y}] do x if x end`  #(test if parser can distinguish hash `{1=>1}` from block `{|x|x})`

### Expanding support for hash comprehensions try it out let me know of any bugfixes needed
## `$l[for x in {1=>1, 2=>2, 3=>3} do {x[0]**2 => x} if x end] #=> [{1=>[1,1]}, {4=>[2,2]}, {9=>[3,3]}]`
