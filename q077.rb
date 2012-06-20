#!/usr/bin/ruby

#It is possible to write ten as the sum of primes in exactly five different ways:
#
#7 + 3
#5 + 5
#5 + 3 + 2
#3 + 3 + 2 + 2
#2 + 2 + 2 + 2 + 2
#
#What is the first value which can be written as the sum of primes in over five thousand different ways?

#...as expected, upgrade from previous problem...
# use the same recursive algorithm in q031, rather slow
# use the same algorithm in the previous one, where each element is replaced by prime numbers, and it should be faster.
require 'test_prime'
prime_list = []
(1..50000).each do |n|
  prime_list << n if n.prime?
end
def recursive(list,remainder)
  if list.length == 1
    if remainder%list.first == 0
      @sum += 1
    end
  else
    element = list.first
    list -= [element]
    ((remainder/element)+1).times.each do |k|
      recursive(list,remainder-k*element)
    end
  end
end
(10..100).each do |m|
  candi = prime_list.select {|a| a<m}
  @sum = 0
  recursive(candi,m)
  if @sum >= 5000
    p m
    exit
  end
end
