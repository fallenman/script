#!/usr/bin/ruby

#A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
#
#Find the largest palindrome made from the product of two 3-digit numbers.

e=0
(100..999).reverse_each do |c|
  (100..c).reverse_each do |d|
    a="#{d*c}"
    if e < a.to_i
      if a == a.reverse
        e = a.to_i
      end
    else
      break
    end
  end
end
p e
