#!/usr/bin/ruby

#By using each of the digits from the set, {1, 2, 3, 4}, exactly once, and making use of the four arithmetic operations (+, - , *, /) and brackets/parentheses, it is possible to form different positive integer targets.
#
#For example,
#
#8 = (4 * (1 + 3)) / 2
#14 = 4 * (3 + 1 / 2)
#19 = 4 * (2 + 3)  1
#36 = 3 * 4 * (2 + 1)
#
#Note that concatenations of the digits, like 12 + 34, are not allowed.
#
#Using the set, {1, 2, 3, 4}, it is possible to obtain thirty-one different target numbers of which 36 is the maximum, and each of the numbers 1 to 28 can be obtained before encountering the first non-expressible number.
#
#Find the set of four distinct digits, a < b < c < d, for which the longest set of consecutive positive integers, 1 to n, can be obtained, giving your answer as a string: abcd.

#a quick coding in brute force and thanks to eval, i can easily combine the expression in any form that i want. and it appears that for Perl, PHP, they all like eval!
#24*126*64*8 ways of the permutation and combination of operators, numbers, and parentheses.
#but it's a 1m20s solution since there're too many repeated computes. so i need to consider how to optimize it.
#so here is the idea to optimize it: record the distinct experssion.
#and the admin suggest another interesting way: use a different notation, postfix, to avoid the problem of parentheses. it means operator after number. something like 1 2 + 3 * 4 / = ((1+2)*3)/4 and 1 2 3 * - 4 5 - * = (1-(2*3))*(4-5)

#after a few weeks, finally i found my own way to optimize it.
#just restore all the possible results for (x,y), even if x is an array(yep, i test, it's faster when restore everything in the hash!). this way avoids the problem of parentheses and most of repeated compute.
#now it's 10 secs thing. and since i'm stupid, i'm satisfied. i'm not going to avoid every repeated compute..
require 'mathn'
@compute_hash={}
def compute(x,y)
  if x.is_a? Array
    return @compute_hash[[x,y]] if @compute_hash.has_key?([x,y])
    tmp = []
    x.each do |xx|
      tmp = tmp|compute(xx,y)
    end
    @compute_hash[[x,y]] = tmp
    tmp
  else
    return @compute_hash[[x,y].sort] if @compute_hash.has_key?([x,y].sort)
    x*y == 0 ? @compute_hash[[x,y].sort] = [x,-x,-y,y].uniq : @compute_hash[[x,y].sort] = [x+y,x-y,y-x,x*y,x/y,y/x].uniq
  end
end
comb=[]
result=[]
(1..9).to_a.combination(4).to_a.each do |aa|
  tmp_aa = []
  aa.permutation(4).to_a.each do |aaa|
    tmp_aa = tmp_aa|compute(compute(compute(aaa[0],aaa[1]),aaa[2]),aaa[3])
  end
  res = []
  tmp_aa.select{|x|x>0 && x.is_a?(Integer)}.sort.each_with_index do |t,i|
    break unless t == i+1
    res << t
  end
  #p aa,tmp_aa.select{|x|x>0 && x.is_a?(Integer)}.sort
  if res.length > result.length
    result = res
    comb = aa
  end
end
p comb,result
exit
#first try, quick code using eval. but runs slowly.
OP=(["+","-","*","/"]*3).permutation(3).to_a.uniq
BR=[["(",")"],["","(",")"],["","","(",")"],["(","",")"],["","(","",")"],["((",")",")"],["(","(","))"],["","((",")",")"],["","(","(","))"]]
result=[]
comb=0
hash={}
(1..9).to_a.combination(4).to_a.each do |aa|
  res=[]
  aa.permutation(4).to_a.each do |a|
    OP.each do |op|
      BR.each do |br|
      exp=[]
      i = 0
      #r = 0
      op.each do |opp|
	#i == 0 ? (r = eval "#{a[i]}#{opp}#{a[i+1]}") : (r = eval "#{r}#{opp}#{a[i+1]}")
	exp << "#{br[i]}" if br[i] =~ /\(/
	exp << "#{a[i]}"
	exp << "#{br[i]}" if br[i] =~ /\)/
	exp << "#{opp}"
	i += 1
      end
      exp << "#{a[i]}"
      exp << "#{br[i]}"
      #exp << a[i].to_f.to_s
      #p exp
      #p eval exp.to_s
      #sleep 3
      begin
      r = eval exp.to_s
      rescue
      r = 0
      end
      res << r if r > 0 && r%1 == 0 && !res.include?(r)
      end
    end
  end
  tmp = []
  res.sort.each_with_index do |rr,i|
    break unless rr == i+1
    tmp << rr
  end
  if result.length < tmp.length
    result = tmp
    comb = aa
  end
  hash[aa] = res.sort
end
p comb
p result
p hash[[1,2,3,4]]
