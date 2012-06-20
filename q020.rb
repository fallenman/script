#!/usr/bin/ruby

#Find the sum of the digits in the number 100!
sum = 0
pro = 1
(1..100).each do |n|
  pro = pro*n
end
p pro
pro.to_s.split('').each do |c|
  sum += c.to_i
end
p sum
