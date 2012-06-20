#!/usr/bin/ruby

#The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.
#
#There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.
#
#How many circular primes are there below one million?

#suddenly i realize, all the digitals must be odd number.. and later, i came to recognize that 5 can be excluded... such an old man i am now...

#at the very beginning, i tried to use (a*n).combination(n).to_a to find all the combinations. it's quite stupid and inefficient. but for such short array, it works.(most time cost here..lazy evil!!)
#suddenly, i realized it's something like q031. but i still stuck on this repeatable combination algorithm.(q031 is just combination). "master" cgg told me it's something similar to poker program. i will think about it later. 
#when i run the program, i notice that ... rotation... circular... so i misunderstood this problem before...
a=[1,3,7,9]
#require test_prime.rb to add prime? method in Integer class
require 'test_prime.rb'
another_result = []
result = []

def rotate(n)
  #len = n.to_s.length
  #fir = n/10**(len-1)
  #re = n%10**(len-1)
  #re * 10 + fir
  n.to_s[1,1000].to_i*10 + n.to_s[0,1].to_i
end
sum=0

def test_rotate(n)
  num = n
  n.to_s.length.times do |c|
    return false unless num.prime?
    num = rotate(num)
  end
end

(11..999999).step(2).each do |n|
  next if n.to_s.match(/[024568]/)
  sum+=1 if test_rotate(n)
end
p sum

exit
(3..6).each do |n|
  tmp = (a*n).combination(n).to_a.uniq
  tmp.each do |t|
    next if result.include?(t)
    num = t.join('').to_i
    test = 0
    t.length.times do |c|
      unless num.prime?
	test = 1
	break
      end
      num = rotate(num)
    end
    result << t if test == 0
  end
end
p result.length
