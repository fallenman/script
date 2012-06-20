#!/usr/bin/ruby

#It was proposed by Christian Goldbach that every odd composite number can be written as the sum of a prime and twice a square.
#
#9 = 7 + 212
#15 = 7 + 222
#21 = 3 + 232
#25 = 7 + 232
#27 = 19 + 222
#33 = 31 + 212
#
#It turns out that the conjecture was false.
#
#What is the smallest odd composite that cannot be written as the sum of a prime and twice a square?

require 'test_prime.rb'
(35..100000).step(2).each do |n|
  next if n.prime?
  test = 0
  (1..(Math.sqrt(n/2).to_i)).each do |m|
    if (n - 2*m**2).prime?
      test = 1
      break
    end
  end
  if test == 0
    p "the first naughty number is #{n}"
    exit
  end
end
