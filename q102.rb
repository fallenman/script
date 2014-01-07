#!/usr/bin/ruby

#
#
#Three distinct points are plotted at random on a Cartesian plane, for which -1000 ≤ x, y ≤ 1000, such that a triangle is formed.
#
#Consider the following two triangles:
#
#A(-340,495), B(-153,-910), C(835,-947)
#
#X(-175,41), Y(-421,-714), Z(574,-645)
#
#It can be verified that triangle ABC contains the origin, whereas triangle XYZ does not.
#
#Using triangles.txt (right click and 'Save Link/Target As...'), a 27K text file containing the co-ordinates of one thousand "random" triangles, find the number of triangles for which the interior contains the origin.
#
#NOTE: The first two examples in the file represent the triangles in the example given above.
#

require 'mathn'
require File.expand_path('../q101', __FILE__)
ORIGIN = [0,0]
#first, i thought slope was enough. but i didn't make it work. so i reuse q101. 
#but here i have to solve the divided by 0 problem which wouldn't happen in 101.

def link_line(a,b)
	#here a,b are spots(a is a spot: [a[0],a[1]])
	#get the line which pass both a and b
	#notice that if a and b have the same x or y coordinate, return a special value.
	return [a[0],nil] if a[0] == b[0]
	return [nil,a[1]] if a[1] == b[1]
	resolve_matrix([[a[0],1,a[1]],[b[0],1,b[1]]])
end

def cross_line(a,b)
	#here a,b are lines(a is a line: y = a[0]*x+a[1])
	#get the joint spot, notice the negative sign
	return false if a == b
	if a.index(nil) || b.index(nil)
		special_cross(a,b)
	else
	  resolve_matrix([[a[0],-1,-a[1]],[b[0],-1,-b[1]]])
	end
end

def special_cross(a,b)
	if i = a.index(nil)
    i == 0 ? [(a[1]-b[1])/b[0],a[1]] : [a[0],a[0]*b[0]+b[1]]
	else
		special_cross(b,a)
	end
end

def in_middle?(a,b,c)
	#i didn't find a way to handle Comparable.between? method, so i use my stupid way
	#here a,b,c are just rational numbers.
	return true if [a,b,c].sort[1] == a
	return false
end

res = 0
File.new('triangles.txt').readlines.each_with_index do |line,i|
	spots = line.chomp.split(',').map{|x|x.to_i}
	a,b,c = spots[0..1],spots[2..3],spots[4..5]
	ab,ac,bc = link_line(a,b),link_line(a,c),link_line(b,c)
	ao,bo,co = link_line(a,ORIGIN),link_line(b,ORIGIN),link_line(c,ORIGIN)
	abo,aco,bco = cross_line(co,ab),cross_line(bo,ac),cross_line(ao,bc)
	res += 1 if in_middle?(abo,a,b) && in_middle?(aco,a,c) && in_middle?(bco,b,c)
end
p res
