#!/usr/bin/ruby

#2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
#
#What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

# this question is quite tricky. we have many choices. but which is better?
# try to choose a 'lazy' way: prime_division. and I made a mistake: of course to use prime_division is to use prime factorization, but I didn't notice the situation such as [m,1],[m,3]... in (1..n) situation, that actually is (1..n).step(1) it won't happen. but generally speaking, it's a mistake, for example (1..20).step(3), we'll have [[2,1],[2,2],[2,4]...].
# finally I got a stupid way, use array.count. a little tricky, but should be correct now.
# yeah, prime_division is quite useful

require 'mathn'

c=20
#c=ARGV[0].to_i
a=[]
(1..c).each do |p|
  a = a | p.prime_division
end

pro=1
a = a.sort
b=[]
c=[]
a.each do |dd|
  b << dd[0]
end
b.uniq.each do |ddd|
  c << b.count(ddd)
end
e = 0
p a
c.length.times.each do |num|
    e = num == 0 ? e + c[num] - 1 : e + c[num]
  pro = pro * b.uniq[num]**a[e][1]
p a[e]
end
p pro
