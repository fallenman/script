#!/usr/bin/ruby

#The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.
#
#Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:
#
#d2d3d4=406 is divisible by 2
#d3d4d5=063 is divisible by 3
#d4d5d6=635 is divisible by 5
#d5d6d7=357 is divisible by 7
#d6d7d8=572 is divisible by 11
#d7d8d9=728 is divisible by 13
#d8d9d10=289 is divisible by 17
#Find the sum of all 0 to 9 pandigital numbers with this property.

a=(0..9).to_a

#at first stuck on this, because i think i should use recursive way to test everything. just split procedures by math and it's fast
sum=0

[0,5].each do |c|
  (a-[c]).permutation(4).to_a.each do |d|
    next if d[1..3].to_s.to_i%17 != 0 || d[0..2].to_s.to_i%13 != 0 || [c,d[0],d[1]].to_s.to_i%11 != 0
    (a-[c]-d).permutation(5).to_a.each do |e|
      next if [e[4],c,d[0]].to_s.to_i%7 != 0 || e[2..4].to_s.to_i%3 !=0 || e[1..3].to_s.to_i%2 != 0 || e[0] == 0
      p "#{e},#{c},#{d}"
      sum += (e+[c]+d).to_s.to_i
    end
  end
end
p sum
