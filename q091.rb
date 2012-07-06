#!/usr/bin/ruby

#The points P (x1, y1) and Q (x2, y2) are plotted at integer co-ordinates and are joined to the origin, O(0,0), to form ΔOPQ.
#
#There are exactly fourteen triangles containing a right angle that can be formed when each co-ordinate lies between 0 and 2 inclusive; that is,
#0 <= x1, y1, x2, y2 <= 2.
#
#Given that 0 <= x1, y1, x2, y2 <= 50, how many right triangles can be formed?

require 'mathn'
UPPER=100
#use slope/function to optimize the algorithm. 1.5s
sum = 0
(1..UPPER).each do |i|
  (1..UPPER).each do |j|
    #try to compute all the triangles where the right angle is on the spot(i,j)
    #so line from (i,j) to (0,0) has a slope j/i
    #line from (m,n) to spot(i,j) needs to have a slope as -i/j
    #compute the C in y=(-i/j)x+C
    c = j+i*i/j
    #find all the spots belongs to the line within the square and both right and down to the (i,j)
    #and because this is totaly symetric, so we double the final sum to include those spots that are left and up to the (i,j)
    (0..j-1).to_a.reverse.each do |m|
      n = (m-c)*j/(-i)
      break if n > UPPER
      if n%1 == 0
	sum += 1
      end
    end
  end
end
p sum*2+3*UPPER**2
exit
#first edition, totaly brute force. 9s
def to_o(a)
  a[0]**2+a[1]**2
end

def between(a,b)
  (a[0]-b[0])**2+(a[1]-b[1])**2
end
#for each spot, just test those spots that are below it and on its right direction. but you must include the one down straight. that is (x,0) if x != 0
sum = 0
#no need to count the right triangles in the loop when one spot is (x,0) or (y,0)
sum += 3*UPPER**2
#begin from x=0. and all the other right triangles when on spot is (x1,0) will be caculated in (x2,y) where y > 0 and x2 < x1
(0..UPPER).each do |i|
  #begin from y=1
  (1..UPPER).each do |j|
    #test other spot, right down to the current spot (i,j)
    (i+1..UPPER).each do |m|
      (0..j-1).each do |n|
	c,d,e=to_o([i,j]),to_o([m,n]),between([i,j],[m,n])
	sum += 1 if [c,d].max == [c,d].min + e
      end
    end
  end
end
p sum
