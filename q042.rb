#!/usr/bin/ruby

#The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); so the first ten triangle numbers are:
#
#1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
#By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number then we shall call the word a triangle word.
#
#Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?

a=File.new('words.txt','r')
tri=[]
result = 0
#(1..100).each do |n|
#  tri << n*(n-1)/2
#end
a.readlines[0].split(',').each do |f|
  tmp = f.split('"')[1]
  s = 0
  tmp.split('').each do |c|
    s += (("A".."Z").to_a.index(c)+1)
  end
  result +=1 if (Math.sqrt(8*s+1)-1)/2 % 1 == 0
  #result += 1 if tri.include?(s)
end
p result
