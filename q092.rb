#!/usr/bin/ruby

#A number chain is created by continuously adding the square of the digits in a number to form a new number until it has been seen before.
#
#For example,
#
#44  32  13  10  1  1
#85  89  145  42  20  4  16  37  58  89
#
#Therefore any chain that arrives at 1 or 89 will become stuck in an endless loop. What is most amazing is that EVERY starting number will eventually arrive at 1 or 89.
#
#How many starting numbers below ten million will arrive at 89?

#seem like an easy one?
#no, there are some caches you should do.
#first, the upper bound.
#you should record 7*9**2 numbers first! then you just check!
#brute force is around 50s work (but!!! a much more pure brute force in C cost only 2-3 secs!!!). what else can i do?
#so although i have the correct answer, i spent 3 more days to think over it.
#yeah, combination and permutation. of course.
#but how can you determine how many permutations for, say some random number like 112345?
#wow... i figure out another way.
#for 1-digit number we have [1,4,9,..81], then for 2-digits, 1+1,1+4,1+9,...1+81,4+1,4+4,...81+81, and 10 zeros(10,20,30,..90)!
#so use a hash to track the sum count. if you have a hash on n-digit condition, then for (n+1) conditions, you do a loop for the hash and inside each loop you do a (1..9) loop, and compute out a new hash for exact (n+1)-digits conditions and then merge the new/tmp hash with the original hash. don't forget you need add that 10 zeros when you finish the merge. 
#it's fxcking fast!!! 0.05s

RES={}
(1..7*9**2).each do |k|
  tmp = k
  until k == 1 || k == 89
    k = k.to_s.split('').inject(0) {|c,d| c+=d.to_i**2}
  end
  RES[tmp] = k
end
S={}
(1..9).each do |n|
  S[n**2] = 1
end
6.times do |i|
t={}
S.each do |s|
  (1..9).each do |m|
    tmp = s[0]
    t[s[0]+m**2].nil? ? t[s[0]+m**2]=s[1] : t[s[0]+m**2]+=s[1]
  end
end
S.merge!(t){|key,v1,v2| v1 = 0 if v1.nil? ; v2 = 0 if v2.nil? ; v1+v2}
(1..9).each do |z|
  S[z**2] += 1
end
end
result = 0
S.each do |ss|
  if RES[ss[0]] == 89
    result += ss[1]
  end
end
p result
exit
#in the forum, someone mentioned a permutation formula. for number like 112345, you count each number, you have a result, 2 1 1 1 1, then its permutation is (2+1+1+1+1)!/(2!*1!*1!*1!*1!). i tried this but failed. maybe something wrong with my code.
result = 0
(0..9).each do |a|
  (a..9).each do |b|
    (b..9).each do |c|
      (c..9).each do |d|
	(d..9).each do |e|
	  (e..9).each do |f|
	    (e..9).each do |z|
	      if RES[a**2+b**2+c**2+d**2+e**2+f**2+z**2] == 89
		tmp = {}
		[a,b,c,d,e,f,z].each do |g|
		  tmp[g].nil? ? tmp[g] = 1 : tmp[g] += 1
		end
		sum,pro=0,1
		tmp.each do |h|
		  sum += h[1]
		  pro *= (1..h[1]).inject(1) {|i,j| i*=j}
		end
		result += (1..sum).inject(1) {|k,l| k*=l}/pro
	      end
	    end
	  end
	end
      end
    end
  end
end
p result
exit
#improved brute force. still very slow in ruby. cost 50s
@sum = 0
(1..9999999).each do |n|
  sum = 0
  while n > 0
    sum += (n%10)**2
    n /= 10
  end
  @sum += 1 if RES[sum] == 1
end
p 10000000-@sum-1
