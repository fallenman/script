#!/usr/bin/ruby

#Euler published the remarkable quadratic formula:
#
#n² + n + 41
#
#It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.
#
#Using computers, the incredible formula  n² − 79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, −79 and 1601, is −126479.
#
#Considering quadratics of the form:
#
#    n² + an + b, where |a| < 1000 and |b| < 1000
#
#    where |n| is the modulus/absolute value of n
#    e.g. |11| = 11 and |−4| = 4
#
#Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.

# starting with n = 0 means b is required to be a prime.

bc=[]
def prime?(num)
  return false if num < 0
  (3..(num**0.5).to_i).step(2).each do |d|
    if num%d == 0
      return false
    end
  end
  return false if num <= 1 or num == 4 or num == 6 or num == 8
  return true
end

(1..1000).each do |p|
  if prime?(p)
    bc << p
  end
end

len = 0
a = 0
b = 0
bc.each do |btmp|
  (-1000..1000).each do |atmp|
    n = 0
    tmp = n**2+atmp*n+btmp
    if tmp < 0
      next
    end 
    while prime?(n**2+atmp*n+btmp) do
      n+=1
    end
    if n > len
      len = n
      a = atmp
      b = btmp
    end
  end
end

p a*b
