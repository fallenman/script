#!/usr/bin/ruby

#A permutation is an ordered arrangement of objects. For example, 3124 is one possible permutation of the digits 1, 2, 3 and 4. If all of the permutations are listed numerically or alphabetically, we call it lexicographic order. The lexicographic permutations of 0, 1 and 2 are:
#
#012   021   102   120   201   210
#
#What is the millionth lexicographic permutation of the digits 0, 1, 2, 3, 4, 5, 6, 7, 8 and 9?

#too slow, it cost 2m30s.
#should think twice
#a=[["1","0"],["0","1"]]
a=[[1,0],[0,1]]
atmp=[]
n=0

(2..9).each do |c|
  a.each do |d|
    e = d.length+1
    e.times.each do |p|
      d.insert(p-1,c)
      atmp << d
      #atmp << d.join(',').split(',')
      d = (d-(c.to_a))
    end
  end
#  a = [] 
#  atmp.each do |aa|
#    a << aa.join(',').split(',')
#  end
#  atmp = []
  a = atmp
  atmp = []
  p a.sort[999999]
end
