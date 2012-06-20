#!/usr/bin/ruby

#The arithmetic sequence, 1487, 4817, 8147, in which each of the terms increases by 3330, is unusual in two ways: (i) each of the three terms are prime, and, (ii) each of the 4-digit numbers are permutations of one another.
#
#There are no arithmetic sequences made up of three 1-, 2-, or 3-digit primes, exhibiting this property, but there is one other 4-digit increasing sequence.
#
#What 12-digit number do you form by concatenating the three terms in this sequence?

#a=(0..9).to_a.combination(4).to_a
require 'test_prime'
# at first, didn't realize that the digits may be the same...
# so i decide to test all the 4-digital prime numbers.

# numbers are so mysterious...
# in fact, the difference is still 3330, so if knowing this, it can be faster. 3330 keeps the last digital unchanged and somehow 'rotate' the first 3 digitals.
# and someone post an very interesting result: 0379, 3709 and 7039. then some more interesting results up to 5-digits are post!
# after this question, i came to level 2, because i finished q67 long time ago. so a little step here.
list = []
(1001..9997).each do |n|
  list << n if n.prime?
end
list = list.reverse
while list.length > 1
  a = list.first
  tmp = [(a/1000)%10,(a/100)%10,(a/10)%10,a%10]
  test = []
  tmp.permutation(4).to_a.uniq.each do |b|
    bb = b.to_s.to_i
    if list.include?(bb)
      list -= [bb]
      test << bb
    end
  end
  if test.length >= 3
    test.combination(3).to_a.each do |c|
      if c.max + c.min == (c-[c.max,c.min]).first * 2
	p c.sort
	exit
      end
    end
  end
end
