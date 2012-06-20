#!/usr/bin/ruby

#We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.
#
#The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.
#
#Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.
#HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.

#i think this is a brute force on permutation

array=(1..9).to_a

def find_pandi(a,n,m)
  result=[]
  a.permutation(n).to_a.each do |ac|
    tmp_a = a - ac
    tmp_a.permutation(m).to_a.each do |ta|
      left = (tmp_a - ta).sort.to_s
      b = ac.to_s.to_i * ta.to_s.to_i
      if b.to_s.split('').sort.join() == left
	result << b
      end
    end
  end
  result
end

sum=0
(find_pandi(array,2,3) | find_pandi(array,1,4)).each do |n|
  sum += n
end
p sum
