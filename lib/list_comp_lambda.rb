
module Cream

  def lam(args)
    p args
    $l[args]
  end
def validate_args(args)
  p args.class.to_s
  case args
  when ->x{!x.is_a?(Array)}
    raise ArgumentError.new 'Gremlins ate your list: ' + args.to_s
  when args.length == 1
  end
  @@nested_depth = args.length
  p @@nested_depth.to_s + ' nested depth'

end
  def regex_list_comp(args, i = 0, regex = %r{for (?<list#{i}>.+) end}, nested_hash = Hash.new{|h, k| h[k] = args[k].match(regex)})
    nested_hash[i]
  end

  def comprehend_list(args)
    args = [
        'for x in 1..10 do end',
        'for i in 2..20 do i end',
        'for i in 3..30 do i end'
    ]
# keep track of last index for main parse to separate list in line
    p validate_args args
    args = [
        'for x in 1..10 do end',
        'for i in 2..20 do i end',
        'for i in 3..30 do i end'
    ]
    lists = args.map.with_index { |arg, i|  regex_list_comp(args, i)[("list"+i.to_s).to_sym]}

    args = [
        'for x in 1..10 do end',
        'for i in 2..20 do i end',
        'for i in 3..30 do i end'
    ]
    # count = (args.length)
    i = 0
    regex = %r{for (?<list#{i}>.+) end}
    match1 = args[0].match(regex)
    p match1[0].split
    p match1[:list0]
    p match1[:list]
    if args[0].match(regex)
      matches[0][:list]
    end
    p matches
    nests_hash = args.each_with_object({}).with_index{|(str, hash), i| match = str.match(regex); hash[i] = match }
    nests_hash_v2 = Hash.new{|h, k| h[k] = args[k].match(regex)}
    p nests_hash[0][:list0]
    p  nests_hash_v2[0]
    p nests_hash[0][:list0]
    p nests_hash[0][:list0]
    p nests_hash[0][:list0]
    p matches[:list]
    p nests_hash

  end

  $l = lambda { |list_comp_args|
      comprehend_list(list_comp_args)



  list1 = list_comp_args[0]
  p list_comp_args
  p list_comp_args
  p keyword_args
  # p 'change'
  @list = list.strip
  arr = @list.strip
  case list
  when '{}' then return [{}]
  when '[]' then return [[]]
  when '' then return []
  else list += ' end' unless list.include?('end')
  end
  raise 'syntax error in list comprehension' if list.length < 10

  # check if we have a cached result for this list comp
  if @caching && @cache[list]
    @cache_count += 1
    return @cache[list]
  end

  copy1 = list[0..-1]
  @var = arr[1]

  if !arr.include?('do') && !(list.scan('for').length >= 2)
    list.sub!(';','do')
    arr = list.split
  elsif !arr.include?('do')
    2.times{list.sub!(';','do')}
    arr = list.split
  end
  arr = list.split

  # pre-eval to check for invalid syntax
  begin
    if list.scan('for').length >= 2
      @nested = true
      return [[]] if arr[3] == '[[]]'
      return {} if arr == '{}'
      @iterable = @list_comp
      return @iterable if @iterable.to_a.length == 1 && @iterable[0].length == 1
      arr += [' end']
    end
    arr
    arr_copy = arr[0..-1]
    arr_copy2 = arr[0..-1]
    arr_copy.join(' ')
    res = instance_eval(arr_copy.join(' '))
    return [] if res.nil?
  rescue SyntaxError => se
    raise 'incorrect syntax for list comprehension' + "\n" + se.to_s
  end

  # check for hash to parse csv's
  return [{}] if iterable == '{}'
  m_data = copy1[3...copy1.rindex('do')].match(/({.+[=>:].+})/)
  if m_data
    first_hash = m_data[0].split(';')[0]
    if @list.index(first_hash) == 9
      iterable = first_hash if instance_eval(first_hash).is_a? Hash
    end
  end
  arr = arr_copy2
  @iterable = list
  if_condition = arr.include?('if') ? arr[arr.index('if') + 1...-1] : ['true']
  map_condition = arr[arr.index('do') + 1...(arr.index('if') || arr.index('end'))]
  @filterable = if_condition.join(' ')
  @mappable = map_condition.join(' ')
  p @mappable
  p 'hwre it go'
  if @nested
    p @nested_var = arr[arr.rindex('for')+1]
    if list.scan('do').length >= 1
      # p @mappable = @mappable[@mappable.rindex('do')..-1]
      p 'new mappable'
      p @mappable = list[list.rindex('do')+2..list.rindex('end')-3]
    else
      p @mappable = @mappable[@mappable.index(';')+3..-1]
    end
    @filterable = @filterable[0..-5]

    if (@mappable == @nested_var || @mappable == '') && (@filterable == 'true' || @filterable == @nested_var || @filterable == '')
      return @list_comp.flatten
    end
  end

  if (@mappable == @var || @mappable == '') && (@filterable == 'true' || @filterable == @var) && @nested
    return @list_comp
  end
  # define a method to handle the transformation to iterable
  self.class.send(:define_method, 'lc') do |arr|
    # if @nested
    #   @nested_var = arr[arr.rindex('for')+1]
    #   @mappable = @mappable[@mappable.index('do')+3..-1]
    #   @filterable = @filterable[0..-5]
    # end
    #
    if @mappable == @var || @mappable == @nested_var
      @op[@count] = 'filter'
      # p 'filter'
      if @nested
        @op[@count] = ['flat_map', 'filter']
        return @list_comp.flat_map{|array| array.filter {|x|x = "'#{x}'" if x.is_a? String; instance_eval(@filterable.gsub(@var, x.to_s))  }}
      end
      return @list_comp.filter { |x| x = "'#{x}'" if x.is_a? String; instance_eval(@filterable.gsub(@var, x.to_s)) }
    end
    if @filterable == 'true' || @filterable == @var || @filterable == @nested_var || @filterable == ''
      # p 'map'
      @op[@count] = 'map'
      if @nested
        @op[@count] = ['flat_map', 'map']
        p @mappable
        p 'here'
        return @list_comp.flat_map{|array| array.map{ |x| x = "'#{x}'" if x.is_a? String; instance_eval(@mappable.gsub(@nested_var, x.to_s)) }}
      else
        return @list_comp.map { |x| x = "'#{x}'" if x.is_a? String; instance_eval(@mappable.gsub(@var, x.to_s)) }
      end
    end

    filter_map_condition_args = "#@mappable if #@filterable"
    # check Ruby Version stored in @version
    if @version >= '2.7.0'
      @op[@count] = 'filter_map'
      if @nested
        @op[@count] = ['flat_map', 'filter_map']
        filter_map_condition_args = "#@mappable if #@filterable"
        return @list_comp.flat_map{ |array| array.filter_map {|x| x = "'#{x}'" if x.is_a? String; instance_eval(filter_map_condition_args.gsub(@nested_var, x.to_s))}}
      else
        return @list_comp.filter_map { |x| x = "'#{x}'" if x.is_a? String; filter_map_condition_args.gsub(@var, x.to_s); instance_eval(filter_map_condition_args.gsub(@var, x.to_s)) }
      end
    else
      @op[@count] ="map&compact"
      if @nested
        @op[@count] = ['flat_map', 'map&compact']
        if @mappable.match?('do')
          @mappable = @mappable[@mappable.index('do')+3..-1]
        else
          @mappable = @mappable[@mappable.index(';')+3..-1]
        end
        filter_map_condition_args = "#@mappable if #@filterable"[0..-5]
        @nested_var = arr[arr.rindex('for')+1]
        return @list_comp.flat_map{ |array| array.map {|x| x = "'#{x}'" if x.is_a? String; instance_eval(filter_map_condition_args.gsub(@nested_var, x.to_s))}}.compact!
      else
        @list_comp.flat_map { |x| x = "'#{x}'" if x.is_a? String; instance_eval(filter_map_condition_args.gsub!(@var, x.to_s)) }
      end

    end

  end
}
end

class A
  include Cream
  def initialize
  p $l[for x in 1..10 do x end]
  end
end

a = A.new

p @l[for x in 1..10 do x end]

