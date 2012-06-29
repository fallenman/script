#!/usr/bin/ruby

#A natural number, N, that can be written as the sum and product of a given set of at least two natural numbers, {a1, a2, ... , ak} is called a product-sum number: N = a1 + a2 + ... + ak = a1  a2  ...  ak.
#
#For example, 6 = 1 + 2 + 3 = 1  2  3.
#
#For a given set of size, k, we shall call the smallest N with this property a minimal product-sum number. The minimal product-sum numbers for sets of size, k = 2, 3, 4, 5, and 6 are as follows.
#
#k=2: 4 = 2  2 = 2 + 2
#k=3: 6 = 1  2  3 = 1 + 2 + 3
#k=4: 8 = 1  1  2  4 = 1 + 1 + 2 + 4
#k=5: 8 = 1  1  2  2  2 = 1 + 1 + 2 + 2 + 2
#k=6: 12 = 1  1  1  1  2  6 = 1 + 1 + 1 + 1 + 2 + 6
#
#Hence for 2<=k<=6, the sum of all the minimal product-sum numbers is 4+6+8+12 = 30; note that 8 is only counted once in the sum.
#
#In fact, as the complete set of minimal product-sum numbers for 2<=k<=12 is {4, 6, 8, 12, 15, 16}, the sum is 61.
#
#What is the sum of all the minimal product-sum numbers for 2<=k<=12000?

#this one is a little awkward.
#seems like a factor combination and use 1 to finish up the serial.
#try every possibility.
#coding is a little twisted.
#rough upper bound should be double of k.
#i think i've begun at a slower way: find all the product form of each number.
#using loops in which factors not exceed 14 would be faster. in the forum, it just cost under a few ms. this deduces that building up is much better than breaking down!
#this costs 10s. too slow.
require 'mathn'
require 'test_prime'
UPPER=24000
#PRIME=[]
#(2..UPPER).each do |m|
#  PRIME << m if m.prime?
#end
RES={}
PRODUCT={}
(4..UPPER).each do |n|
  next if n.prime?
  PRODUCT[n]=[]
  (2..Math.sqrt(n)).each do |j|
    if n%j==0
      PRODUCT[n] << [j,n/j]
      if PRODUCT[n/j]
        PRODUCT[n/j].each do |jj|
	  PRODUCT[n] << [j]+jj if j <= jj.first
        end
      end
    end
  end
  PRODUCT[n].each do |m|
    l = m.length+n-m.inject(0){|c,d|c+=d}
    if RES[l].nil?
      RES[l] = n
    else
      RES[l] = n if n < RES[l]
    end
  end
end
p RES.sort[0,11999].map {|e| e[1]}.uniq.inject(0) {|f,g| f+=g}
exit
(12..12).each do |n|
  next if PRIME.include?(n)
  tmp=n.prime_division
  products(tmp)
  #tmp.each_with_index do |pri,i|
  #  tmp_number = n
  #  total_left=0
  #  total_numbers=1
  #  t = pri[1]#i == tmp.length-1 ? pri[1]-1 : pri[1]
  #  t.times do |k|
  #    total_numbers += 1
  #    tmp_number /= pri[0]
  #    total_left += pri[0]
  #    numbers = total_numbers + n - total_left - tmp_number
  #    if RES[numbers].nil?
#	RES[numbers] = n
#      else
#	RES[numbers] = n if n < RES[numbers]
#      end
#    end
#  end
end
p RES.sort
