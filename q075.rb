#!/usr/bin/ruby

#It turns out that 12 cm is the smallest length of wire that can be bent to form an integer sided right angle triangle in exactly one way, but there are many more examples.
#
#12 cm: (3,4,5)
#24 cm: (6,8,10)
#30 cm: (5,12,13)
#36 cm: (9,12,15)
#40 cm: (8,15,17)
#48 cm: (12,16,20)
#
#In contrast, some lengths of wire, like 20 cm, cannot be bent to form an integer sided right angle triangle, and other lengths allow more than one solution to be found; for example, using 120 cm it is possible to form exactly three different integer sided right angle triangles.
#
#120 cm: (30,40,50), (20,48,52), (24,45,51)
#
#Given that L is the length of the wire, for how many values of L  1,500,000 can exactly one integer sided right angle triangle be formed?
#
#Note: This problem has been changed recently, please check that you are using the right parameters.

# something to do with Pythagorean triple theory.
# for m > n, we have a=m**2-n**2, b=2mn, c=m**2+n**2
# in fact, use this theory, you can caculate the result of problem 9 by hand...
# and i think there's something more we can do to reduce computer's work...
# of course, let's assume a+b+c = 1500000, then we get m(m+n) = 750000. we can do a loop that is much simpler !!
# and it seems like if i write a gcd method to find out all the primitive Pythagorean triplets, it will be faster.

#wire = 1500000
#this method below cost 40 secs or more.
wire = 1500000
sum = 0
hash={}
result={}
(1..Math.sqrt(wire/3)).each do |n|
  ((n+1)..Math.sqrt(wire/2)).each do |m|
    tmp = [2*n*m,m**2-n**2,m**2+n**2].sort
    tmp_sum = tmp.inject(0) {|a,b| a+=b}
    if tmp_sum <= wire
      (1..wire/tmp_sum).each do |mu|
	tmpm = tmp.map {|x|x*mu}
	#hash[tmpm] = tmpm.inject(0) {|a,b| a+=b} unless hash.key?(tmpm)
	unless hash.key?(tmpm)
	  hash[tmpm] = tmpm.inject(0) {|a,b| a+=b}
	  result[hash[tmpm]] = result[hash[tmpm]] ? result[hash[tmpm]]+1 : 1
	end
      end
    end
    #hash[tmp] = tmp.inject(0) {|a,b| a+=b} if tmp.inject(0) {|a,b| a+=b} <= wire
    #tmp = 2*n*m+m**2-n**2+m**2+n**2
    #hash[tmp] = hash.key?(tmp) ? hash[tmp]+1 : 1
  end
end
p result.length
p result.values.grep(1).length
exit
