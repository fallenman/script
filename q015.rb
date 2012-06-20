#!/usr/bin/ruby

#Starting in the top left corner of a 2×2 grid, there are 6 routes (without backtracking) to the bottom right corner.
#How many routes are there through a 20×20 grid?

# stuck on this one... what a dumb!

# after 3 days, I found a way.

a=[]
a[0]=[]
a[0][0]=0
n=20
(1..n).each do |p|
  a[p]=[]
  a[p][0]=1
  a[0][p]=1
end
a[1][1]=2
(2..n).each do |c|
  (1..c).each do |p|
    a[c][p]=a[c][p-1]+a[c-1][p]
    a[p][c]=a[p-1][c]+a[p][c-1]
  end
  p a[c][c]    
end
