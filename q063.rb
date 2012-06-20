#!/usr/bin/ruby

#The 5-digit number, 16807=7**5, is also a fifth power. Similarly, the 9-digit number, 134217728=8**9, is a ninth power.
#
#How many n-digit positive integers exist which are also an nth power?

# first impression: where is the upper bound for the n?
# as 10**n is (n+1)-digit number, so the upper bound should be n where (9**n).to_s.length < n
# so actually, this question can be solved totally by hand...

limit = 0
(1..100).each do |n|
  if (9**n).to_s.length < n
    limit = n
    break
  end
end
sum = 0
(1..22).each do |c|
  (1..9).each do |m|
    sum += 1 if (m**c).to_s.length == c
  end
end
p sum
