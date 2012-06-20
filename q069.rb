#!/usr/bin/ruby

#Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of numbers less than n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.
#
#It can be seen that n=6 produces a maximum n/φ(n) for n  10.
#Find the value of n  1,000,000 for which n/φ(n) is a maximum.

# which means φ(n) should be as small as possible. and then you get 2*3*5*7*11*13*17 ...
# that is n/φ(n) = (p1 /(p1 - 1))(p2 /(p2 - 1))...(pr /(pr - 1)), where p1,p2..pr are prime factors of n.
# and to compute φ(n) is to compute n's prime divisions. this is based on two theorems:
# 1. if n = p**k, where p is a prime, φ(n) = p**k - p**(k-1) = (p-1)*p**(k-1). because all the numbers below n is relatively prime to n, except those are multiples of p.
# 2. φ(n) = φ(m)*φ(k), where n=m*k and m is relatively prime to k.

