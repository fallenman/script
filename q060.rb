#!/usr/bin/ruby

#The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.
#
#Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.

# notice the result is [3,6k+1] or [3,6k-1] or [6k+1] or [6k-1]
# stuck on this for a whole day.
# the brute force below can reach the right result at the first time. but i can not prove the upper bound is 10000. it is the result that by trying... what a fool i am... and the practical algorithm can be improved, but i have no energy on this one...
# in fact, when the result came out the very first time, we can use that for a new upper bound and check if there is no sum less than it. at least, this will guarantee the result is absolutely right.
# find pair primes ( here i would rather call it as gay primes ) first, and use a boolean matrix or combination way to check for three, four, five, is the first way that i got. but the problem left is still there, where is the upper bound.
# however this question, if solved in this relatively solid logic way, will be an O(n**5), someone mentioned in the forum.

require 'test_prime'
def cc(n,m)
  return true if (n.to_s+m.to_s).to_i.prime? && (m.to_s+n.to_s).to_i.prime?
  return false
end
#(833..1000000).step(6).each do |n|
#  if cc(n,23) && cc(n,311) && cc(n,677) && cc(n,827)
#    p n
#    exit
#  end
#end
def concatenate(array)
  while array.length > 1
    test = array.first
    array -= [test]
    array.each do |c|
      return false unless ((test.to_s+c.to_s).to_i.prime? && (c.to_s+test.to_s).to_i.prime?)
    end
  end
  return true
end
def get_five
result=[]
(3..10000).step(2).each do |start_number|
  if start_number.prime?
((start_number+2)..10000).step(2).each do |n|
  if n.prime? && cc(start_number,n)
    ((n+6)..10000).step(6).each do |m|
      if m.prime? && cc(m,n) && cc(start_number,m)
	((m+6)..10000).step(6).each do |k|
	  if k.prime? && cc(start_number,k) && cc(n,k) && cc(m,k)
	    p [start_number,n,m,k]
	    ((k+6)..10000).step(6).each do |j|
	      if j.prime? && cc(start_number,j) && cc(n,j) && cc(m,j) && cc(k,j)
		p "seems like got one"
		p [start_number,n,m,k,j]
		sum = 0
		[start_number,n,m,k,j].collect {|x|sum+=x}
		p sum
	      end
	    end
	  end
	end
      end
    end
  end
end
end
end
result
end
p get_five
exit
[[3, 7, 109, 673], [3, 7, 541, 4159], [3, 37, 67, 2377], [3, 37, 2377, 4159], [7, 19, 97, 3727], [7, 19, 97, 4507], [7, 19, 1249, 3727], [7, 61, 1693, 3181], [7, 433, 1471, 3613], [7, 829, 2671, 3361], [7, 1237, 1549, 3019], [7, 2089, 2953, 3181], [7, 2089, 3181, 4219], [31, 1123, 2029, 2281], [37, 991, 2269, 3613], [37, 1549, 2707, 3463], [79, 967, 1117, 3511], [79, 1801, 3253, 3547], [397, 907, 3919, 4567], [1447, 2803, 3769, 4051], [1753, 1951, 3547, 3643], [1783, 2953, 3643, 4273]].each do |a|
  p concatenate(a)
end
[[3, 11, 2069, 2297], [3, 17, 449, 2069], [3, 17, 2069, 2297], [3, 467, 617, 4253], [11, 23, 743, 1871], [11, 239, 1049, 1847], [11, 239, 1091, 1847], [17, 2741, 3917, 4649], [23, 47, 1481, 4211], [23, 311, 677, 827], [23, 677, 827, 1871], [47, 947, 1439, 4931], [89, 107, 1061, 4973], [101, 2633, 2699, 4337], [269, 617, 887, 2741], [809, 1361, 2141, 3947], [1319, 2243, 2789, 4133], [1451, 2699, 3413, 3761], [2039, 3299, 3767, 4523]].each do |c|
  while c.length > 1
    tmp = c.first
    c -= [tmp]
    c.each do |ccc|
      p ccc unless (ccc.to_s+tmp.to_s).to_i.prime? && (tmp.to_s+ccc.to_s).to_i.prime?
    end
  end
end
exit
p concatenate([3,7,109,673])
p concatenate([23,311,677,827])
a = [3]
b = [3]
(7..1000).step(6).each do |n|
  a << n if n.prime?
end
(11..1000).step(6).each do |n|
  b << n if n.prime?
end
p a.length,b.length
def get_gay_primes(d)
  result = []
  while d.length > 1
    tmp = d.first
    d -= [tmp]
    d.each do |cc|
      result << [tmp,cc] if concatenate([tmp,cc])
    end
  end
  result
end
aa=get_gay_primes(a)
bb=get_gay_primes(b)
p aa.length,bb.length
p aa
aaa,bbb=[],[]
aa.each do |v|
  a -= [v[0]]
  (a-v).each do |vv|
    aaa << (v+[vv]).sort if concatenate(v+[vv])
  end
end
bb.each do |v|
  b -= [v[0]]
  (b-v).each do |vv|
    bbb << (v+[vv]).sort if concatenate(v+[vv])
  end
end
p aaa
exit
aaaa,bbbb=[],[]
aaa.uniq.each do |v|
  (a-v).each do |vv|
    aaaa << (v+[vv]).sort if concatenate(v+[vv])
  end
end
bbb.uniq.each do |v|
  (b-v).each do |vv|
    bbbb << (v+[vv]).sort if concatenate(v+[vv])
  end
end
p aaaa.uniq,bbbb.uniq

exit
def get_three_primes(nn)
  result3 = []
  while nn.length > 1
    tmp = nn.first
    nn -= [tmp]
    nn.each do |c|
      if (c-tmp).length == 1 && concatenate(c|tmp)
	result3 << (tmp | c).sort
      end
    end
  end
  result3.uniq
end
aaa=get_three_primes(aa)
bbb=get_three_primes(bb)
p aaa.length
p bbb.length
p aaa
p bbb
def get_four_primes(a)
  result4 = []
  result3 = a
  while result3.length > 1
    tmp = result3.first
    result3 -= [tmp]
    result3.each do |c|
      if (c - tmp).length == 1
	result4 << (c|tmp).sort if (a.include?(((c|tmp)-[(c&tmp).first]).sort) && a.include?(((c|tmp)-[(c&tmp).last]).sort)) || concatenate(c|tmp)
      end
    end
  end
  result4.uniq
end
p get_four_primes([[3,7,109],[3,7,673],[3,109,673],[7,109,673]])
aaaa=get_four_primes(aaa)
bbbb=get_four_primes(bbb)
p aaaa
p bbbb
[aaaa,bbbb].each do |rrr|
rrr.each do |rr|
  p rr
  ((rr[-1]+6)..1000000).step(6).each do |n|
    if n.prime? && concatenate(rr+[n])
      p "seems like got one"
      p rr+[n]
      break
    end
  end
end
end
