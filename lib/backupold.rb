
# frozen_string_literal: true

require 'readline'
require 'list_comp_lambda'

class ListComprehension
  include Cream
  attr_accessor :cache, :caching, :mappable, :filterable, :iterable, :var, :list, :location, :line, :count, :nested, :nested_var, :file, :list_comp
  attr_reader :c, :version, :op, :cache_count, :filename

  def [](iterable)
    @list_comp = iterable

    # if Pry or Irb we read from HISTORY
    if @filename == 'pry' || @filename == 'irb'
      @line = Readline::HISTORY.to_a.reverse.uniq.reverse[-1]
      start = @line.index('l[') + 2
      ending = @line[start..-1].index('end') + 5
      @line = @line[start...ending]

      # otherwise we read from the file location
    else
      @location = caller_locations.last.to_s.scan(/\d+/).last.to_i
      @file = File.open($PROGRAM_NAME)
      file_data = @file.readlines.map(&:chomp)
      @file.close
      @line = file_data[@location - 1].strip
      start = @line.index('l[')
      ending = @line[start..-1].index('end')
      full_line = @line
      p @line = @line[start+2...ending + 6].chop
      list2 = full_line.split('l[')
      list2.each_with_index do |list, idx|
        if list.split[3] == iterable.to_s
          @line = list[0..list.index('end]')+2]
        end
      end
    end
    @line
    @lambda[@line]
  end

  def initialize
    @filename = $PROGRAM_NAME
    @cache = {}
    @count = 0
    @op = {}
    @cache_count = 0
    @caching = true
    @version = RUBY_VERSION
    @lambda = lambda { |list|
      return [] unless list.is_a? String

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

      list_comp = lc(arr)
      unless list_comp.is_a?(Array) || list_comp.is_a?(Hash)
        list_comp = [list_comp]
      end
      list_comp = list_comp == [nil] ? [] : list_comp
      if list_comp.is_a? Numeric
        return [list_comp]
      end
      @count += 1
      # p iterable
      @cache[list] = list_comp if @caching
      return list_comp
    }
  end
end
