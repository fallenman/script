#!/usr/bin/ruby

#The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
#
#Find the sum of all the primes below two million.

# I've tried to use an array to list all the primes, but it takes too long.
# so I get back to prime? method and delete some conditions to reduce the time. now it's less than 40s.(1m4s before)

def prime?(test_num)
  dd = Math.sqrt(test_num).to_i
#  return false if ! test_num.integer?
#  return false if test_num <= 1
#  return false if test_num%2 == 0
  return true if test_num == 2 
  return true if test_num == 3
  (3..dd).step(2).each do |div|
    if test_num%div == 0
#      p "#{test_num} at least has one divisor #{div}"
      return false
    end
  end
  return true
end

sum=5
#a=[]
#a[0]=2

(5..2000000).step(2).each do |p|
  if prime?(p)
    sum += p
  end
end
#  n = 0
#  a.each do |d|
#    if p%d == 0
#    n = 1
#    break
#    end
#  end
#  if n == 0
#    a << p
#    sum += p
#  end
#end
#p a
p sum
