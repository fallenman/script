#!/usr/bin/ruby

#NOTE: This problem is a significantly more challenging version of Problem 81.
#
#In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by moving left, right, up, and down, is indicated in bold red and is equal to 2297.
#
#
#131	673	234	103	18
#201	96	342	965	150
#630	803	746	422	111
#537	699	497	121	956
#805	732	524	37	331
#
#Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by moving left, right, up, and down.

#fxck... this must be the ultimate one...

#after a week, first inspiration comes out: diagonal.
#try...

test="131	673	234	103	18
201	96	342	965	150
630	803	746	422	111
537	699	497	121	956
805	732	524	37	331"

@array=test.split("\n").map {|x| x.split("\t").map(&:to_i)}
p @array
@sum_hash={}
L=@array.length
@sum_hash[[0,0]]=[@array[0][0]]
@sum_hash[[1,0]]=[@sum_hash[[0,0]].min+@array[1][0]]
@sum_hash[[0,1]]=[@sum_hash[[0,0]].min+@array[0][1]]
(L-2).times do |n|
  (n+2).times do |m|
    @sum_hash[[m,n+2-m]] ||= []
  end
  p @sum_hash
end
