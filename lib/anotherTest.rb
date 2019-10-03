require '../lib/ruby_list_comprehension'

l = ListComprehension.new

$a = [[1,2,3],[4,5,6]]

l[for arr in $a do for i in arr do end  end]