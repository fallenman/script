#!/usr/bin/ruby

#It is well known that if the square root of a natural number is not an integer, then it is irrational. The decimal expansion of such square roots is infinite without any repeating pattern at all.
#
#The square root of two is 1.41421356237309504880..., and the digital sum of the first one hundred decimal digits is 475.
#
#For the first one hundred natural numbers, find the total of the digital sums of the first one hundred decimal digits for all the irrational square roots.

# well, when i was young as a junior middle school student, i felt boring in math class and learn this written calculation of root.
# however, in the forum, a ruby guy post this:
# require 'bigdecimal'
# require 'bigdecimal/math'
# include BigMath
#
# (1..100).select {|i| r = Math::sqrt(i); r.ceil != r}.inject(0) {|s,i| s + sqrt(BigDecimal(i.to_s),100).to_s('f')[0,101].split('').inject(0) {|t,j| t + j.to_i}}
def sqt(n)
  test = Math.sqrt(n).to_i
  re = n - test**2
  com = test
  sum = test
  99.times do |n|
    test = re*100/(com*20)
    while (test+com*20)*test > re*100
      test -= 1
    end
    re = re*100 - (test+com*20)*test
    sum += test
    com = 10*com+test
  end
  sum
end
result = 0
(1..100).each do |m|
  next if Math.sqrt(m)%1 == 0
  result += sqt(m)
end
p result
