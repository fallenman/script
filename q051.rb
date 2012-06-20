#!/usr/bin/ruby

#By replacing the 1st digit of *3, it turns out that six of the nine possible values: 13, 23, 43, 53, 73, and 83, are all prime.
#
#By replacing the 3rd and 4th digits of 56**3 with the same digit, this 5-digit number is the first example having seven primes among the ten generated numbers, yielding the family: 56003, 56113, 56333, 56443, 56663, 56773, and 56993. Consequently 56003, being the first member of this family, is the smallest prime with this property.
#
#Find the smallest prime which, by replacing part of the number (not necessarily adjacent digits) with the same digit, is part of an eight prime value family.

# considering number that %3 == 0, thus we must replace 3*n digits, where n=1,2,3... or we will have at least three numbers that %3 == 0.
a=[1,3,7,9]
b=(1..9).to_a
c=(0..9).to_a
require 'test_prime'
d=(0..4).to_a

# i don't like generate all primes under 1000000, so i do it in this ugly way below... however it works at last, though it's twisted in mind... caculate position combinations one by one... and in fact, it didn't test 5-digits numbers, which i checked within 10ms in the failed try before... this way is fast but not that accurate.
d.combination(2).to_a.each do |e|
  num = []
  c.each do |f|
    num[e.first] = f
    c.each do |g|
      num[e.last] = g
      a.each do |h|
	num[5] = h
	tmp = []
	c.each do |i|
	  ((0..5).to_a - [e.first,e.last,5]).each do |j|
	    num[j] = i
	  end
	  tmp << num.to_s.to_i if num.to_s.to_i.prime?
	end
	p tmp if tmp.length >= 8
      end
    end
  end
end
