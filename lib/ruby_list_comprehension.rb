# frozen_string_literal: true

class ListComprehension
  attr_reader :c, :version

  def [](*args)
    c[*args]
  end

  def initialize
    @version = RUBY_VERSION
    @c = ->x {
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
        return [eval(arr[3])]
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
require 'set'
l = ListComprehension.new
# p l['for x in 1..[1,2,3].reduce{@1+@2} do x if x end']
# # p l["for x in {1=>1, 2=>2} do x if x end"]
# p l['for x in 1..10 do x if x end']
# p l['for x in Set.new(1..10) do x**2 if x > 2 end']
# p l['for x in 1..10 do x**2 if x > 5 end'] == (1..10).filter_map{@1 ** 2 if @1 > 5}
# p arr = l['for x in 1..10 do x end'] == [for x in 1..10 do x end]
# p arr2 = l['for x in 1..10 do x ** 2 if x % 2 == 0 end'] == (1..10).filter_map{@1**2 if @1 % 2 == 0}
# p arr3 = l['for x in [1,2,3,4,5] do x if x % 2 == 0 end'] == [1,2,3,4,5].filter{@1 % 2 == 0}
# p arr7 = l['for x in 1..10 do x if x % 2 == 0 end']
# p arr9 = l['for x in 1..10 ; x if x % 2 == 0 end'] == (1..10).filter{@1 % 2 == 0}
# p arr9 = l['for x in 1..10; x if x % 2 == 0 end'] == (1..10).filter{@1 % 2 == 0}
#





# a = for x in Set.new([1,2,3]) do x**2 end
# Set.new([1,2,3]).filter_map(&->x{x+1 if x > 2})
# p a.each(&1.:p)
# p for x in Set.new([1,2,3]) do x**2 if x > 2 end