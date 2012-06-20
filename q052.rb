#!/usr/bin/ruby

#It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.
#
#Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.

# for chinese students, you should still remember the famous loop: 1/7,2/7,3/7,4/7,5/7,6/7...
# so this question is just for fun?
# in fact, let me dig just a little more: you should only check 100-166, 1000-16666, 10000-16666, and so on...
def list(n)
  return n.to_s.split('').sort
end

(100..987654).each do |n|
  a = list(n)
  if list(2*n) == a && list(3*n) == a && list(4*n) == a && list(5*n) == a && list(6*n) == a
    p n
    exit
  end
end
