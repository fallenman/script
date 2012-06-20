#!/usr/bin/ruby

#n irrational decimal fraction is created by concatenating the positive integers:
#
#0.123456789101112131415161718192021...
#
#It can be seen that the 12th digit of the fractional part is 1.
#
#If dn represents the nth digit of the fractional part, find the value of the following expression.
#
#d1*d10*d100*d1000*d10000*d100000*d1000000

#there are 10*n n-digit numbers.

product = 1
#start from d100. in fact, this is totally an algorithm for doing it in writing...
seg = 0
(2..6).each do |n|
  seg += (n-1)*10**(n-2)*9
  seg_position = 10**n - seg
  seg_number = (seg_position)/n
  modify = (seg_position)%n
  seg_start = 10**(n-1)
  digit = modify == 0 ? (seg_start+seg_number).to_s.split('').to_a.last.to_i : (seg_start + seg_number+1).to_s.split('').to_a[modify-1].to_i
  p digit
  product *= digit
end
p product
  

