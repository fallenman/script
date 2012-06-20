#!/usr/bin/ruby

#The series, 11 + 22 + 33 + ... + 1010 = 10405071317.
#
#Find the last ten digits of the series, 11 + 22 + 33 + ... + 10001000.

sum = 0
(1..1000).each do |n|
  sum+=n**n
end
p sum%1000000000

