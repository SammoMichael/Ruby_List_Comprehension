# frozen_string_literal: true

class ListComprehension
  attr_reader :c, :version

  def [](*args)
    c[*args]
  end

  def initialize
    @version = RUBY_VERSION
    @c = ->x {
      return [] if x == ""
      raise 'syntax error in list comprehension' if x.length < 10
      arr = x.split
      begin
        if arr[3][-1] == ';' || arr[4][0] == ';'
          arr = x.to_s.sub(';', ' do').split
        end
        res = eval(x)
        return [] if res.nil?
        raise 'iterable can only be range, set, or array, not hash objects' if res.is_a? Hash
      rescue SyntaxError => se
        raise 'incorrect syntax for list comprehension' + se.to_s
      end
      # raise 'iterable can only be range, set, or array, not hash objects' if eval(x).is_a? Hash


      iterable = arr[3]
      if_condition = arr.include?('if') ? arr[arr.index('if') + 1...-1] : ['true']
      map_condition = arr[arr.index('do') + 1...(arr.index('if') || arr.index('end'))]
      if (map_condition == [arr[1]]) && (if_condition == ['true'] || if_condition == true)
        # p "no method needed"
        res = eval(arr[3])
        return res.is_a?(Array) ? res : [res]
      end
      self.class.send(:define_method,'lc') do |arr|
        if map_condition == [arr[1]]
          # p 'filter'
          return eval(iterable).filter do |x|
            eval(if_condition.join(' '))
          end
        end

        if if_condition == ['true'] || if_condition == true
          # p 'map'
          return eval(iterable).map do |x|
            eval(map_condition.join(' '))
          end
        end
        # check Ruby Version stored in @version
        if @version >= '2.7.0'
          return eval(iterable).filter_map do |x|
            eval(map_condition.join(' ')) if eval(if_condition.join(' '))
          end
        else
          return eval(iterable).map do |x|
            eval(map_condition.join(' ')) if eval(if_condition.join(' ')).compact!
          end
        end
      end
      return lc(arr)
    }
  end
end
