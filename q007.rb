#!/usr/bin/ruby

#By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
#
#What is the 10001st prime number?

def prime?(test_num)
  dd = Math.sqrt(test_num).to_i
  return false if ! test_num.integer?
  return false if test_num <= 1
  return true if test_num == 2 
  return true if test_num == 3
  (2..dd).each do |div|
    if test_num%div == 0
#      p "#{test_num} at least has one divisor #{div}"
      return false
    end
  end
  return true
end

c=1
s=3
while c < 10000 do
  s += 2
  if prime?(s)
    c+=1
  end
end  
p s
