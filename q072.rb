#!/usr/bin/ruby

#Consider the fraction, n/d, where n and d are positive integers. If nd and HCF(n,d)=1, it is called a reduced proper fraction.
#
#If we list the set of reduced proper fractions for d  8 in ascending order of size, we get:
#
#1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
#
#It can be seen that there are 21 elements in this set.
#
#How many elements would be contained in the set of reduced proper fractions for d <= 1,000,000?

require 'test_prime'
#require 'mathn'
prime_list = []
sum=0
(2..Math.sqrt(1000000).to_i).each do |n|
  prime_list << n if n.prime?
end
division_result = {}
(2..1000000).each do |n|
  if n.prime?
    sum += n-1
    #division_result[n] = [[n,1]]
    division_result[n] = [n]
  else
    prime_list.each do |pp|
      if n%pp == 0
        #tmp = division_result[n/pp].select {|x| x[0] == pp}
	#if tmp.length > 0
	#  element = tmp.first
	#  division_result[n] = division_result[n/pp].map {|y| (y[0] == element[0] ? [y[0],y[1]+1] : y)}
	#else
	#  division_result[n] = division_result[n/pp]+[[pp,1]]
	#end
	#sum += division_result[n].inject(1) {|a,b| a*=(b[0]-1)*b[0]**(b[1]-1)}
	#break
	division_result[n] = division_result[n/pp].include?(pp) ? division_result[n/pp] : division_result[n/pp] + [pp]
	#division_result[n] = division_result[n/pp] - [pp] + [pp]
	sum += division_result[n].inject(n) {|a,b| a=a*(b-1)/b}
	break
      end
    end
    #sum += n.prime_division.inject(1) {|a,b| a*=(b[0]-1)*b[0]**(b[1]-1)}
    #p sum,n
  end
end
p sum
exit

sum = 0
#prime_list.each_key do |k|
def test_cf(a,b)
  a,b = b,a if a > b
  number_factor = a.prime_division.inject([]) {|c,d| c << d[0]}
  number_factor.each do |n|
    return true if b%n == 0
  end
  return false
end
(2..number).each do |n|
  prime_list[n] = n if n.prime?
end
p prime_list.sort
(1..number).each do |m|
  next if prime_list.has_key?(m)
  m.prime_division
end
#prime_list.each_key do |k|
#  line = number%k == 0 ? (number - k)/k : (number - k)/k + 1
#  p "#{k},#{line}"
#  sum += (1+line)*line/2
#end
#p number*(number-1)/2-sum
#(2..number).each do |k|
#  sum += test_cf(number,k) ? ((number-k)*(k-1)/k).to_i : ((number-k)*(k-1)/k).to_i+1
#  p "#{number},#{k} has common factor is #{test_cf(number,k)},#{((number-k)*(k-1)/k).to_i}"
#end
#p sum+number-2

