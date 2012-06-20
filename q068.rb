#!/usr/bin/ruby

#http://projecteuler.net/problem=68

# no clue at all before any practice. and... solve the 3-gon, then got the 5-gon result. just recursive way.
# in fact, you can guess the number...
# you should start with 6.

# 10 must be in the external node.

a=(1..10).to_a
@result = []
def recursive(array,result,sum)
  if array.length == 1
    result[4] = []
    result[4][0] = array.first
    result[4][2] = result[0][1]
    result[4][1] = result[3][2]
    @result << result if result[4].inject(0) {|x,y| x+=y} == sum
  else
    if sum == 0
      array.each do |n|
	(array-[n]).each do |m|
	  (array-[n,m]).each do |k|
	    recursive(array-[n,m,k],[[n,m,k]],n+m+k)
	  end
	end
      end
    else
      tmp = result[-1][2]
      array.each do |n|
	next unless (array-[n]).include?(sum-n-tmp)
	recursive(array-[n]-[sum-n-tmp],result+[[n,tmp,sum-n-tmp]],sum)
      end
    end
  end
end
recursive(a,[],0)
number = 0
@result.each do |c|
  next if c.to_s.length==17
  p c
  i = c.index(c.sort.first)
  number = [c[i],c[i-4],c[i-3],c[i-2],c[i-1]].join('').to_i if number < [c[i],c[i-4],c[i-3],c[i-2],c[i-1]].join('').to_i
end
p number
