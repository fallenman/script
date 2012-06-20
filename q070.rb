#!/usr/bin/ruby

#Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of positive numbers less than or equal to n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.
#The number 1 is considered to be relatively prime to every positive number, so φ(1)=1.
#
#Interestingly, φ(87109)=79180, and it can be seen that 87109 is a permutation of 79180.
#
#Find the value of n, 1 < n < 10**7, for which φ(n) is a permutation of n and the ratio n/φ(n) produces a minimum.

# to minimum n/φ(n) is to maximum φ(n). quite possible for 2 large primes product or p**k where p is a prime and k > 1
# stuck on this problem, because take 10**7 as 10**6.........
# in the forum, there is an excellent proof to exlude numbers that are p**k form or has a small prime factor.

require 'test_prime'
def phi(n,k)
  return n**k - n**(k-1)
end
def pair?(n,m)
  #return true if array.inject(1) {|a,b| a*= (b-1)}.to_s.split('').sort == array.inject(1) {|a,b| a*=b}.to_s.split('').sort
  return true if n.to_i.to_s.split('').sort == m.to_i.to_s.split('').sort
end

prime_list=[]
(1000..5000).each do |n|
  prime_list << n if n.prime?
end
ratio = 103
result = 0
p prime_list.length
prime_list.reverse_each do |m|
  prime_list.each do |k|
    break if m*k > 9999999
    phi_number = m == k ? (m-1)*m : (m-1)*(k-1)
    if pair?(m*k,phi_number)
      if ratio > m*k/phi_number.to_f
	ratio,result = m*k/phi_number.to_f,m*k
	p "got one smaller ratio #{ratio}, when n is #{m*k}"
      end
    end
  end
end
p result
exit
prime_list.combination(2).to_a.each do |c|
  next if c[0]*c[1] > 9999999
  phi_number = c.inject(1) {|a,b| a*= (b-1)}
  number = c.inject(1) {|a,b| a*=b}
  if pair?(number,phi_number)
    p "#{number/phi_number.to_f},#{c[0]*c[1]}"
    if ratio > number/(phi_number.to_f)
      ratio,result = number/(phi_number.to_f),c[0]*c[1]
    end
  end 
end
prime_list.each do |n|
  (2..20).each do |m|
    test = (n**m)
    break if test > 999999
    if pair?(test,phi(n,m))
      p "#{test/(phi(n,m).to_f)},#{test}"
    end
  end
end
p result
