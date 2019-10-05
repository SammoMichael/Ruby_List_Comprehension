# $i = 0
# FILTER_MAP_REGEX = %r{for(?<parameter#{$i}>.+)in(?<iterable#{$i}>.+)do(?<mappable#$i>.*)if(?<filterable#{$i}>.+)end}
# MAP_REGEX = %r{for(?<parameter#{$i}>.+)in(?<iterable#{$i}>.+)do(?<mappable$i>.*)if(.+)end}
# # IDENTITY_REGEX = %r{for(?<parameter#{$i}>.+)in(?<iterable#$i>.+)do(?<identity#$i>.)end}
# # regex = %r{for(?<parameter#{k}>.+)in(?<iterable#{k}>.+)do(?<mappable>.*)if(?<filterable#{k}>.+)end}
# def process_match(match)
#   match
# end
# args = [
#     # 'for x in 1..10 do x + 2 if x end', # map
#     # 'for i in 2..20 do i if i end', # identity
#     # 'for i in 3..30 do i end', #
#     # 'for i in 4..40 do i + 2 end',
#     'for $i in 4..40 do if $i == 8 end',
#     'for num in 4..40 do num end',
#     # 'for i in 4..40 do end',
# # ]
# # #
# # # match0 = args[0].match(FILTER_MAP_REGEX)
# # # match1 =
# # # p match0
# # # iterable0, mappable0, filterable0 = match0[:iterable0], match0[:mappable0], match0[:filterable0]
# # # p iterable0, mappable0, filterable0
# # ## filter
# # # p (4..40).select{|x|x != 8}
# #
# # ## nested_matrix
# # # [for x in [for x in 1..10 do end] do end]
# # ## nested_flatten
# # # [for arr in $a do for i in arr do end  end]
# # # [[j for j in range(5)] for i in range(5)]
# # build_matrix_comp =  "[[for j in 1..5 do end] for i in 1..5 do end]"
# # list1, list2 = build_matrix_comp.split('end]')
# # # p list1, list2
# # list1 = " #{list1.slice!(2,list1.length)}"
# # iterable = 1..5
# # # p iterable.map{|n|iterable.map(&:itself)}
# # # p process_match(build_matrix_comp[1..build_matrix_comp.index(']')].match(IDENTITY_REGEX))
# # # flatten matrix
# # matrix = [1, 2, 3], [4, 5], [6, 7, 8, 9]
# OPERATION = 1
# # DEPTH_LIST_COMP = build_matrix_comp.scan(' end').length
#
# # case DEPTH_LIST_COMP
# # when 1
# #   p 'list_comp'
# # when 2
# #   p 'nested_list_comp'
# # when 3
# #   p 'triple_nested'
# # when 4
# #   p 'quadruple_nested'
# # when 5
# #   p 'are you sure you wanna be doing this?...'
# # end
#
# FLATTENER_REGEX = %r{\[\[(?<height>.+)\](?<length>.+)\]}
# # BUILDER_REGEX = %r{\[(?<height>.+) do (?<length>.+)end end.*\]}
#
# # flatten_list_comp
# FLATTEN_STR = '[for arr in matrix do for num in arr do end end]'
# # matrix_list_comp
# MATRIX_STR = '[[for x in 1..3 do end] for y in 1..2 do end]'
# # matrix_match = matrix_str.match(%r{\[\[(?<height>.+)\](?<length>.+)\]})
# FLAT_MATCH = FLATTEN_STR.match(%r{\[(?<height>.+)(?=for)(?<length>.+)end end.*\]})
# FLAT_MATCH_FIRST = FLAT_MATCH[:height][0..-2] << ' end' if FLAT_MATCH
# FLAT_SECOND = FLAT_MATCH[:length][0..-2] << ' end' if FLAT_MATCH
# p FLAT_MATCH_FIRST
# # p matrix_match[0]
# p FLAT_SECOND
# # # IDENTITY_REGEX = %r{for(?<parameter#{$i}>.+)in(?<iterable#$i>.+)do(?<identity#$i>.)end}
#
# FLAT_SECOND_MATCH = FLAT_SECOND.match(IDENTITY_REGEX)
# FLAT_FIRST_MATCH = FLAT_MATCH_FIRST.match(IDENTITY_REGEX)
# ITERABLE2 = FLAT_SECOND_MATCH[:iterable]
# # p ITERABLE1
# # ITERABLE1 = FLAT_MATCH_FIRST[:iterable]
#
# ITERABLE1, PARAMETER1, IDENTITY1 = FLAT_FIRST_MATCH[:iterable], FLAT_FIRST_MATCH[:parameter], FLAT_FIRST_MATCH[:identity]
# p ITERABLE1, PARAMETER1, IDENTITY1
# MATRIX = [[1,2,3],[4,5],[6,7,8]]
# FLATTENED = MATRIX.flat_map{|arr|arr.map(&:itself)}
# p FLATTENED
#
# ## todo BUILDER
# BUILDER_REGEX = %r{\[\[(?<height>.+)(?=end\] for)(?<length>.+) end.*\]}
# # BUILDER_REGEX = %r{\[(?<height>.+) do (?<length>.+)end end.*\]}
# MATRIX_STR
# BUILDER_MATCH = MATRIX_STR.match(BUILDER_REGEX)
# BUILD_FIRST = " #{BUILDER_MATCH[:height]}end "
# BUILD_SECOND = " #{BUILDER_MATCH[:length][4..-1]} end "
# BUILD_FIRST_MATCH = BUILD_FIRST.match(IDENTITY_REGEX)
# p BUILD_SECOND_MATCH = BUILD_SECOND.match(IDENTITY_REGEX)
# ITERABLE6, PARAMETER7, IDENTITY8 = BUILD_SECOND_MATCH[:iterable], BUILD_SECOND_MATCH[:parameter], BUILD_SECOND_MATCH[:identity]
# ITERABLE4, PARAMETER4, IDENTITY4 = BUILD_FIRST_MATCH[:iterable], BUILD_FIRST_MATCH[:parameter], BUILD_FIRST_MATCH[:identity]
# p ITERABLE4, PARAMETER4, IDENTITY4, ITERABLE6, PARAMETER7, IDENTITY8
# UNKNOWN_ITERABLE1 = (1..2)
# UNKNOWN_ITERABLE2 = (1..3)
# p UNKNOWN_ITERABLE1.map{UNKNOWN_ITERABLE2.map(&:itself)}
#
# # COMPLETED buildmap
# r1 = (1..3)
# r2 = (1..5)
# MATRIX_MAP = '[[for x in 1..3 do end] for y in 1..2 do y + 2 end]'
# # todo buildfilter
#
# # todo buildfiltermap
#
# # BUILDER_REGEX = %r{\[\[(?<height>.+)(?=end\] for)(?<length>.+) end.*\]}
#
#  MATRIX_MAP.match(BUILDER_REGEX)
# mappable = instance_eval(" x + 1 ".gsub())
#   p UNKNOWN_ITERABLE1.map{UNKNOWN_ITERABLE2.map(&:mappable)}
# todo flatmap

# todo flatfilter

# todo flatfiltermap
#
# IDENTITY1 = FLAT_MATCH_FIRST
# IDENTITY2
# flatten_matrix = [val for sublist in matrix for val in sublist]
# p flatten_matrix = [for val in sublist do for matrix in sublist do end end]
# p sublist.flatten
# [val for sublist in matrix for val in sublist]
# p flatten_matrix = [for sublist in matrix do for val in sublist do end end].flatten!
# p args[3].match(IDENTITY_REGEX)
# p args[3]
# args.each{p @1.match(FILTER_MAP_REGEX)}
# args.each{p @1.match(MAP_REGEX)}
# args.each{p @1.match(IDENTITY_REGEX)}

# p 'for x in 1..10 do end'.match(regex)
# p 'for x in 1..10 do x end'.match(regex)
# p 'for x in 1..10 do x if x end'.match(regex)
# p 'for x in 1..10 do if x end'.match(regex)
# p args
# nested_hash = Hash.new{|h,k| h[k] = (args[k].match?(FILTER_MAP_REGEX) ? args[k].match(FILTER_MAP_REGEX) : args[k].match(IDENTITY_REGEX))}
# def create_nested_hash(args)
#
# nested_hash = args.each_with_object({})
#                   .with_index{|(e, o), i| $i = i; o[i] = e.match?(%r{for(?<parameter#$i>.+)in(?<iterable#$i>.+)do(?<mappable>.*)if(?<filterable#$i>.+)end}) ?
#                   e.match(%r{for(?<parameter#$i>.+)in(?<iterable#$i>.+)do(?<mappable#$i>.*)if(?<filterable#$i>.+)end}) :
#                   e.match(%r{for(?<parameter#$i>.+)in(?<iterable#$i>.+)do(?<identity#$i>.+)end})}
# end
# # p args.each {|x|p x.match?(FILTER_MAP_REGEX) ? x.match(FILTER_MAP_REGEX) : x.match(IDENTITY_REGEX)}
# nested_hash = create_nested_hash(args)
# args.length.times{|x|p nested_hash[x]}
#
# def check_operation(match, i)
#   # if match["identity#{i}".to_sym] != nil
#   #   match["identity#{i}".to_sym]
#   # end
#
#   # case match
#   # when match
#   #   case match["filterable#{i}".to_sym]
#   #   when match["parameter#{i}".to_sym]
#   #     p ' no filter'
#   #   when ""
#   #   end
#   #   case match["mappable#{i}".to_sym]
#   #   when match["parameter#{i}".to_sym]
#   #     p 'no map'
#   #   end
#   # end
# end
# i = 0
# p check_operation(nested_hash[i], i)
def process_string_data

end
def get_length(str)
  (str.scan(/for /).size + str.scan(/ end/).size) / 2
end

def fathom_depth(depth)
  # DEPTH_LIST_COMP = build_matrix_comp.scan(' end').length
  case depth
  when 1
    p 'list_comp'
  when 2
    p 'nested_list_comp'
  when 3
    p 'triple_nested'
  when 4
    p 'quadruple_nested'
  when 5
    p 'are you sure you wanna be doing this?...'
  end
end
str_filter_map = '[for fortune in 1..2 do fortune + 2 if fortune != 1 end]'
str_map1 = '[for fortune in 1..2 do fortune + 2 end]'
str_map2 = '[for fortune in 1..2 do fortune + 2 end if fortune]'
str_identity1 = '[for fortune in 1..2 do end]'
str_identity2 = '[for fortune in 1..2 do fortune end]'
str_filter1 = '[for fortune in 1..5  do fortune if fortune != 5 end]'
str_filter2 = '[for fortune in 1..5  do if fortune != 5 end]'
# len = get_length(str)
# fathomed = fathom_depth(len)
# FILTER_MAP_REGEX = %r{for(?<parameter#{$i}>.+)in(?<iterable#{$i}>.+)do(?<mappable#$i>.*)if(?<filterable#{$i}>.+)end}
# MAP_REGEX = %r{for(?<parameter#{$i}>.+)in(?<iterable#{$i}>.+)do(?<mappable$i>.*)if(.+)end}
# IDENTITY_REGEX = %r{for(?<parameter#{$i}>.+)in(?<iterable#$i>.+)do(?<identity#$i>.)end}
FILTER_MAP_REGEX2 = %r{for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<mappable>.*)(?=if)if(?<filterable>.+)end}
FILTER_REGEX2 = %r{for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=if)if(?<filterable>.*)end}
MAP_REGEX2 = %r{(?=for)for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<mappable>.*)end}
IDENTITY_REGEX2 = %r{for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<identity>.*)end}

# p str_filter_map[1..-2].match?(FILTER_REGEX2) && str_filter_map[1..-2].include?('if')
# p str_filter_map[1..-2].match(FILTER_MAP_REGEX2) && str_filter_map[1..-2].include?('if')
# p str_filter_map[1..-2].match(MAP_REGEX2) && str_filter_map[1..-2].include?('if')
# p str_filter_map[1..-2].match(IDENTITY_REGEX2) && str_filter_map[1..-2].include?('if')
# p str_filter2[1..-2].match?(FILTER_MAP_REGEX2) && str_filter_map[1..-2].include?('if')
# p str_filter2[1..-2].match?(MAP_REGEX2) && str_filter_map[1..-2].include?('if')
# p str_filter2[1..-2].match?(IDENTITY_REGEX2) && !str_filter2[1..-2].match(IDENTITY_REGEX2)[:identity].include?('if')
# p str_filter2[1..-2].match?(IDENTITY_REGEX2)
# p str_filter2[1..-2].match?(FILTER_REGEX2)
# p str_filter2[1..-2].match?(FILTER_REGEX2) && !str_filter2[1..-2].match(IDENTITY_REGEX2)[:identity].include?('if')
# p str_identity1[1..-2].match?(FILTER_REGEX2) && !str_filter2[1..-2].match(IDENTITY_REGEX2)[:identity].include?('if')
# p str_filter2[1..-2].match(IDENTITY_REGEX2)[:identity]
# p str_filter2[1..-2].match?(IDENTITY_REGEX2) && !str_filter2[1..-2].match(IDENTITY_REGEX2)[:identity]
# p str_identity1[1..-2].match(MAP_REGEX2) && str_identity1[1..-2].match(MAP_REGEX2)[:mappable] != " "
FILTER_MAP_MATCH1 = str_filter_map[1..-2].match(MAP_REGEX2)
FILTER_MAP_MATCH = str_filter_map[1..-2].match(IDENTITY_REGEX2)
# p FILTER_MAP_MATCH && !FILTER_MAP_MATCH[:identity].include?('if')
# p str_filter2[1..-2].match?(FILTER_REGEX2) && !str_filter_map[1..-2].include?('if')
def op_type(str)
  str
  match_id, match_filter_map = str.match(IDENTITY_REGEX2), str.match(FILTER_MAP_REGEX2)
  if FILTER_REGEX2 === str
    if match_filter_map[:mappable] == " " || match_filter_map[:mappable] == match_filter_map[:parameter]
      return :filter
    end
    # p match_filter_map
    if match_filter_map[:filterable] == match_filter_map[:parameter] || match_filter_map[:filterable] == " "
      if match_filter_map[:mappable].strip == match_filter_map[:parameter].strip
        return :identity
      else
        # somtehing here
        return :map
      end
    # elsif match_filter_map[:mappable] == match_filter_map[:parameter] || match_filter_map[:mappable] == " "

    end
    return :filter_map
  elsif MAP_REGEX2 === str
    if match_id[:identity].strip == match_id[:parameter].strip || match_id[:identity] == ' '
      return :identity
    else
      # map_match = str.match(M_REGEX)
      # p map_match[:mappable]
      # p 'hi'

      :map
    end
  end
end
# p op_type(str_identity1).to_s + " Should be Identity1"
# p op_type(str_identity2).to_s + " Should be Identity2"
# p op_type(str_map1).to_s + " Should be Map1"
# p op_type(str_map2).to_s + " Should be Map2"
# p op_type(str_filter1).to_s + " Should be Filter1"
# p op_type(str_filter2).to_s + " Should be Filter2"
# p op_type(str_filter_map).to_s + " Should be Filter_Map"
# both filter and filter_map type matches all
# both map and identity type matches Map and Identity
quadruple_nest1 = '[for x in 1..2 do for x in 3..4 do for x in 5..6 do for x in 6..7 do x + 2 if x end end end end]'
triple_nest1 = '[for x in 1..2 do for x in 3..4 do for x in 5..6 do end end end]'
single_nest1 = '[for x in 1..2 do if 3 > 4 end]'
double_nest1 = '[for x in 1..2 do for x in 3..4 do 10 * 100 if true == true end end]'


def denest_flattener(nested_list)
  nested_list
  nested_list.match(M_REGEX)
  len = nested_list.split('for')[1..-1].length
  nested_list.split('for')[1..-1]
  nested_list.split('for')[1..-1]
  nested_list.split('for')[1..-1].length
  return [nested_list] if len == 1

  nested_list_array = nested_list.split('for')[0..-1]
  nested_list_array[-1] = nested_list_array[-1].split('end').join
  # p nested_list_array[-1] = nested_list_array[-1].chop.strip+" "
  nested_list_array.map(&->x{"[for #{x[1..-1]} end]"})
end
# MATRIX_STR = '[[[for x in 1..3 do end][for x in 1..3 do end]for x in 1..3 do end]for y in 1..2 do end]'
quadruple = '[[[[for x in 1..3 do end], for x in 1..3 do end], for x in 1..3 do end], for y in 1..2 do end]'
triple = '[[[for x in 1..3 do end], for x in 1..3 do end], for y in 1..2 do end]'
double = '[[for x in 1..3 do end], for y in 1..2 do y if y > 4 end]'
def denest_matricizer(nested_list)
  # p nested_list
  # p nested_list.scan(' end')
  len = nested_list.split('for')[1..-1].length
  return nested_list if len == 1

  # p len = nested_list.split(/[,{for}]/)[1..-1].length
  list = nested_list.split(/ end/)[0..-2]
  # list = list.map{|str|str.chars.reject {|x| x == /\[/ }.join}
  # list = " " + list[0]
  fin = list.join.split('[').delete_if{|x| x == ""}
  fin = fin.map{|str|str[0..-1] + " end"}
  fin = fin.join.split('],')
  # p fin
  fin.map!.with_index{|x, i| i != fin.length - 1 ? x += " end " : x + " "}
  fin.map!.with_index{|x, i| i == 0 ? " " + x : x}
  fin
  # return 0
  # p fin.map(&1.:op_type)
  # p listr
  # p list
  # p list.reject{|x|x=="" || x == " "}
  # p list.reject{|x|x=="" || x == " "}.length
  # p nested_list_array = nested_list.split('for')[1..-1]
  # list[-1] = list[-1][0..-4.3*len]
  # p nested_list_array.map(&->x{"[for #{x[1..-1]}end]"})
end

quadruple = '[[[[for x in 1..3 do end], for x in 1..3 do end], for x in 1..3 do end], for y in 1..2 do end]'
triple = '[[[for x in 1..3 do end], for x in 1..3 do end], for y in 1..2 do x +2 if x == 1 end]'
double = '[[for x in 1..3 do end], for y in 1..2 do y if y > 4 end]'

quadruple_nest1 = '[for x in 1..2 do for x in 3..4 do for x in 5..6 do for x in 6..7 do x + 2 if x end end end end]'
triple_nest1 = '[for x in 1..2 do for x in 3..4 do for x in 5..6 do end end end]'
single_nest1 = '[for x in 1..2 do if 3 > 4 end]'
double_nest1 = '[for x in 1..2 do for x in 3..4 do 10 * 100 if true == true end end]'
# p 'for x in 6..7 do x + 2 if x end'.match(FILTER_MAP_REGEX2)
# denested1 = denest_matricizer(double)
# denested2 = denest_matricizer(triple)
# denested3 = denest_matricizer(quadruple)
# denested4 = denest_flattener(single_nest1)
# denested5 = denest_flattener(double_nest1)
# denested6 = denest_flattener(triple_nest1)
# denested7 = denest_flattener(quadruple_nest1)
# hash = {}
# p denested1.map(&1.:op_type)
# p denested2.map(&1.:op_type)
# p denested3.map(&1.:op_type)
# p denested4.map(&1.:op_type)
# p denested5.map(&1.:op_type)
# p denested6.map(&1.:op_type)
# p denested7.map(&1.:op_type).each_with_object({}).with_index{|(e, o), i|p e, o, i; o[e] = denested7[i].match?(FILTER_MAP_REGEX2) ? denested7[i].match(FILTER_MAP_REGEX2) : denested7[i].match(IDENTITY_REGEX2)}

FM_REGEX = %r{for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<mappable>.*)(?=if)if(?<filterable>.+)end}
F_REGEX = %r{for(?<parameter>.*)(?=in)in(?<iterable>.*)(.+)do(.+)(?=if)if(?<filterable>.*)end}
# M_REGEX = %r{(?<parameter>.*)(?<iterable>.*)(?<mappable>.*)}
M_REGEX = %r{(?=for)for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<mappable>.*)end}

# M_REGEX = %r{for(?<parameter>.*)?(?=in)in(?<iterable>.*)(?=do)do(?<mappable>.*)end}
I_REGEX = %r{for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<identity>.*)end}

def create_protocol(denested_array, operator_array)
  # p denested_array, operator_array
  # p denested_array, operator_array
  operator_array.each_with_object({}).with_index do |(e, o), i|
    case e
    when :filter
      o[i] = e, denested_array[i].match(F_REGEX)
    when :filter_map
      o[i] = e, denested_array[i].match(FM_REGEX)
    when :map
      # denested_array[i]
      o[i] = e, denested_array[i].match(M_REGEX)
      # denested_array[i].match(M_REGEX)
    when :identity
      o[i] = e, denested_array[i].match(I_REGEX)
    end
    return o
  end
end
# op_array = denested5.map(&self.method(:op_type))
# p op_array
# instruct_hash = create_protocol(denested5,op_array)


def flatten_process(hash, flatten = true)
  $process_str = ""
  op_array = hash.values.map{|x,|x}
  match_data_array = hash.values.map{|_,x|x}
  match_data_array.each_with_index do |data,i|
    # p $process_str
    $data = data
    info_hash = {}
    $data.names.each{|name|info_hash[name] = $data[name.to_sym]}
    info_hash
    # p "parameter: " + parameter
    # p $data.methods

    $data.names.include?('parameter')

    $parameter = $data[:parameter]
    $iterable = $data[:iterable]
    $op = op_array[i]
    case $op
    when :filter
      if $data.names.include?('filterable')
        $filterable = $data[:filterable]
      end
      $process_str += "(#$iterable).filter{|#$parameter|#$filterable".chop + "}"
    when :filter_map
      if $data.names.include?('filterable')
        $filterable = $data[:filterable]
      end
      if $data.names.include?('mappable')
        $mappable = $data[:mappable]
      end
      if i == op_array.length-1
        $process_str += "(#$iterable).filter_map{|#$parameter|#$parameter if #$filterable}"
      end
      if RUBY_VERSION >= "2.7.0"
        # p 'hi'
        # p $process_str
        # $mappable.gsub!($parameter,  )
        # $process_str += "(#$iterable).filter_map{|#$parameter|#$mappable if #$filterable}"
        # $process_str.gsub!($parameter, "")
      else
        # $process_str += "(#$iterable).filter_map{|#$parameter|#$mappable if #$filterable}"
      end
    when :map
    $mappable = data[:mappable]
    if i == 0
    $process_str += "(#$iterable).map{|#$parameter|#$mappable"
    # elsif i == (1...)
      # $process_str += "|#$parameter|#$mappable})"
    else
      $process_str += "|#$parameter|#$mappable})"
    end
    when :identity
    identity = data[:identity]
    $process_str += "(#$iterable).map{" if i != op_array.length
    end
    data
  end
  case $op
  when :filter
    # "process_str: " + $process_str
  when :map
    $process_str.chop!
    # $process_str << "#{$mappable}"
  when :identity
    $process_str.chop!
    $process_str << "{|x|x}}"
  when :filter_map
    $process_str
    if RUBY_VERSION < "2.7.0"
      # p $mappable
      # $process_str << "#$mappable if #$filterable"
      $process_str
    else
      $mappable
      $process_str
      # $process_str << "#$mappable if #$filterable"
    end
    $process_str
  end
  # p hash.length, $op
  if $op == :filter
    $process_str
    if $process_str.scan(']').length > $process_str.scan('[').length
      idx = $process_str.rindex("]")
      $process_str[idx] = ''
      # $process_str[$process_str.rindex("]")
      $process_str
    end
    # p 'hi'
    if $process_str.scan('}').length > $process_str.scan('{').length
      idx = $process_str.rindex("}")
      $process_str[idx] = ''
      # $process_str[$process_str.rindex("]")
      $process_str
    end
    $process_str << "}" unless $process_str.scan('}').length == $process_str.scan('{').length
  end
  if $op == :filter_map
    $process_str << "}" * (op_array.length-1)
    if $process_str.scan(']').length > $process_str.scan('[').length
      idx = $process_str.rindex("]")
      $process_str[idx] = ''
      # $process_str[$process_str.rindex("]")
      $process_str
    end
  end
  if $op == :identity
    # $process_str << ("}"
    $process_str.chop!
  else
  $process_str.chop! if $op == :identity
  end
  # $process_str.chop! if $op == :filter_map
  # p instance_eval($process_str)
    # $process_str
    return instance_eval($process_str)
    # p $process_str
end

  # return flatten ? instance_eval($process_str).flatten : instance_eval($process_str)

# p ( 1..3 ).map{( 1..3 ).map{( 1..2 ).filter_map{| y | x + 2  if  x == 1 }}}

# def flatten_process(hash, flatten = true)
#   (1..2).map{(2..3).map{(3..4).map{(4..5).map{|x|x}}}}
#   vals = hash.values
#   $process_str = ""
#   i = 0
#   while i < vals.length
#     iterable = vals[1][1][:iterable]
#     val = vals[i]
#   if val[0] == :identity
#     $process_str += "(#{iterable}).map{"
#   elsif val[0] == :map
#     parameter = val[1][:parameter]
#     mappable = val[1][:mappable]
#     $process_str += "(#{iterable}).map{|#{parameter}|#{mappable}})"
#   elsif val[0] == :filter
#   elsif val[0] == :filter_map
#   end
#     i += 1
#   end
#   $process_str.chop! if val[0] == :map
#   p val[0]
#   $process_str << "|x|x" if val[0] == :identity
#   p $process_str
#   p $process_str
#   p hash.length
#   $process_str << ("}" * (hash.length))
#   p $process_str
#   flat_map = $process_str.index('map')
#   return flatten ? instance_eval($process_str).flatten : instance_eval($process_str)
# end
# proc_string = flatten_process(instruct_hash)
# p proc_string[0]



def test_master(num = 1)
  quadruple = '[[[[for x in 1..3 do end], for x in 1..3 do end], for x in 1..3 do end], for y in 1..2 do end]'
  triple = '[[[for x in 1..3 do end], for x in 1..3 do end], for x in 1..2 do x + 2 if x == 1 end]'
  double = '[[for x in 1..3 do end], for y in 1..2 do y if y > 4 end]'
  # quadruple_nest1 = '[for x in 1..2 do for x in 3..4 do for x in 5..6 do for x in 6..7 do x + 2 if x end end end end]'
  triple_nest1 = '[for x in 1..2 do for x in 3..4 do for x in 5..6 do end end end]'
  single_nest1 = '[for x in 1..2 do if 3 > 4 end]'
  double_nest1 = '[for x in 1..2 do for x in 3..4 do 10 * 100 if true == true end end]'
  quadruple_nest1 = '[for x in 1..2 do for x in 3..4 do for x in 5..6 do for x in 6..7 do x + 2 if x end end end end]'
  $arr = [[1,2,3],[4,5,6]]
  # p denested = double_nest1.include?('end end')
  # p denested = quadruple.include?('end end')

  $basic_test1 = 'for x in 1..100 do end'
  $basic_test2 = 'for x in 1..10 do x+1 end'
  $basic_test3 = 'for x in 1..10 do x + 2 end'
  $basic_test2 = 'for x in 1..10 do x + 1 if x.even? end'
  # ( 1..10).filter_map{| x | x  }
  basic_test5 = 'for x in $arr do for y in x do y end end'
  # p ( $arr ).map{| x |( x ).map(&:itself)}
  basic_test6 = 'for x in 1..10 do if x end'
  basic_test7 = 'for x in 1..10 do if x end'

  # denested1 = denest_matricizer(double)
  # denested2 = denest_matricizer(triple)
  # denested3 = denest_matricizer(quadruple)
  # denested4 = denest_flattener(single_nest1)
  # denested5 = denest_flattener(double_nest1)
  # denested6 = denest_flattener(triple_nest1)
  # denested7 = denest_flattener(quadruple_nest1)
  $denested8 = denest_flattener($basic_test1)
  # denested9 = denest_flattener(basic_test2)
  # denested10 = denest_flattener(basic_test3)
  # denested11 = denest_flattener(basic_test4)
  # denested12 = denest_flattener(basic_test5)
  testlist = [
      # denested1,
      # denested2,
      # denested3,
      # denested4,
      # denested5,
      # denested6,
      # denested7,
      $denested8,
      # denested9,
      # denested10,
      # denested11,
      # denested12,
  ]
  string_arr = []
  testlist.each_with_index do |e, i|
    op_array = e.map(&self.method(:op_type))
    instruct_hash = create_protocol(e, op_array)
    string = flatten_process(instruct_hash)
    string_arr << string
  end
  # return string_arr.each(&self.method(:p))
end
# p denested6
# type = flatten


test_master(1)
# p test_master(1)
# ( 1..2 ).filter_map{| y | y  if  x == 1 }
# p ( 1..2).filter_map{| y | y > 4 }
# p ( $arr ).map{| x | x .map{( x ).map(&:itself)}}
# p ( $arr ).map{| x |( x ).map(&:itself)}

# p ( 1..10).filter{| x | x }
# p ( 1..3 ).map{( 1..2).filter{| y | y > 4}}
# p ( 1..3 ).map{|x|x.map{( 1..2 ).filter_map{| y | y  if  x == 1 }}}
# p ( 1..3 ).map{( 1..3 ).map{( 1..2 ).filter_map{| y | y  if  y == 1 }}}
# p ( 1..2 ).map{| x |  ( 3..4 ).filter_map{| x | x  if  true == true   }}
# p ( 1..2).filter{| x | 3 > 4 }
def one_shot(str)
  nest_mode = str.include?('end end') ? :flatten : :matrix
  len = str.split('for')[1..-1].length
  if len == 1
    flat = true
  end
  unless flat
    nest_array = nest_mode.equal?(:flatten) ? denest_flattener(str) : denest_matricizer(str)
  else
    nest_array = [str]
  end
  nest_array = denest_flattener(str)
  op_array = nest_array.map(&self.method(:op_type))
  hash = create_protocol(nest_array, op_array)

  # p nest_array = denest_flattener(str)
  # op_array = nest_array.map(&self.method(:op_type))
  # nest_array = [nest_array]
  # instruct_hash = create_protocol(op_array, nest_array)
  # p proc_string = flatten_process(instruct_hash)
  # proc_string
  # p string = flatten_process(instruct_hash)
  # p string = flatten_process(instruct_hash)
  # p string = flatten_process(instruct_hash)
  # p string = flatten_process(instruct_hash)
    begin
      flatten_process(hash, nest_mode==flat)

      # puts instance_eval(proc_string)
      # puts eval(bad_str)
    rescue SyntaxError => se
      puts 'RESCUED!'
    end
end

p one_shot($basic_test1)
p one_shot($basic_test2)
p one_shot($basic_test3)