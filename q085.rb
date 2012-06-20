#!/usr/bin/ruby

#By counting carefully it can be seen that a rectangular grid measuring 3 by 2 contains eighteen rectangles:
#
#
#Although there exists no rectangular grid that contains exactly two million rectangles, find the area of the grid with the nearest solution.

#n*(n+1)*m*m(m+1)/4
#first, consider the upper limit of side length: 2000.
#then loop.
#made a very stupid mistake in code... and wonder why it is wrong...another big shame

upper=2000000
dif=Math.sqrt(upper*2).to_i
result = []
#(1..dif).each
#the comment above is what i did at first...
(1..2000).each do |n|
  (1..2000).each do |m|
    tmp = n*(n+1)*m*(m+1)/4
    if (tmp-upper).abs < dif
      dif=(tmp-upper).abs
      result=[n,m]
      p dif,result
    end
    break if tmp > upper and (tmp-upper) > dif
  end
end
p result.inject(1) {|a,b| a*=b}
#p dif,result.inject(1) {|a,b| a*=b}
