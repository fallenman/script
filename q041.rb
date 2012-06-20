#!/usr/bin/ruby

#We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.
#
#What is the largest n-digit pandigital prime that exists?

require 'test_prime.rb'
result = 0
(1..7).to_a.permutation(7).to_a.each do |n|
  result = n.to_s.to_i if n.to_s.to_i.prime? && result < n.to_s.to_i
end
p result
