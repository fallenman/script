#!/usr/bin/ruby

#A spider, S, sits in one corner of a cuboid room, measuring 6 by 5 by 3, and a fly, F, sits in the opposite corner. By travelling on the surfaces of the room the shortest "straight line" distance from S to F is 10 and the path is shown on the diagram.
#
#
#However, there are up to three "shortest" path candidates for any given cuboid and the shortest route doesn't always have integer length.
#
#By considering all cuboid rooms with integer dimensions, up to a maximum size of M by M by M, there are exactly 2060 cuboids for which the shortest route has integer length when M=100, and this is the least value of M for which the number of solutions first exceeds two thousand; the number of solutions is 1975 when M=99.
#
#Find the least value of M such that the number of solutions first exceeds one million.

#seems like easy, but how to solve time consuming? brute force is something O(n^3)
#finally i got a method by observation or intuition.
#in fact it's something like patition.
#first of all, the shortest path must be a^2+b^2+c^2+2*a*b where c >= a and c >= b
#second, once you get a combination matches integer under M, you can compute all the possibilities in which (a+b) can be split. you record it and move on. finally you will get all the records under M where c=M and max(a+b)=2*M. you should notice the way you split (a+b) depends on M. for example [75,100], if M is 100, c can be either 75 or 100, and (a+b) totally reaches 75/2+(75*2-100)/2+1=63, they're [1,74]..[37,38] and [25,75]..[50,50], but if M is only 75, then you only get (2*75-100)/2+1=26, it's [25,75],[26,74]..[50,50]
#and then, induction M+1.
#use a hash to restore the result and update it when M increase.
#well, this method is a little childish
#using the theory in q075 would be faster.

#trying and failed
#SQUARE={}
#(1..10000).each do |c|
#  SQUARE[c] = c**2
#end
#class Array
#  def shortest
#    if self.length == 3
#      tmp = self.sort.reverse
#      longest = tmp.shift
#      Math.sqrt(SQUARE[tmp.inject(0) {|a,b| a+=b}]+SQUARE[longest])
#    end
#  end
#end
#p [3,5,6].shortest % 1
#def tri(m)
#  return 0 if m == 1
#  tri(m-1)+dou(m)
#end

RES = {}
def dou(m)
  sum = 0
  #(1..m).each do |j|
  #  (j..m).each do |k|
  #    if RES.has_key?([j+k,m].sort)
#	sum += 1
#	RES[[j+k,m].sort] += 1
#      elsif Math.sqrt((j+k)**2+m**2) % 1 == 0#[j,k,m].shortest % 1 == 0
#	sum += 1
#	RES[[j+k,m].sort] = 1
#      end
#    end
#  end
  (2..m*2).each do |j|
    #next if RES.has_key?([j,m].sort)
    if Math.sqrt(j**2+m**2) % 1 == 0
      if j <= m
        RES[[j,m]] = j < m/2 ? j/2 : j/2+m/2-(m-j)+1
      else
	RES[[m,j]] = (m*2-j)/2+1
      end
    end
  end
  sum
end
(1..100000).each do |n|
  dou(n)
  if RES.values.inject(0) {|c,d| c+=d} > 1000000
    p n
    exit
  end
end
