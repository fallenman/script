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
#i found that i must find a way to rebuild the minimal of previous spots.

#most difficult one for me until now. i reached q089 and came back here.
#the first try makes a correct answer, but i still wonder if it is just a coincidence of the matrix form, because i can imagine a counter example for that algorithm: the minimal path cross the big diagonal three times.
#however based on this first try, i got some useful ideas.
#we should init every spot( or if we can set infinity) and do a loop to check until the sum_hash stop changing, and no need to split the matrix into two parts.
#finally, i ran into the right way: no need to loop, but return to my first idea, the minimal one each time.
#but in fact, based on the matrix form, it will be much more faster if we just repeat checking the sum_hash if it is stable, which implies it's a bad case for Dijkstra's algorithm. but Dijkstra's algorithm is a more reliable algorithm, because you don't know the loop depth and Dijkstra's algorithm guarantee an O(n^2).
#so, this is something very famous, as A* algorithm, Dijkstra's algorithm, etc.
#you can check it on wiki. but ! it's big fun trying to invent the wheel again.

#test="131	673	234	103	18
#201	96	342	965	150
#630	803	746	422	111
#537	699	497	121	956
#805	732	524	37	331"

#test2="0 1 0 0 0
#0 1 0 1 0
#0 1 0 1 0
#0 1 0 1 0
#0 0 0 1 1"

#A=test.split("\n").map {|x| x.split("\t").map(&:to_i)}
A=[]
File.new('matrix2.txt','r').readlines.each do |line|
  A << line.chomp.split(",").map(&:to_i)
end
@sum_hash={}
L=A.length
#normal init
@sum_hash[[0,0]]=A[0][0]
@sum_hash[[1,0]]=@sum_hash[[0,0]]+A[1][0]
@sum_hash[[0,1]]=@sum_hash[[0,0]]+A[0][1]
#init the sum of every spot. in fact, if we can define infinity, we don't have to do this. as a middle result, the init sum of [[79,79]] is the value we want in q081
(L-2).times do |n|
  (0..n+2).each do |m|
    @sum_hash[[m,n+2-m]] = ([@sum_hash[[m-1,n+2-m]],@sum_hash[[m,n+1-m]]]-[nil]).min+A[m][n+2-m]
  end
end
(L-1).times do |j|
  (0..L-j-2).each do |k|
    @sum_hash[[k+j+1,L-1-k]] = [@sum_hash[[k+j,L-1-k]],@sum_hash[[k+j+1,L-2-k]]].min+A[k+j+1][L-1-k]
  end
end
#now the answer of q081
p @sum_hash[[L-1,L-1]]
#then Dijkstra's algorithm. we maintain an array to include all the edge spots, and another array to include the deleted spots from the previous one. then find the smallest one in edge spots, deliver its sum to its neighbour, update the neighbours, move this spot to the other array, add those new neighbours to edge spot array. repeat it.
keys=[[0,1],[1,0]]
mini=[[0,0]]
until keys.empty?
  min = nil
  s = nil
  #find the minimal edge spot
  keys.each do |k|
    if min.nil?
      min = @sum_hash[k]
      s = k
    else
      if @sum_hash[k] < min
	min = @sum_hash[k]
        s = k
      end
    end
  end
  #update neighbours
  nei = [[s[0],s[1]+1],[s[0],s[1]-1],[s[0]+1,s[1]],[s[0]-1,s[1]]]
  nei.each do |ne|
    next if @sum_hash[ne].nil?
    next if mini.include?(ne)
    @sum_hash[ne] = [@sum_hash[ne],@sum_hash[s]+A[ne[0]][ne[1]]].min
    #if we reached the end spot, then it must be the result.
    if ne == [L-1,L-1]
      p @sum_hash[ne]
      exit
    end
    #notice that keys may already include ne
    keys = (keys|[ne])
  end
  #delete minimal spot in keys, add it to mini
  keys -= [s]
  mini += [s]
end
p @sum_hash[[L-1,L-1]]
exit
#the code below is first try. although the answer is right, the algorithm is not that correct.
(L-2).times do |n|
  #(n+2)th diagonal
  (0..n+2).each do |m|
    #@sum_hash[[m,n+2-m]]
    #if m == 0
    #  @sum_hash[[m,n+2-m]] = @sum_hash[[m,n+1-m]]+A[m][n+2-m]
    #elsif m == n+2
    #  @sum_hash[[m,n+2-m]] = @sum_hash[[m-1,n+2-m]]+A[m][n+2-m]
    #else
    @sum_hash[[m,n+2-m]] = ([@sum_hash[[m-1,n+2-m]],@sum_hash[[m,n+1-m]]]-[nil]).min+A[m][n+2-m]
    #end
  end
  #after this, check backward once. but once is enough? how about check all?
  #(0..n+1).each do |j|
  #  @sum_hash[[j,n+1-j]] = [@sum_hash[[j,n+1-j]],@sum_hash[[j+1,n+1-j]]+A[j][n+1-j],@sum_hash[[j,n+2-j]]+A[j][n+1-j]].min
  #  [[j-1,n+1-j],[j+1,n+1-j],[j,n-j],[j,n+2-j]].each do |k|
  #    @sum_hash[k] = [@sum_hash[k],@sum_hash[[j,n+1-j]]+A[k[0]][k[1]]].min unless @sum_hash[k].nil?
  #  end
  #end
  #(n+1).times do |j|
    @sum_hash.keys.each do |k|
      [[k[0],k[1]+1],[k[0],k[1]-1],[k[0]+1,k[1]],[k[0]-1,k[1]]].each do |kk|
        @sum_hash[kk] = ([@sum_hash[kk],@sum_hash[k]+A[kk[0]][kk[1]]]-[nil]).min unless @sum_hash[kk].nil?
      end
    end
  #end
end
@sum_hash2={}
@sum_hash2[[L-1,L-1]]=A[L-1][L-1]
@sum_hash2[[L-2,L-1]]=@sum_hash2[[L-1,L-1]]+A[L-2][L-1]
@sum_hash2[[L-1,L-2]]=@sum_hash2[[L-1,L-1]]+A[L-1][L-2]
(L-2).times do |k|
  (0..k+2).each do |j|
    @sum_hash2[[L-1-j,L-1+j-k-2]] = ([@sum_hash2[[L-1-j+1,L-1+j-k-2]],@sum_hash2[[L-1-j,L-1+j-k-2+1]]]-[nil]).min+A[L-1-j][L-1+j-k-2]
  end
  #(k+1).times do |l|
    @sum_hash2.keys.each do |n|
      [[n[0],n[1]+1],[n[0],n[1]-1],[n[0]+1,n[1]],[n[0]-1,n[1]]].each do |nn|
	@sum_hash2[nn] = ([@sum_hash2[nn],@sum_hash2[n]+A[nn[0]][nn[1]]]-[nil]).min unless @sum_hash2[nn].nil?
      end
    end
  #end
end
sum=[]
L.times do |l|
  sum << @sum_hash[[l,L-l-1]]+@sum_hash2[[l,L-l-1]]-A[l][L-l-1]
end
p sum.min
