#!/usr/bin/ruby

#If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
#
#If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
#
#NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.

# 1-19, 20,30,...,90 would be counted first.
# one two three four five six seven eight nine
# ten
# eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen
# twenty thirty forty fifty sixty seventy eighty ninety
# hundred
a= 3+3+5+4+4+3+5+5+4 #1-9
b= 3+6+6+8+8+7+7+9+8+8 #10-19
c= 6*10*4+5*10*3+7*10+8*a #20-99
d= 10*900+9*(a+b+c)+a*100-3*9 #101-999
e= 11 #1000
p a+b+c+d+e
