#!/usr/bin/ruby

#145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.
#
#Find the sum of all numbers which are equal to the sum of the factorial of their digits.
#
#Note: as 1! = 1 and 2! = 2 are not sums they are not included.

#forget 0! = 1 !!!! big mistake
a=[1]
(1..9).each do |c|
  a << (1..c).to_a.inject(1) {|pro,c| pro*c }
end
p a
sum = 0
#simply assume 7 * 9! = 2540160 be a compromised upper bound
(10..2540160).each do |n|
  tmp = 0
  n.to_s.split('').each do |ne|
    tmp += a[ne.to_i]
  end
  if tmp == n
    p n
    sum += n
  end
end
p sum
