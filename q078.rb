#!/usr/bin/ruby

#Let p(n) represent the number of different ways in which n coins can be separated into piles. For example, five coins can separated into piles in exactly seven different ways, so p(5)=7.
#
#Find the least value of n for which p(n) is divisible by one million.

#this is totally final form of q076... each number n has one more combination (n+0)
#i have to lookup this theory now:
#http://en.wikipedia.org/wiki/Partition_(number_theory)
#after reading it, i realized that my idea in q076 is not weird at all. it's one of the standard!! the difference is in q076 i don't count (n+0) condition. and this ensures that my hash[n][1] is equal to the p(1,n-1) in the Intermediate function
#but still, i stuck on time complexity. because there is something more...
#wait, i should restore every sum...
#it won't work using the original method, i have to use the recurrence!!!! and i'm too stupid to understand it at first...
#and i get all the hints in thread q076... especially the Math.sqrt(n) for the upper limit.
#it can be faster, but i don't have any strength to do optimize it.

@hash = {0=>1,1=>1,2=>2,3=>3,4=>5,5=>7,6=>11,7=>15,8=>22,9=>30,10=>42}
def part(n)
  return 0 if n < 0
  return @hash[n] if @hash[n]

  sum = 0
  (1..Math.sqrt(n).to_i).each do |k|
    sum += (-1)**(k+1)*(part(n-k*(3*k-1)/2)+part(n-k*(3*k+1)/2))
  end
  @hash[n] = sum%10000000
end
(599..100000).each do |j|
  tmp = part(j)
  if tmp%1000000 == 0
    p j,tmp
    exit
  end
end
exit
#@hash = {}
#def generator(k,n)
#  if k > n
#    return 0
#  elsif k == n
#    @hash[[k,n]] == 1
#    return 1
#  else
#    return (@hash[[k+1,n]]||generator(k+1,n))+(@hash[[k,n-k]]||generator(k,n-k))
#  end
#end
#exit
k=801
hash = {2=>{1=>1}}
sum_hash = {}
(3..k).each do |n| 
  hash[n] = {}
  #sum_hash[n] ||= {}
  hash[n][1] = hash[n-1].inject(1) {|a,b| a+=b[1]}
  hash[n][1] %= 10000000
  (2..n/2).each do |m| 
    #hash[n][m] = (sum_hash[n][m] ||= hash[n-m].select {|c,d| c>=m}.inject(1) {|e,f| e+=f[1]})
    hash[n][m] = 1
    (m..(n-m)/2).each do |j|
      hash[n][m] += hash[n-m][j]
    end
    hash[n][m] %= 10000000
  end 
  if hash[n][1]%10000 == 0
    p n,hash[n][1]
  end
  #p n,hash[n].values.inject(0) {|g,h| g+=h} if (hash[n].values.inject(0) {|g,h| g+=h}+1)%10000 == 0
  #p hash[n][1]
  #if (result+1)%10000 == 0
  #  p n,result
  #end
end
#p hash.select {|a,b| a>=(k-10)}
p hash[k][1]
