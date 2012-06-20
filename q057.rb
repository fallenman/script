#!/usr/bin/ruby

#It is possible to show that the square root of two can be expressed as an infinite continued fraction.
#
# sqrt(2) = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
#
# By expanding this for the first four iterations, we get:
#
# 1 + 1/2 = 3/2 = 1.5
# 1 + 1/(2 + 1/2) = 7/5 = 1.4
# 1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
# 1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...
#
# The next three expansions are 99/70, 239/169, and 577/408, but the eighth expansion, 1393/985, is the first example where the number of digits in the numerator exceeds the number of digits in the denominator.
#
# In the first one-thousand expansions, how many fractions contain a numerator with more digits than denominator?

# fraction with iterations to approach irrational number is always important.
# the only one question puzzled me: should i consider the condition that we must do a fraction simplify?
# i'd better write a method to get the greatest common divisor of 2 given integers? or it will never happen?
# i made a funny mistake that i thought i saw ten-thousand expansions... and stuck on the result for already one hour.

def gcd(n,m)
  n,m=m,n if n < m
  return m if n%m == 0
  tmp=n%m
  gcd(m,tmp)
end
numerator = 3
denominator = 2
sum = 0
999.times do |n|
  #new_record_denominator = 2*denominator+numerator
  #new_record_numerator = denominator
  denominator += numerator
  numerator = 2*denominator - numerator
  if numerator.to_s.length - denominator.to_s.length > 0
    sum += 1
  end
  #if (new_record_numerator+new_record_denominator).to_s.length - new_record_denominator.to_s.length == 1
  #  sum += 1
    #p new_record_numerator+new_record_denominator
    #p new_record_denominator
  #end
  #common_divisor = gcd(new_record_numerator,new_record_denominator)
  #denominator = new_record_denominator/common_divisor
  #numerator = new_record_numerator/common_divisor
  #denominator = new_record_denominator
  #numerator = new_record_numerator
  #p denominator
  #p numerator
end
p sum
