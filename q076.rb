#!/usr/bin/ruby

#It is possible to write five as a sum in exactly six different ways:
#
#4 + 1
#3 + 2
#3 + 1 + 1
#2 + 2 + 1
#2 + 1 + 1 + 1
#1 + 1 + 1 + 1 + 1
#
#How many different ways can one hundred be written as a sum of at least two positive integers?

# interesting.
# well, in the forum they say it's an upgrade problem from 31. oh shit, i did not notice that !
# i took the same weird way to reach it(same as rayfil). but it's still interesting and fast enough. and in q078 i found it was a standard way somehow.
# i'm sure next problem is an upgrade one for this...
k=100
hash = {2=>{1=>1}}
(3..k).each do |n|
  hash[n] = {}
  hash[n][1] = hash[n-1].inject(1) {|a,b| a+=b[1]}
  (2..n/2).each do |m|
    hash[n][m] = hash[n-m].select {|c,d| c>=m}.inject(1) {|e,f| e+=f[1]}
  end
end
p hash[k].values.inject(0) {|g,h| g+=h}
exit
hash = {2=>{[1,1]=>1}}
(3..m).each do |n|
  comb = hash[n-1]
  tmp = {}
  comb.each do |c|
    tmp[(c[0]+[1]).sort] = 1 #unless tmp[(c[0]+[1]).sort]
    c[0].uniq.each do |cc|
      index = c[0].index(cc)
      tmpp = []
      c[0].each_with_index do |ccc,i|
	tmpp << (i == index ? ccc+1 : ccc) 
      end
      tmp[tmpp.sort] = 1# unless tmp[tmpp.sort]
    end
  end
  hash[n] = tmp
end
p hash[m].length
#p hash[m].sort
