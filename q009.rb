#!/usr/bin/ruby

#A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
#a**2 + b**2 = c**2
#
#For example, 32 + 42 = 9 + 16 = 25 = 52.
#
#There exists exactly one Pythagorean triplet for which a + b + c = 1000.
#Find the product abc.


(1..1000).each do |a|
  (a..1000).each do |b|
    c=1000-a-b
    if a**2+b**2==c**2
      p "got you: #{a},#{b},#{c}"
      p a*b*c
    exit
    end
  end
end

