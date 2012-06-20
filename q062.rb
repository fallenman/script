#!/usr/bin/ruby

#The cube, 41063625 (345**3), can be permuted to produce two other cubes: 56623104 (384**3) and 66430125 (405**3). In fact, 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.
#
#Find the smallest cube for which exactly five permutations of its digits are cube.

# use hash instead of array is much much much much much... faster. always!! 8.2s down to 0.2s, holy shit!!
# add some "redundant" code to make sure the result is correct!

b={}
upper_bound=1000000000
final_result=[]
(1..100000).each do |n|
  if n > upper_bound
    p "reach the upper bound!! find #{final_result.length} candidates"
    p "so the real number is"
    p final_result.min
    exit
  end
  result = (n**3).to_s.split('').sort
  if b.has_key?(result)
    b[result][1] += 1
    if b[result][1] == 5
      p "get one possible number, but we must reach the upper bound to check if there are more permutations!"
      p b[result]
      upper_bound = ((10**(result.to_s.length))**(1.0/3)).to_i
      test = 0
      ((n+1)..upper_bound).each do |m|
	if (m**3).to_s.split('').sort == result
	  test = 1
	  p "damn #{m} makes the result more than i want"
	  break
	end
      end
      if test == 0
        p "seems like it is the possible number, let's see if there is another number smaller than it!!"
	final_result << b[result][0]
      end
    end
  else
    b[result] = []
    b[result][0] = n**3
    b[result][1] = 1
  end
end
exit
# slow but short code. first version
a=[]
(1..10000).each do |n|
  tmp = n**3
  result = tmp.to_s.split('').sort
  a << result
end

a.each do |c|
  if a.count(c) == 5
    p a.index(c)
    p (a.index(c)+1)**3
    exit
  end
end
