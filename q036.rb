#!/usr/bin/ruby

#The decimal number, 585 = 10010010012 (binary), is palindromic in both bases.
#
#Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.
#
#(Please note that the palindromic number, in either base, may not include leading zeros.)

#to_s(base) is ruby method.. up to 36
#learn a tip in forum: only check odd numbers because even number in base2 is something like 1...0 which makes them impossible to be palindromic.
class String
  def is_palindromic?
    return true if self == self.reverse
  end
end

sum = 0
(1..1000000).step(2).each do |n|
  sum += n if n.to_s.is_palindromic? && n.to_s(2).is_palindromic?
end
p sum
