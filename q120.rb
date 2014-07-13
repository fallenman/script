#!/usr/bin/env ruby

#Let r be the remainder when (a−1)**n + (a+1)**n is divided by a**2.
#
#For example, if a = 7 and n = 3, then r = 42: 63 + 83 = 728 ≡ 42 mod 49. And as n varies, so too will r, but for a = 7 it turns out that rmax = 42.
#
#For 3 ≤ a ≤ 1000, find ∑ rmax.

# notice that:
# when n is even, the remainder will be 2
# when n is odd, the remainder will be 2*n*a
# and that implies when n < a/2:
# when a is even , rmax = (a-2)*a, that is when n = a/2-1
# when a is odd, rmax = (a-1)*a, that is when n = (a-1)/2
# if n > a/2, it will repeat the remainder loop

sum=0
(3..1000).each do |n|
  n.even? ? sum+=(n-2)*n : sum+=(n-1)*n
end
p sum
