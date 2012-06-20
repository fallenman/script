#!/usr/bin/ruby

#The number 145 is well known for the property that the sum of the factorial of its digits is equal to 145:
#
#1! + 4! + 5! = 1 + 24 + 120 = 145
#
#Perhaps less well known is 169, in that it produces the longest chain of numbers that link back to 169; it turns out that there are only three such loops that exist:
#
#169  363601  1454  169
#871  45361  871
#872  45362  872
#
#It is not difficult to prove that EVERY starting number will eventually get stuck in a loop. For example,
#
#69  363600  1454  169  363601 ( 1454)
#78  45360  871  45361 ( 871)
#540  145 ( 145)
#
#Starting with 69 produces a chain of five non-repeating terms, but the longest non-repeating chain with a starting number below one million is sixty terms.
#
#How many chains, with a starting number below one million, contain exactly sixty non-repeating terms?

# use digit combination in which repeated digit is allowed. but 0 is a little naughty.
# i was stupid, so i cheated at last: suppose another number has the same sum to 1479.
# i should write my own method to get all combinations in which repeated digit is allowed. i relied on Array#combination too much.
# in fact, i should consider to build a hash which like hash[number_combination] = length
# finally, i got the naughty number 40585 and 40730, which can be produced by q034...
def factorial(n)
  (1..n).inject(1) {|a,b| a*=b}
end
@digit_factorial = (0..9).map {|x| factorial(x)}
def caculate(n)
  result = 0
  while n > 0
    m = n%10
    n /= 10
    #result += m == 0 ? 1 : @digit_factorial[m-1]
    result += @digit_factorial[m]
  end
  result
end
@loop_hash = {145.to_s.split('').sort=>1,169.to_s.split('').sort=>3,363601.to_s.split('').sort=>3,1454.to_s.split('').sort=>3,871.to_s.split('').sort=>2,872.to_s.split('').sort=>2,45361.to_s.split('').sort=>2,45362.to_s.split('').sort=>2,1.to_s.split('').sort=>1,2.to_s.split('').sort=>1,40585.to_s.split('').sort=>1,40730.to_s.split('').sort=>1}
result = 0
(1..1000000).each do |n|
  sum = 0
  original = [n]
  until @loop_hash.has_key?(n.to_s.split('').sort)
    n = caculate(n)
    original << n
    sum += 1
  end
  original.each_with_index do |m,index|
    @loop_hash[m.to_s.split('').sort] ||= @loop_hash[n.to_s.split('').sort]+sum-index
  end
  result += 1 if @loop_hash[original.first.to_s.split('').sort] == 60
end
#@loop_hash.select{|x,y|y==60}.each do |array|
#  zeros = array[0].grep(0).length
#  #sum += @digit_factorial[array[0].length]-zeros
#end
p result
exit
total = 0
(1..6).each do |n|
  (1..9).to_a.combination(n).to_a.each do |cc|
    sum = 0
    #k = cc.inject(0) {|a,b| a+=b}
    k = cc.to_s.to_i
    until @loop_hash[k]
      k = caculate(k)
      sum += 1
    end
    sum += @loop_hash[k]
    p cc if sum == 60
  end
end
exit
(1..10000).each_with_index do |n,i|
  sum = 0
  until @loop_hash[n]
    n = caculate(n)
    sum += 1
  end
  sum += @loop_hash[n]
  if sum == 60
    total += 1
  end
end
p total
