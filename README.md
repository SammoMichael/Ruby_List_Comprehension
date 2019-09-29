# Ruby_List_Comprehension
## Part of a proposal to add Ruby list comprehension syntax, your feedback is appreciated!
## Ruby Tracker Feature request page
### https://bugs.ruby-lang.org/issues/16147 
## Ruby Gem home
### https://rubygems.org/gems/ruby_list_comprehension
### gem install ruby_list_comprehension
# 
### in IRB 
### require 'ruby_list_comprehension'
### l = ListComprehension.new
### p l['for x in 1..10 do x**2 if x > 5 end'] == (1..10).filter_map{@1 ** 2 if @1 > 5} 
### p arr = l['for x in 1..10 do x end'] == [for x in 1..10 do x end] 
### p arr2 = l['for x in 1..10 do x ** 2 if x % 2 == 0 end'] == (1..10).filter_map{@1**2 if @1 % 2 == 0}
### p arr3 = l['for x in [1,2,3,4,5] do x if x % 2 == 0 end'] == [1,2,3,4,5].filter{@1 % 2 == 0}
### p arr4 = l['for x in 1..10 do x if x % 2 == 0 end']
### p arr5 = l['for x in 1..10 do x if x % 2 == 0 end']
### p arr6 = l['for x in 1..10 do x if x % 2 == 0 end']
### arr7 = l['for x in 1..10 do x if x % 2 == 0 end']
### arr9 = l['for x in 1..10; x if x % 2 == 0 end'] == (1..10).filter{@1 % 2 == 0}
### arr9 = l['for x in 1..10 ; x if x % 2 == 0 end'] == (1..10).filter{@1 % 2 == 0}
