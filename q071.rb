#!/usr/bin/ruby

#Consider the fraction, n/d, where n and d are positive integers. If nd and HCF(n,d)=1, it is called a reduced proper fraction.
#
#If we list the set of reduced proper fractions for d  8 in ascending order of size, we get:
#
#1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
#
#It can be seen that 2/5 is the fraction immediately to the left of 3/7.
#
#By listing the set of reduced proper fractions for d <= 1,000,000 in ascending order of size, find the numerator of the fraction immediately to the left of 3/7.

# weird question. i'm too stupid to explain it.
# learn from the forum: it is related to Farey Series.
# and we can use this theory in an iterate way to get the result:
# (2 + 3)/(5 + 7)
# (2 + 3*2)/(5 + 7*2)
# ... we can reach the max denominator 5 + 7*142856 = 999997, so the numerator will be 2+3*142856 = 428570
# magic? here is the explanation in basic algebra:
# 3/7 - n/d = (3*d-7*n)/(7*d), to minimum you want the numerator to be 1 and the denominator to be as large as possible. and we know 3*d-7*n = 1 if and only if d is relatively prime to n ( first lesson in algebra !!! ) and of course they would be like 5+7k and 2+3k.

# in fact, if we want to do a brute force , we can check left close to 3/7. this could be fast enough, less than half minute.
require 'mathn'
result = 1
order = 0
numerator = 0
(1..1000000).each do |n|
  next if n%7 == 0
  test = 3/7 - (0.428571428571*n).to_i/n
  if result > test
    result = test
    order = n
    numerator = (0.428571428571*n).to_i
  end
end
p result,order,numerator
exit


(900000..1000000).each do |n|
  (1..1000).each do |m|
    if 3/7-(0.428571*n+m).to_i/n < 0
      if result > 3/7-(0.428571*n+m-1).to_i/n && 3/7-(0.428571*n+m-1).to_i/n != 0
	result = 3/7-(0.428571*n+m-1).to_i/n
	order = n
	numerator = 0.428571*n+m-1
      end
    break
    end
  end
end
p result,order,numerator
