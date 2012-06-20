#!/usr/bin/ruby

#There are exactly ten ways of selecting three from five, 12345:
#
#123, 124, 125, 134, 135, 145, 234, 235, 245, and 345
#
#In combinatorics, we use the notation, 5C3 = 10.
#
#In general,
#
#nCr = n!/(r!*(n-r)!)
#,where r <= n, n! = n*(n-1)...3*2*1, and 0! = 1.
#It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.
#
#How many, not necessarily distinct, values of  nCr, for 1 <= n <= 100, are greater than one-million?

# the forum admin suggest using pascal triangle. once count to 1000000, the left numbers on the slash will be greater than it too, so he simply set them to 1000000, and continue the loop. due to the property of combination, you can only count a half. but be careful about those numbers where n%2 == 0 
def factorial(n)
  return 0 unless n.integer?
  pro = 1
  (2..n).each do |c|
    pro *= c
  end
  pro
end

@factor = {}
(1..50).each do |c|
  @factor[c] = factorial(c)
end

def combination(n,m)
  return 0 if n < m
  return 1 if n == m
  m = n - m if m < n/2
  pro = 1
  #tmp = factorial(n-m)
  tmp = @factor[n-m]
  ((m+1)..n).each do |c|
    pro *= c
  end
  pro/tmp
end

sum = 0
(23..100).each do |n|
  (3..(n-3)).each do |r|
    if combination(n,r) > 1000000
      #p [n,r]
      sum += 1
    end
  end
end
p sum
