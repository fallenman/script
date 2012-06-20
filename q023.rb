#!/usr/bin/ruby

#A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.
#
#A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.
#
#As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.
#
#Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.


# very interesting. according to the output, it appears that 945 is the smallest odd abundant number.
# first, I've tried to go through every one between 25 and 28123. it's quite stupid.
# find all the abundant number less than 28123/2 or 28123 should be much faster than go through every one.

# what a fool! it's even much slower than before...
# so I have to figure out another way.. but the set of abundant numbers are still in use.

def all_divisors(num)
  divs=[]
  (1..(num**0.5).to_i).each do |c|
    if num%c==0
      divs << c
      divs << num/c
    end
  end
  return divs.uniq
end

sum = 0
def abundant?(pro)
  tmpsum = 0
  all_divisors(pro).each do |aa|
    tmpsum += aa
  end
  return false unless tmpsum - pro > pro
  return true
end

an = (1..28123).select { |n| abundant?(n) }
ans = []
an.each do |x|
  an.each do |y|
    s = x+y
    break if s > 28123
    ans << s
  end
end

not_ans = (1..28123).to_a - ans
puts not_ans.inject(0) { |agg, n| agg + n }

#abundant=[]
#(12..28123).each do |k|
#  divtmp = all_divisors(k)
#  tmpsum = 0
#  divtmp.each do |c|
#    tmpsum += c
#  end
#  if tmpsum - k > k
#    abundant << k
#  end
#end
#p abundant.length


#atmp = abundant
#asum = []
#abundant.each do |d|
#  atmp.each do |de|
#    asum << d+de if d+de <= 28123
#  end
#  atmp.delete(d)
#end
#bsum = 0
#csum = []
#(1..28123).each do |p|
#  csum << p
#end
#(csum - (asum.uniq & csum)).each do |kk|
#p (csum-asum.uniq)[-1]
#(csum-asum.uniq).each do |kk|
#  sum += kk
#end
#asum.uniq.each do |p|
#  bsum += p
#end
#p asum.uniq.sort[-1]
#p "so, there are #{asum.uniq.length} unique numbers that can be written as the sum of 2 abundant numbers" 
#p "their sum is #{bsum}"
#(1..asum.uniq.sort[-1]).each do |j|
#  sum += j
#end
#sum -= bsum
#(24..28123).each do |p|
#  watchnum = 0
#  abundant.each do |m|
#    if p - m <= 0
#      break
#    else 
#      if abundant.include?(m) && abundant.include?(p-m)
#        watchnum = 1
#        break
#      end
#    end
#  end
#  if watchnum == 0
#    sum += p
#    p "#{p} cannot be written as the sum of 2 abundant numbers"
#  end
#end
#while n < 28123 do
#  watchnum = 0
#  (12..((n-12)/2).to_i).each do |c|
#    divs1 = all_divisors(c)
#    divs2 = all_divisors(n-c)
#    divs1.delete(c)
#    divs2.delete(n-c)
#    tmpsum1 = 0
#    tmpsum2 = 0
#    divs1.each do |a|
#      tmpsum1 += a
#    end
#    if tmpsum1 > c
#      divs2.each do |b|
#        tmpsum2 += b
#      end
#      if tmpsum2 > n-c
#        #p "#{n} can be written as the sum of 2 abundant numbers #{c} and #{n-c}"
#        watchnum = 1
#        break
#      end
#    end
#  end
#  if watchnum == 0
#    p "#{n} can not be written as the sum of 2 abundant numbers!"
#    sum += n
#  end
#  n += 1
#end
#p "the result we want is #{sum}"
