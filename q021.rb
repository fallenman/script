#!/usr/bin/ruby

#Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
#If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.
#
#For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.
#
#Evaluate the sum of all the amicable numbers under 10000.

# Subconsciously, I thought use prime_division...
# but in fact, I just need a method to find out all the divisors directly.

require 'mathn'

def all_divisors(num)
  divs=[]
  (1..(num**0.5).to_i).each do |c|
    if num%c==0
      divs << c
      divs << num/c
    end
  end
  return divs.uniq
end

sum=0
n=1
while n < 10000 do
  divn = all_divisors(n).sort
  divn.delete_at(-1)
  m = 0
  divn.each do |d|
    m += d.to_i
  end
  divm = all_divisors(m).sort
  divm.delete_at(-1)
  ntmp = 0
  divm.each do |e|
    ntmp += e.to_i
  end
  if ntmp == n && m != n
    p "#{n} and #{m} are amicable numbers"
    sum += (m+n)
  end
  n += 1
end
p sum/2
