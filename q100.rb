#!/usr/bin/ruby

#If a box contains twenty-one coloured discs, composed of fifteen blue discs and six red discs, and two discs were taken at random, it can be seen that the probability of taking two blue discs, P(BB) = (15/21)(14/20) = 1/2.
#
#The next such arrangement, for which there is exactly 50% chance of taking two blue discs at random, is a box containing eighty-five blue discs and thirty-five red discs.
#
#By finding the first arrangement to contain over 10^12 = 1,000,000,000,000 discs in total, determine the number of blue discs that the box would contain.

#first i made it into a quadratic equation problem.
#a=(Math.sqrt(8*b**2+1)+2*b+1)/2, so 8*b**2 has to be an integer, and a+b is larger than 10**12
#but the trick here is to handle with the precision of float number!!
#i notice the ratio (5.828...) and use it to "jump". so there must be some interesting theory or sequence on this problem.
#the sequence is something like if a few continous known number which make 8*b**2+1 a square number, what's the next?
#ignorance !! dumb !! it's Pell/diophantine equation. i've met them before too many times. why didn't i remember it? then it can be solved in a recursive way.
#whatever, the first try is not bad: just code and observe and improve. and at last, learn something(although, being such an idiot like me, you would probably forget it in the, let's say, next morning....).
#so in case you may forget the recursive formular, here is the address: http://zh.wikipedia.org/wiki/%E4%BD%A9%E5%B0%94%E6%96%B9%E7%A8%8B, yep, i'm a chinese..

LOWER=10**12
#a proper solution using pell's equation theory. and in fact, it's not quite difficult solve this problem by hand using this recursive theory.
#the minimum integer solution for c**2=8*b**2+1 is b=1,c=3
red=[1]
c=[3]
n=8
def get_blue(x,y)
  (1+x[-1]*2+y[-1])/2
end
while get_blue(red,c)+red[-1] < LOWER
  next_red = c[0]*red[-1]+red[0]*c[-1]
  next_c = c[0]*c[-1]+n*red[0]*red[-1]
  red << next_red
  c << next_c
end
p get_blue(red,c)
exit
#first try, brute force based on superficial observation.
b=1
while true
  if Math.sqrt(8*b**2+1)%1==0&& Math.sqrt(8*b**2+1).to_i**2 == 8*b**2+1
    a=(Math.sqrt(8*b**2+1)+2*b+1)/2
    puts b,a if a%1==0
    b = (b*5.828).to_i if a%1 == 0
    exit if a%1 == 0 && a+b > LOWER
  end
  b += 1
end
