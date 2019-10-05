# p '[for arr in matrix do for num in arr do end end]'
# MATRIX = [[1,2,3],[4,5],[6,7,8]]
# FLATTENED = MATRIX.flat_map{|arr|arr.map(&:itself)}
# MATRIX_STR = '[[for x in 1..3 do end] for y in 1..2 do end]'
# FLATTEN_STR = '[for arr in matrix do for num in arr do end end]'

# FLATTENER_REGEX = %r{\[\[(?<height>.+)\](?<length>.+)\]}
# BUILDER_REGEX = %r{\[\[(?<height>.+)(?=end\] for)(?<length>.+) end.*\]}
quadruple_nest1 = '[for x in 1..2 do for x in 3..4 do for x in 5..6 do for x in 6..7 do end end end end]'

triple_nest1 = '[for x in 1..2 do for x in 3..4 do for x in 5..6 do end end end]'
single_nest1 = '[for x in 1..2 do end]'
double_nest1 = '[for x in 1..2 do for x in 3..4 do end end]'

# len = triple_nest.split('for').length
# triple_array = triple_nest.split('for ')
# triple_array[-1] = triple_array[-1][0..-4*len]
# p triple_array

def denest(nested_list)
  len = nested_list.split('for')[1..-1].length
  nested_list_array = nested_list.split('for')[1..-1]
  nested_list_array[-1] = nested_list_array[-1][0..-4.3*len]
  nested_list_array.map(&->x{"[#{x[1..-1]}end]"})
end
denested = denest(quadruple_nest1)
p denested.map(&:op_type)
# p denest(quadruple_nest1).map(&:op_type)
# def nest_depth(nested_list)
#   denest(nested_list).length - 1
# end
# len = nest_depth(quadruple_nest1)
# p nest_depth(quadruple_nest1)

# len = nest_depth(quadruple_nest1)

denest(quadruple_nest1).each(&1.:p)