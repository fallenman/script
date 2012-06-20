#!/usr/bin/ruby

#The sum of the squares of the first ten natural numbers is,
#1**2 + 2**2 + ... + 10**2 = 385
#
#The square of the sum of the first ten natural numbers is,
#(1 + 2 + ... + 10)**2 = 552 = 3025
#
#Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 − 385 = 2640.
#
#Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.

#this seems like unnecesary question.

sum1=0
sum2=0

(1..100).each do |c|
  sum1+=c**2
  sum2+=c
end
sum2 = sum2**2
p "#{sum2} - #{sum1} equals #{sum2 - sum1}"
