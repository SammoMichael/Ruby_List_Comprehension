# frozen_string_literal: true

class ListComprehension
  attr_accessor :cache, :caching, :mappable, :filterable, :iterable, :var, :list
  attr_reader :c, :version, :op, :cache_count

  def [](list_comp)
    c[list_comp]
  end

  def initialize
    @cache = {}
    @count = 0
    @op = {}
    @cache_count = 0
    @caching = true
    @version = RUBY_VERSION
    @c = lambda { |list| # check for cached results
      return [] unless list.is_a? String

      @list = list.strip
      case list
      when '{}' then return [{}]
      when '[]' then return [[]]
      when '' then return []
      else list += ' end' unless list.include?('end')
      end
      raise 'syntax error in list comprehension' if list.length < 10

      if @caching && @cache[list]
        @cache_count += 1
        return @cache[list]
      end

      copy1 = list[0..-1]
      arr = list.split
      @var = arr[1]

      # replace initial semicolon with do if needed for parser
      if arr[3..-1].any?{|x|x.include?(';')} && !arr.include?('do')
        arr = list.to_s.sub(';', ' do ').split
      end

      # pre-eval to check for invalid syntax
      begin
        res = instance_eval(list)
        return [] if res.nil?
      rescue SyntaxError => se
        raise 'incorrect syntax for list comprehension' + "\n" + se.to_s
      end

      # check for hash to parse csv's
      iterable = arr[3]
      return [{}] if iterable == '{}'
      m_data = copy1[3...copy1.rindex('do')].match(/({.+[=>:].+})/)
      if m_data
        if instance_eval(m_data[0].split(';')[0]).is_a? Hash
          iterable = m_data[0].split(';')[0]
        end
      end
      @iterable = instance_eval(iterable)
      if_condition = arr.include?('if') ? arr[arr.index('if') + 1...-1] : ['true']
      map_condition = arr[arr.index('do') + 1...(arr.index('if') || arr.index('end'))]
      @filterable = if_condition.join(' ')
      @mappable = map_condition.join(' ')

      ### list_comprehension identity currently uses for(each) as if normal ruby
      return *@iterable if @mappable == @var && (@filterable == 'true' || @var)

      # define a method to handle the transformation to list_comp
      self.class.send(:define_method, 'lc') do |arr|

        if map_condition == @var
          @op[@count] = 'filter'
          @count += 1
          return @iterable.filter { |x| instance_eval(@filterable.gsub(@var, x.to_s))}
        end

        if if_condition == ['true'] || @var
          @op[@count] = 'map'
          @count += 1
          return @iterable.map { |x| instance_eval(@mappable.gsub(@var, x.to_s))}
        end

        filter_map_condition_args = "#@mappable if #@filterable"
        # check Ruby Version stored in @version
        if @version >= '2.7.0'
          @op[@count] = 'filter_map'
          @count += 1
          return @iterable.filter_map { |x| instance_eval(filter_map_condition_args.gsub(@var, x.to_s)) }
        else
          @op[@count] = 'map&compact'
          @count += 1
          @iterable.map { |x| instance_eval(filter_map_condition_args.gsub!(@var, x.to_s)) }.compact!
        end
      end
      list_comp = lc(arr)
      unless list_comp.is_a?(Array) || list_comp.is_a?(Hash)
        list_comp = [list_comp]
      end
      list_comp = list_comp == [nil] ? [] : list_comp
      @cache[list] = list_comp if @caching
    }
  end
end
