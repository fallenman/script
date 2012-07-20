#!/usr/bin/ruby

#It is easily proved that no equilateral triangle exists with integral length sides and integral area. However, the almost equilateral triangle 5-5-6 has an area of 12 square units.
#
#We shall define an almost equilateral triangle to be a triangle for which two sides are equal and the third differs by no more than one unit.
#
#Find the sum of the perimeters of all almost equilateral triangles with integral side lengths and area and whose perimeters do not exceed one billion (1,000,000,000).

#yep, use the theory in q075, Pythagorean triple.
#and use the almost equilateral definition, we get two(in fact, four) quadratic equations. n**2 - 4*m*n - m**2 = 1 or -1, 3*m**2 - n**2 = 1 or -1.
#so if Math.sqrt(3*m**2+1) or Math.sqrt(3*m**2-1) is an integer, we can get a solution.
L=1000000000
UPPER=Math.sqrt(L/3)
result=[]
(1..UPPER).each do |m|
  [3*m**2+1,3*m**2-1].each do |n|
    n = Math.sqrt(n)
    if n%1 == 0 && m != n
      k = 2*m+n
      j = 2*m-n
      result << [2*n*m,n**2-m**2,m**2+n**2].map(&:to_i).sort if m*n > 0 && m**2+n**2 < L/3
      result << [2*m*j,(j**2-m**2).abs,m**2+j**2].map(&:to_i).sort if m*j > 0 && m**2+j**2 < L/3
      result << [2*m*k,k**2-m**2,k**2+m**2].map(&:to_i).sort if m*k > 0 && m**2+k**2 < L/3
    end
  end
end
p result.uniq
p result.uniq.inject(0) {|a,b| a+=2*b[0]+2*b[2]}
