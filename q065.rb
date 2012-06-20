#!/usr/bin/ruby

#What is most surprising is that the important mathematical constant,
#e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].
#
#The first ten terms in the sequence of convergents for e are:
#
#2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...
#The sum of digits in the numerator of the 10th convergent is 1+4+5+7=17.
#
#Find the sum of digits in the numerator of the 100th convergent of the continued fraction for e.

def con(k,n,m)
  return [k*n+m,n]
end
t=100
@result ||= t%3 == 0 ? [(t/3)*2,1] : [1,1]
(2..(t-1)).to_a.reverse.each do |n|
  if n%3 == 0
    @result = con((n/3)*2,@result[0],@result[1])
  else
    @result = con(1,@result[0],@result[1])
  end
end
p con(2,@result[0],@result[1])
sum=0
con(2,@result[0],@result[1])[0].to_s.each_char {|x|sum+=x.to_i}
p sum
