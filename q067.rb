#!/usr/bin/ruby

#By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
#
#3
#7 4
#2 4 6
#8 5 9 3
#
#That is, 3 + 7 + 4 + 9 = 23.
#
#Find the maximum total from top to bottom in triangle.txt (right click and 'Save Link/Target As...'), a 15K text file containing a triangle with one-hundred rows.
#
#NOTE: This is a much more difficult version of Problem 18. It is not possible to try every route to solve this problem, as there are 2**99 altogether! If you could check one trillion (10**12) routes every second it would take over twenty billion years to check them all. There is an efficient algorithm to solve it. ;o)

#so, the main idea is exactly the same as 18. it's damn fast..

aa=[]
File.read('triangle.txt').to_a.each do |b|
  aa << b.split(' ').to_a
end
n=aa.length
(0..n-2).each do |nn|
  (0..(aa[n-nn-2].length-1)).each do |an|
    aa[n-nn-2][an]=aa[n-nn-2][an].to_i+[aa[n-nn-1][an+1].to_i,aa[n-nn-1][an].to_i].max
  end
end
p aa[0]
