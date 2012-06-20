#!/usr/bin/ruby

#2**15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
#
#What is the sum of the digits of the number 2**1000?

a=(2**1000).to_s.split('')
sum=0
a.each do |s|
  sum += s.to_i
end
p sum
