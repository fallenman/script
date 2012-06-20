#!/usr/bin/ruby
require 'mathn'

#The prime factors of 13195 are 5, 7, 13 and 29.
#
#What is the largest prime factor of the number 600851475143 ?

c = 600851475143
a = c < 2 ? [["... are you sure you input a proper value?"]] : c.prime_division 
# I think what i was doing is: write my own 'prime_division' method...
def prime?(test_num)
  dd = Math.sqrt(test_num).to_i
  return false if ! test_num.integer?
  return false if test_num <= 1
  return true if test_num == 2 
  return true if test_num == 3
  (2..dd).each do |div|
    if test_num%div == 0
      p "#{test_num} at least has one divisor #{div}"
      return false
    end
  end
  return true
end

def divide(num)
  return false if num <= 3
  num_sqrt=Math.sqrt(num).to_i
  (2..num_sqrt).each do |div|
    if num%div == 0
      return div
    end
  end
  return num
end

cs = c
if divide(cs)
dd = divide(cs)
while dd != cs do
#  if prime?(dd)
    cs = cs/dd
#  end
p dd
  dd = divide(cs)
end
end
p dd
#a.each do |d|
#  p prime?(d[0].to_i)
#end
p a
p "max prime factor of #{c} is #{a[-1][0]}"
