require 'readline'
require 'singleton'

module RubyList

FM_REGEX = %r{for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<mappable>.*)(?=if)if(?<filterable>.+)end}
F_REGEX = %r{for(?<parameter>.*)(?=in)in(?<iterable>.*)(.+)do(.+)(?=if)if(?<filterable>.*)end}
M_REGEX = %r{(?=for)for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<mappable>.*)(?=end)end}
I_REGEX = %r{for(?<parameter>.*)(?=in)in(?<iterable>.*)(?=do)do(?<identity>.+)(?=end)end}

## todo refactor this mess
def op_type(str)
  match_map, match_filter_map, match_filter, match_identity = str.match(M_REGEX), str.match(FM_REGEX), str.match(F_REGEX), str.match(I_REGEX)
  # p match_filter_map, match_filter, match_identity, match_map

  if match_filter_map.nil? && match_filter.nil?
    # p match_identity, match_map
    # p match_map[:mappable]
    # p match_map[:parameter]
    if /\A\s*\Z/ === match_map[:mappable] || match_map[:mappable].strip == match_identity[:identity] || match_map[:mappable].strip == match_map[:parameter].strip
      return :identity
    else
      return :map
    end
  else

  end




  # if F_REGEX === str
  #   if /\A\s*\Z/ === match || match_filter_map[:mappable] == match_filter_map[:parameter]
  #     if match_filter_map[:filterable] == " true  "
  #       return :identity
  #     end
  #     return :filter
  #   end
  #   if match_filter_map[:filterable] == match_filter_map[:parameter] || /\A\s*\Z/ === match_filter_map[:filterable]
  #     if match_filter_map[:mappable].strip == match_filter_map[:parameter].strip
  #       return :identity
  #     else
  #       if /\A\s*\Z/ === match_filter_map[:mappable]
  #         return :identity
  #       end
  #       return :map
  #     end
  #   end
  #   return :filter_map
  # elsif M_REGEX === str
  #   if match_id[:identity].strip == match_id[:parameter].strip || match_id[:identity] == ' '
  #     return :identity
  #   else
  #     if str.match?(M_REGEX)
  #       match = str.match(M_REGEX)
  #       if match.names.include?('mappable')
  #         mappable = match[:mappable]
  #         if mappable == "  "
  #           return :identity
  #         end
  #       end
  #     end
  #     if mappable == " " || mappable == ""
  #       return :identity
  #     end
  #     :map
  #   end
  # end
end

  def denest_flattener(nested_list)
  len = nested_list.split('for')[1..-1].length
  return [nested_list] if len == 1

  nested_list_array = nested_list.split('for')[0..-1]
  nested_list_array[-1] = nested_list_array[-1].split('end').join
  nested_list_array.map(&->x{"[for #{x[1..-1]} end]"})
end

def fetch_capture(data, name)
  if data.names.include?(name)
    return data[name.to_sym]
  else
    return -1
  end
end

def denest_matricizer(nested_list)
  # p 'hihihithis method don" work'
  nested_list
  nested_list
  len = 0
  nested_list
  return nested_list if len == 1

  list = nested_list.split(/ /)
  nested_list.split(/ do /) if len == 0
  fin = list.join.split('[').delete_if{|x| x == ""}
  fin = fin.map{|str|str[0..-1] + " end"}
  fin = fin.join.split('],')
  fin.map!.with_index{|x, i| i != fin.length - 1 ? x += " end " : x + " "}
  fin.map!.with_index{|x, i| i == 0 ? " " + x : x}
  fin
end

def create_protocol(denested_array, operator_array)
  operator_array.each_with_object({}).with_index do |(e, o), i|
    case e
    when :filter
      o[i] = e, denested_array[i].match(F_REGEX)
    when :filter_map
      o[i] = e, denested_array[i].match(FM_REGEX)
    when :map
      o[i] = e, denested_array[i].match(M_REGEX)
      o[i][1]
    when :identity
      o[i] = e, denested_array[i].match(I_REGEX)
    end
    return o
  end
end

def execute_comprehension(hash, flatten = true)
  op_array = hash.values.map{|x,|x}
  raise SyntaxError if op_array.empty?

  $process_str = ""
  match_data_array = hash.values.map{|_,x|x}
  "operator array: " + op_array.to_s
  "match data array: " + match_data_array.to_s
  match_data_array == [match_data_array] if match_data_array.length == 1
  i = 0
  unfinished = true
  while unfinished
    break if op_array.empty?
    len = op_array.length
    current_op = op_array.pop
    current_data = match_data_array[i]
    $iterable_string = fetch_capture(current_data, 'iterable')
    $mappable = fetch_capture(current_data, 'mappable')
    $parameter = fetch_capture(current_data, 'parameter')
    $filterable = fetch_capture(current_data, 'filterable')
    $identity = fetch_capture(current_data, 'identity')
    $iterable = Array($iterable) if $iterable.class == Set
    case current_op
    when :identity
      if op_array.empty?
        # p len
        return *$iterable
      end
    when :map
      op_array
      if op_array.empty?
        # p $process_str
        $mappable
        if /\A\s*\Z/ === $mappable
        $mappable = $parameter
        end
        if $mappable[-1..-2] == 'en'
         p $mappable[0..-3]
        end
        $process_str += "(#$iterable).map{|(#$parameter)|(#$mappable)}"
        p $process_str
      end
    when :filter
      if op_array.empty?
        $process_str += "(#$iterable).filter{|(#$parameter)|(#$filterable)}"
      end
    when :filter_map
      if op_array.empty? && RUBY_VERSION >= "2.7.0"
        $process_str += "(#$iterable).filter_map{|(#$parameter)|(#$mappable)  if  (#$filterable)}"
      else
        $process_str += "(#$iterable).map{|(#$parameter)|(#$mappable)  if  (#$filterable)}.compact"
      end
    end
    i += 1
  end
  "process string: " + $process_str
  begin
    p current_op
    # instance_eval($process_str)
  rescue SyntaxError => e
    'List imcomprehensible :' + e.backtrace_locations.to_s
  end
end

def one_shot(str)
  str = str.split('for')[1..-1]
  len = str.length
  if len == 1
    flat = true
  end
  if str.include?('end end') && !flat
    nest_mode = :flatten
  else
    nest_mode = :matrix
  end
  str = str.join if str.is_a? Array
  unless flat
    nest_array = nest_mode.equal?(:flatten) ? denest_flattener(str) : denest_matricizer(str)
  else
    nest_array = [str]
  end
  nest_array = denest_flattener(str)
  op_array = nest_array.map(&self.method(:op_type))
  hash = create_protocol(nest_array, op_array)
  begin
    execute_comprehension(hash, nest_mode==flat)
  rescue SyntaxError => se
    puts 'RESCUED!'
  end
end

class ListComprehension
  include Singleton
  attr_accessor :cache, :caching, :mappable, :filterable, :iterable, :var, :list, :location, :line, :count, :nested, :nested_var, :file, :list_comp
  attr_reader :c, :version, :op, :cache_count, :filename

  def [](iterable)
    @list_comp = iterable
    $iterable = iterable
    if @filename == 'pry' || @filename == 'irb'
      @line = Readline::HISTORY.to_a.reverse.uniq.reverse[-1]
      start = @line.index('l[') + 2
      ending = @line[start..-1].index('end') + 5
      @line = @line[start...ending]
      @line
    else
      @location = caller_locations.last.to_s.scan(/\d+/).last.to_i
      @file = File.open($PROGRAM_NAME)
      file_data = @file.readlines.map(&:chomp)
      @file.close
      @line = file_data[@location - 1].strip
      start = @line.index('l[')
      ending = @line[start..-1].index('end')
      full_line = @line
      @line = @line[start+2...ending + 6].chop
      list2 = full_line.split('l[')
      list2.each_with_index do |list, idx|
        if list.split[3] == iterable.to_s
          @line = list[0..list.index('end]')+2]
        end
      end
    end
    @count += 1
    @cache[@line] = one_shot(@line)
  end

  def initialize
    @filename = $PROGRAM_NAME
    @cache = {}
    @count = 0
    @cache_count = 0
    @caching = true
    @version = RUBY_VERSION
  end
end
# @@l = ListComprehension.new
  $l = ListComprehension.instance
end

