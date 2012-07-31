#!/usr/bin/ruby

#The first known prime found to exceed one million digits was discovered in 1999, and is a Mersenne prime of the form 2**6972593-1; it contains exactly 2,098,960 digits. Subsequently other Mersenne primes, of the form 2p1, have been found which contain more digits.
#
#However, in 2004 there was found a massive non-Mersenne prime which contains 2,357,207 digits: 28433*2**7830457+1.
#
#Find the last ten digits of this prime number.

#if you need to optimize, consider split the power like a**(b*c)=(a**b)**c
n=1
t=0
while n.to_s.length < 10
  t+=1
  n*=2
end
ds=10**10
(7830457-t).times do |tt|
  n=n*2%ds
end
p (n*28433+1)%ds
