# frozen_string_literal: true

class ListComprehension
  attr_accessor :cache, :caching
  attr_reader :c, :version, :op

  def [](*args)
    c[*args]
  end

  def initialize
    @cache = {}
    @op = nil
    @caching = true
    @version = RUBY_VERSION
    @c = lambda { |x| # check for cached results
      return [] if x == ''
      x.concat(' end')if x[-3..-1] != 'end'
      return @cache[x] if @caching && @cache[x]

      # p "cached: #{@cache[arr].to_s}" if @cache[arr]

      y = x[0..-1] # copy of original call
      z = y[0..-1] # copy of original call
      return [] if x.empty? || x == '' || x.nil? || eval(z[3]) == '[]'
      raise 'syntax error in list comprehension' if x.length < 10

      raise 'please use "x" as block parameter name for now' if x[3..5] != ' x '

      arr = x.split
      if !arr.include?('do')
        arr.insert(5, 'do')
      end
      # replace initial semicolon with do if needed for parser
      if arr[3][-1] == ';' || arr[4][0] == ';' || arr[5][0] == ';' && !arr.include?('do')
        arr = x.to_s.sub(';', ' do ').split
      end

      # pre-eval to check for invalid syntax
      begin
        res = instance_eval(x)
        return [] if res.nil?
      rescue SyntaxError => se
        raise 'incorrect syntax for list comprehension' + "\n" + se.to_s
      end

      # check for hash to parse csv's
      iterable = arr[3]
      return [{}] if iterable == "{}"

      mdata = y[3...y.rindex('do')].match(/{.+[=>:].+}/)
      if mdata && mdata[0].include?(';')
        # p 'hi'
        iterable = mdata[0].split(';')[0]
        # p iterable
        # p arr.insert(5, "do")
      end
      if mdata
        if instance_eval(mdata[0]).is_a? Hash
          iterable = mdata[0]
          p mdata[0]
          p iterable
          p arr

          if iterable[-1] == ';'
            iterable = iterable[0..-1]
          end
        end
      end

      if_condition = arr.include?('if') ? arr[arr.index('if') + 1...-1] : ['true']
      map_condition = arr[arr.index('do') + 1...(arr.index('if') || arr.index('end'))]

      if (map_condition == [arr[1]]) && (if_condition == ['true'])
        @op = "each"
        res = instance_eval(iterable)
        return res.is_a?(Array) ? res : [res]
      end

      # define a method to handle the transformation to list_comp
      self.class.send(:define_method, 'lc') do |arr|
        if map_condition.include?(arr[1])
          @op = 'filter'
          return instance_eval(iterable).filter do |x|
            instance_eval(if_condition.join(' '))
          end
        end

        if if_condition.include?('true' || 'x') || if_condition
          @op = 'map'
          return instance_eval(iterable).map do |x|
            instance_eval(map_condition.join(' '))
          end
        end

        # check Ruby Version stored in @version
        if @version >= '2.7.0'
          @op = 'filter_map'
          return instance_eval(iterable).filter_map do |x|
            instance_eval(map_condition.join(' ')) if instance_eval(if_condition.join(' '))
          end
        else
          @op = 'map&compact'
          return instance_eval(iterable).map do |x|
            instance_eval(map_condition.join(' ')) if instance_eval(if_condition.join(' '))
          end.compact!
        end
      end
      list_comp = lc(arr)
      unless list_comp.is_a?(Array) || list_comp.is_a?(Hash)
        list_comp = [list_comp]
      end

      list_comp = list_comp == [nil] ? [] : list_comp
      @cache[arr] = list_comp if @caching
    }
  end
end
