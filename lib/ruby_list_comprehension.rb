# frozen_string_literal: true
require 'benchmark'
class ListComprehension

  attr_reader :c, :version, :cache
  def [](*args)
    c[*args]
  end

  def initialize
    @cache = {}
    @caching = true
    @version = RUBY_VERSION
    @c = ->x {
      # save a pristine copy of call for caching
      y = x[0..-1]
      # check for cached results
      return @cache[x] if @caching && @cache[x]
      # check for empty call
      return [] if x.empty? || x == "" || x.nil?
      # required length of keywords and spaces is 10
      raise 'syntax error in list comprehension' if x.length < 10
      arr = x.split
      # check for semicolon instead of do, for now I replace back to do for simplicity :()
      if arr[3][-1] == ';' || arr[4][0] == ';' || arr[5][0] == ';' && !arr.include?('do')
        arr = x.to_s.sub(';', ' do ').split
      end

      # pre-eval to check for invalid syntax, hash as iterable, etc.
      begin
        res = instance_eval(x)
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
        res = instance_eval(arr[3])
        return res.is_a?(Array) ? res : [res]
      end
      self.class.send(:define_method,'lc') do |arr|
        if map_condition == [arr[1]]
          # p 'filter'
          return instance_eval(iterable).filter do |x|
            instance_eval(if_condition.join(' '))
          end
        end

        if if_condition == ['true'] || if_condition == true
          # p 'map'
          return instance_eval(iterable).map do |x|
            instance_eval(map_condition.join(' '))
          end
        end
        # check Ruby Version stored in @version
        if @version >= '2.7.0'
          return instance_eval(iterable).filter_map do |x|
            instance_eval(map_condition.join(' ')) if eval(if_condition.join(' '))
          end
        else
          return instance_eval(iterable).map do |x|
            instance_eval(map_condition.join(' ')) if eval(if_condition.join(' ')).compact!
          end
        end
      end
      list_comp = lc(arr)
      list_comp = list_comp.is_a?(Array) ? list_comp : [list_comp]
      @cache[arr] = list_comp
      list_comp
    }
  end
end
