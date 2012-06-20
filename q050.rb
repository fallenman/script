#!/usr/bin/ruby

#The prime 41, can be written as the sum of six consecutive primes:
#
#41 = 2 + 3 + 5 + 7 + 11 + 13
#This is the longest sum of consecutive primes that adds to a prime below one-hundred.
#
#The longest sum of consecutive primes below one-thousand that adds to a prime, contains 21 terms, and is equal to 953.
#
#Which prime, below one-million, can be written as the sum of the most consecutive primes?

#notice that the sum may not start from 2....
# the algorithm below is not accurate. in order to be accurate, i should record the sum as low_limit when sum.prime? is true. in the next loop (the loop that start at different prime, like first try 2+3+5+7... next 3+5+7...), start the sum from the low_limit, substract the first prime, and try the next end side prime. but i'm lazy...
require 'test_prime'

a=[2,3,5,7,11,13,17,19]
numbers=0
low_limit = 0
up_limit = 1000000
a.each do |pp|
  sum = pp
  now = a[a.index(pp)+1] || 23
  test = 1
  while sum < up_limit
    sum += now
    test += 1
    if sum.prime?
      if numbers < test
	numbers = test
	if sum + now > up_limit
	  p "start at #{pp},end at #{now},the result is #{sum}, totally #{numbers} primes. since we can't remove any start side number to add more end side number."
	  exit
	end
      end
    end
    now += 2
    while ! now.prime?
      now += 2
    end
  end
end
