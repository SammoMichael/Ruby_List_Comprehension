require './ruby_list_comprehension'
require 'benchmark'
require 'set'
l = ListComprehension.new
n = 5000000
p l

Benchmark.bm do |x|
  x.report { l[''] }
  x.report { l['for x in 1..10 do x'] }
  x.report { l['for x in 1..10 ;x+2 end'] }
  x.report { l['for x in 1..10 do x+2 end'] }
  x.report { (1..10).map{@1+2} }
  x.report { (1..10).map{@1+2} }
  x.report { l['for x in 1..10 do x end'] }
  x.report { l['for x in 1..10 do x end'] }
  x.report { (1..10).map{@1} }
  x.report { (1..10).map{@1} }
  x.report { l['for x in 1..10 ;x+2 end'] }
  x.report { l['for x in 1..10 ;x+2; end']}
  # x.report {}
  x.report { l['for x in 1..10 do x**2 if x > 5 end']}
  x.report {(1..10).filter_map{@1 ** 2 if @1 > 5}}
  x.report { l['for x in 1..10 do x end']}
  x.report {l['for x in Set.new(1..10) do x**2 if x > 2 end']}
  x.report { l['for x in 1..10 do x ** 2 if x % 2 == 0 end']}
  x.report { l['for x in 1..10 do x ** 2 if x % 2 == 0 end']}
  x.report {(1..10).filter_map{@1**2 if @1 % 2 == 0}}
  x.report { l['for x in [1,2,3,4,5] do x+2 if x % 2 == 0 end']}
  x.report {[1,2,3,4,5].filter{@1 % 2 == 0}}
  x.report { (1..10).filter{@1 % 2 == 0}}
  # x.report {}
  # x.report {}
  # p
  # p  ==
  # p  == [for x in 1..10 do x end]
  # p  ==
  # p arr3 =  ==
  # p arr4 = l['for x in 1..10 do x if x % 2 == 0 end']
  # p arr5 = l['for x in 1..10 do x if x % 2 == 0 end']
  # p arr6 = l['for x in 1..10 do x if x % 2 == 0 end']
  # p arr7 = l['for x in 1..10 do x if x % 2 == 0 end']
  # p arr9 = l['for x in 1..10; x if x % 2 == 0 end'] ==
  # p arr9 = l['for x in 1..10 ; x if x % 2 == 0 end'] == (1..10).filter{@1 % 2 == 0}

end



# p l['for x in 1..10 ; x+2 end']
# # p l['for x in 1..10do;x+2;end']
# # p for x in 1..10do;x+2;end
p l.cache
p l.op