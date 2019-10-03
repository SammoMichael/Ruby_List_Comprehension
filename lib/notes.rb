#
# def next_prime(arr)
#   arr.map{|x| prime?(x) ? find_next_prime(x) : x}
# end
#
# def find_next_prime(num)
#   (num.succ..1/0.0).find(&1.:prime?)
# end
#
# def prime?(n)
#   (2...n).none?{|f|(n % f).zero?}
# end
#
# p next_prime([11, 13, 17]) #=> [13, 17, 19]
# p next_prime([4, 6, 8, 10]) #=> [4, 6, 8, 10]
# p next_prime([2, 5, 4, 7]) #=> [3, 7, 4, 11]