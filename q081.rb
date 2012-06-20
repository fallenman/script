#!/usr/bin/ruby

#In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by only moving to the right and down, is indicated in bold red and is equal to 2427.
#
#
#131	673	234	103	18
#201	96	342	965	150
#630	803	746	422	111
#537	699	497	121	956
#805	732	524	37	331
#
#Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by only moving right and down.

# first sight: upgrade from q067
# i thought i should split the matrix by the right-left diagonal, and use q067 algorithm? but it seems like a little different and i've already forgotten q067 method...
# try to count every joint min sum.
# sum[n,m]=sum[n-1,m-1]+(sum[n-1,m],sum[n,m-1]).min

#test="131	673	234	103	18
#201	96	342	965	150
#630	803	746	422	111
#537	699	497	121	956
#805	732	524	37	331"

#algorithm is right and result is fast, but my mind is twisted in coding. too many stupid and unecessary codes.

@array=[]
File.new('matrix.txt','r').readlines.each do |line|
  @array<<line.chomp.split(",").map(&:to_i)
end
#@array=test.split("\n").map {|x| x.split(",").map(&:to_i)}
#down_path=[array[0][0],array[1][0],array[2][0]]
#right_path=[array[0][0],array[0][1],array[0][2]]
#middle_path=[array[0][0],[array[0][1],array[1][0]].min,array[1][1]]
#p down_path,right_path,middle_path
L=@array.length
p L
@sum_hash={}
@sum_hash[[0,0]]=@array[0][0]
#@sum_hash[[1,0]]=@array[1][0]
#@sum_hash[[0,1]]=@array[0][1]
#@sum_hash[[1,1]]=@array[1][1]+[@sum_hash[[0,1]],@sum_hash[[1,0]]].min
def joint(a,b)
  begin
  return @array[0][b]+@sum_hash[[0,b-1]] if a==0
  return @array[a][0]+@sum_hash[[a-1,0]] if b==0
  @sum_hash[[a-1,b]] ||= joint(a-1,b)
  @sum_hash[[a,b-1]] ||= joint(a,b-1)
  return @array[a][b]+[(@sum_hash[[a-1,b]]||100000),(@sum_hash[[a,b-1]]||100000)].min
  rescue => e
    puts e.inspect
  end
end
(1..L-1).each do |k|
  joint(k,k)
end
p joint(L-1,L-1)
