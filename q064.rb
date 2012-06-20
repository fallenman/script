#!/usr/bin/ruby

#http://projecteuler.net/problem=64
# this question is an upgrade version of 57

def fraction(hash,n)
  result = {}
  result[:n] = (n - hash[:minus]**2)/hash[:n]
  result[:i] = (Math.sqrt(n).to_i + hash[:minus])/result[:n]
  result[:minus] = result[:i]*result[:n]-hash[:minus]
  result
end
sum=0
s=[]
(1..100).each do |c|
  s << c**2
end
(1..10000).each do |n|
  next if s.include?(n)
  hash = {}
  fir=fraction({:n=>1,:minus=>Math.sqrt(n).to_i},n)
  while !hash.has_key?(fir)
    hash[fir] = 1
    fir=fraction(fir,n)
  end
  sum+=1 if hash.length%2 == 1
end
p sum
