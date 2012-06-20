#!/usr/bin/ruby

#The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.
#
#Find the sum of the only eleven primes that are both truncatable from left to right and right to left.
#
#NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.

#at the beginning, i didn't realize that the starting digital can only be /[2357]/ and the end one can only be /[37]/ 
#so, in fact, there's a better way than the below one: try every combination for the 5 digitals in the middle.

require 'test_prime.rb'
def truncate(n=1)
  (n - n%10)/10
end

def re_truncate(n=1)
  n.to_s[1,100].to_i
end
sum = 0
result = 0
(11..1000000).step(2).each do |n|
  next unless (n%10).to_s.match(/[37]/)
  next unless n.to_s[0,1].match(/[2357]/)
  next unless n.prime?
  nt,nm = truncate(n),re_truncate(n)
  test = 0
  while nt > 0 && nm > 0
    if nt.prime? and nm.prime?
      nt,nm = truncate(nt),re_truncate(nm)
    else
      test = 1
      break
    end
  end
  if test == 0
    result += n
    sum += 1
    p n
    p sum
    if sum == 11
      p result
      exit
    end
  end
end
