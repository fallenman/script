#!/usr/bin/ruby

#The smallest number expressible as the sum of a prime square, prime cube, and prime fourth power is 28. In fact, there are exactly four numbers below fifty that can be expressed in such a way:
#
#28 = 2^2 + 2^3 + 2^4
#33 = 3^2 + 2^3 + 2^4
#49 = 5^2 + 2^3 + 2^4
#47 = 2^2 + 3^3 + 2^4
#
#How many numbers below fifty million can be expressed as the sum of a prime square, prime cube, and prime fourth power?

#first thought is something like sorted combination.
#or should i enumerate the sum of every square, cube and fourth power? and the problem came to distinct them.
#well, use hash. i do not need to distinct! or boolean vector
#totally brute force is enough... as bitRAKE asked, any mathematical solution?

require 'test_prime'
UPPER=50000000
def set_init(power)
  a = []
  (2..UPPER**(1/power.to_f)).each do |n|
    a << n**power if n.prime?
  end
  a
end
SQUARE=set_init(2)
CUBE=set_init(3)
FOURTH=set_init(4)
RESULT={}
SQUARE.each do |j|
  CUBE.each do |k|
    FOURTH.each do |l|
      if j+k+l < UPPER
	RESULT[j+k+l] = 1#unless RESULT.has_key?(j+k+l)
      end
    end
  end
end
p RESULT.length
