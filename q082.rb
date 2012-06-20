#!/usr/bin/ruby

#NOTE: This problem is a more challenging version of Problem 81.
#
#The minimal path sum in the 5 by 5 matrix below, by starting in any cell in the left column and finishing in any cell in the right column, and only moving up, down, and right, is indicated in red and bold; the sum is equal to 994.
#
#
#131	673	234	103	18
#201	96	342	965	150
#630	803	746	422	111
#537	699	497	121	956
#805	732	524	37	331
#
#Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the left column to the right column.


# i hate upgrading..
# try to count every minimal sum of each spot column by column.
# at first, i made a mistake. i thought i can break the loop when got the first bigger sum larger than the direct sum.
# and the code is too ugly..

test="131	673	234	103	18
201	96	342	965	150
630	803	746	422	111
537	699	497	121	956
805	732	524	37	331"

#@array = test.split("\n").map {|x| x.split("\t").map(&:to_i)}
@array=[]
File.new('matrix2.txt','r').readlines.each do |line|
  @array<<line.chomp.split(",").map(&:to_i)
end
L = @array.length
@result_hash = {}
#init result, the same to the first column
L.times do |d|
  @result_hash[[d,0]] = @array[d][0]
end
# start from the second column, end at the second last column.
(1..L-1).each do |m|
  #each spot
  L.times do |n|
    #count each spot minimal sum in the m th column
    result = @result_hash[[n,m-1]]
    #find the limit row up and down
    sum = 0
    n.times do |k|
      sum += @array[n-k-1][m]
      if result > sum + @result_hash[[n-k-1,m-1]]
        result = sum + @result_hash[[n-k-1,m-1]]
      end
    end
    sum = 0
    (L-n-1).times do |j|
      sum += @array[n+j+1][m]
      if result > sum + @result_hash[[n+j+1,m-1]]
        result = sum + @result_hash[[n+j+1,m-1]]
      end
    end
    #the minimal sum of the spot @array[n][m]
    @result_hash[[n,m]] = result + @array[n][m]
  end
end
p @result_hash.select {|a,b| a[1]==L-1}.sort {|e,f| e[1]<=>f[1]}.first
