#The most naive way of computing n15 requires fourteen multiplications:
#
#n × n × ... × n = n15
#
#But using a "binary" method you can compute it in six multiplications:
#
#n × n = n2
#n2 × n2 = n4
#n4 × n4 = n8
#n8 × n4 = n12
#n12 × n2 = n14
#n14 × n = n15
#
#However it is yet possible to compute it in only five multiplications:
#
#n × n = n2
#n2 × n = n3
#n3 × n3 = n6
#n6 × n6 = n12
#n12 × n3 = n15
#
#We shall define m(k) to be the minimum number of multiplications to compute nk; for example m(15) = 5.
#
#For 1 ≤ k ≤ 200, find ∑ m(k).


# brute force, dirty and slow
# at first, I use a method like this, for example, suppose we have:
# 3 => { 5 => [[1,2,3,5],[1,2,4,5]] }
# then we get
# 4 => { 6 => [[1,2,3,5,6],[1,2,4,5,6]],
#        7 => [[1,2,3,5,7],[1,2,4,5,7]],
#        8 => [[1,2,3,5,8],[1,2,4,5,8]],
#        9 => [[1,2,4,5,9]],
#        10 => [[1,2,3,5,10],[1,2,4,5,10]] }
# notice that 5 => [[1,2,3,4,5]] is not included
# which means for each array the max element must be one of the addends.
# this kind of method gives me 1577, which is not correct.
# but someone in the forum says it should be correct...
# this method seems to be called: star addition chain, in which one of the summands is always the previous chain
#
# and this seems to be a famous topic: shortest addition chain
# since it has a page in the very famous Knuth book
#
# see also
# http://wwwhomes.uni-bielefeld.de/achim/addition_chain.html
h = { 0 => { 1 => [[1]] },
      1 => { 2 => [[1,2]] },
      2 => { 3 => [[1,2,3]],
	     4 => [[1,2,4]] },
      3 => { 5 => [[1,2,3,5],[1,2,4,5]],
	     6 => [[1,2,3,6],[1,2,4,6]],
	     8 => [[1,2,4,8]] }
}

@res = [1,2,3,4,5,6,8]

def compute_sum(h)
  res = {}
  h.each do |k,v|
    v.each do |vv|
      vv.each do |vvv|
	vv.each do |vvvv|
	  unless vvv+vvvv > 200 || @res.include?(vvv+vvvv)
	    res.key?(vvv+vvvv) ? res[vvv+vvvv] << (vv+[vvv+vvvv]) : res[vvv+vvvv] = [vv+[vvv+vvvv].sort]
	  end
	end
      end
    end
  end
  @res |= res.keys
  res
end

while @res.length < 200 do
  tmp = h.keys.max
  h[tmp+1] = compute_sum(h[tmp])
  p h.keys
end

sum = 0
h.each do |k,v|
  v.keys.each do |kk|
    if @res.include?(kk)
      sum += k
      @res -= [kk]
    end
  end
end
p sum
