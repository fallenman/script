#!/usr/bin/ruby

#If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.
#
#Find the sum of all the multiples of 3 or 5 below 1000.

sum=0
(1..999).each do |c|
  if c%3 == 0 or c%5 == 0
    sum += c
    puts c
  end
end
p sum
