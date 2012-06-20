#!/usr/bin/ruby

#The first two consecutive numbers to have two distinct prime factors are:
#
#14 = 2  7
#15 = 3  5
#
#The first three consecutive numbers to have three distinct prime factors are:
#
#644 = 2²  7  23
#645 = 3  5  43
#646 = 2  17  19.
#
#Find the first four consecutive integers to have four distinct primes factors. What is the first of these numbers?

#using prime_division method is like cheating and the time cost is too long. 
#so i write a method to caculate distinct factors. it's much faster than prime_division but still cost 10s.
#require 'mathn'
require 'test_prime'

def factor_length(n)
  a = []
  tmp = n
  while ! tmp.prime?
    (2..tmp).each do |m|
      if tmp % m == 0
	a << m 
	tmp = tmp/m
	break
      end
    end
  end
  a << tmp
  a.uniq.length
end
n = 210
while true
  if factor_length(n) == 4 && factor_length(n+1)== 4 && factor_length(n+2)== 4 && factor_length(n+3)== 4
    p n
    exit
  end
  n += 1
end
#while true
#  if n.prime_division.length == 4 && (n+1).prime_division.length == 4 && (n+2).prime_division.length == 4 && (n+3).prime_division.length == 4
#    p n
#    exit
#  end
#  n += 1
#end
