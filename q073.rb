#!/usr/bin/ruby

#Consider the fraction, n/d, where n and d are positive integers. If nd and HCF(n,d)=1, it is called a reduced proper fraction.
#
#If we list the set of reduced proper fractions for d  8 in ascending order of size, we get:
#
#1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
#
#It can be seen that there are 3 fractions between 1/3 and 1/2.
#
#How many fractions lie between 1/3 and 1/2 in the sorted set of reduced proper fractions for d  12,000?
#
#Note: The upper limit has been changed recently.

#this is brute force, quick dirty one. use Euclidean algorithm to check gcd should be much faster.
require 'mathn'
sum=0
hash={}
(2..12000).each do |n|
  hash[n]=n.prime_division.map {|x| x[0]}
end
(2..12000).each do |n|
  lower = (n/3).to_i+1
  upper = n%2 == 0 ? (n/2).to_i-1 : (n/2).to_i
  (lower..upper).each do |m|
    sum+=1 if (hash[m]&hash[n]).empty?
  end
end
p sum
