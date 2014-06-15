#/usr/bin/env ruby
#Using all of the digits 1 through 9 and concatenating them freely to form decimal integers, different sets can be formed. Interestingly with the set {2,5,47,89,631}, all of the elements belonging to it are prime.
#
#How many distinct sets containing each of the digits one through nine exactly once contain only prime elements?

require './test_prime.rb'

def same_digit?(a,b)
  return false if a == 0
  return true if b.to_s.include?((a%10).to_s)
  same_digit?(a/10,b)
end

def array_same_digit?(a)
  return false if a.length == 1
  a[1,10].each do |aa|
    return true if same_digit?(aa,a[0])
  end
  array_same_digit?(a[1,10])
end

def distinct(a,d)
  if a.length == 1
    a[0].reject{|x|same_digit?(x.join.to_i,d)}.length
  else
    res = 0
    a[0].each do |aa|
      next if same_digit?(aa.join.to_i,d)
      tmpd = (aa.join+d.to_s).to_i
      res += distinct([a[1].reject{|x|same_digit?(x.join.to_i,tmpd)}]+a[2,10],tmpd)
    end
    res
  end
end

def sum_way(n)
  res = [[n]]
  (n/2).times do |nn|
    res += sum_way(n-nn-1).map{|x|x+[nn+1]}
  end
  res.map{|x|x.sort}.uniq
end
p sum_nine = sum_way(9).reject{|x|x.length==1 || x.count(1)>4}.map{|x|x.map{|y|[y,x.count(y)]}.uniq}

primes = {}
a = (1..9).to_a
(1..8).each do |n|
  primes[n] = []
  a.combination(n).each do |an|
    an.permutation.each do |anp|
      tmp = anp.join.to_i
      primes[n] << tmp if tmp.prime?
    end
  end
end
p primes.map{|k,v|v.length}.inject(0){|a,b|a+=b}

res = 0
sum_nine.each do |sn|
  tmp = []
  sn.each do |s|
    tmp << primes[s[0]].combination(s[1]).to_a.reject{|x|array_same_digit?(x)}
  end
  res += distinct(tmp,[0])
  p res
end
p res
