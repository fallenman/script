#!/usr/bin/ruby

#If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.
#
#{20,48,52}, {24,45,51}, {30,40,50}
#
#For which value of p  1000, is the number of solutions maximised?

#at first, i use p to start the loop. it's too slow.

totals = Hash.new(0)

(1..500).each do |a|
  (1..(500-a)).each do |b|
    c = Math.sqrt(a**2 + b**2)
    totals[a+b+c] += 1 if c % 1 == 0 && (a+b+c) < 1000
  end
end

puts totals.max{|a,b| a[1] <=> b[1]}[0]
exit

num = 0
@sum = 0
(12..1000).each do |n|
  sum = 0
  (1..n/3).each do |m|
    (m..(n-m)/2).each do |k|
      c = n - m - k
      #a = [c,m,k].min
      #b = [c,m,k].max
      #comb << [c,m,k].sort if ! comb.include?([c,m,k].sort) && b**2 == a**2 + (n-a-b)**2
      sum += 1 if m**2 + k**2 == c**2
    end
  end
  @sum,num = sum,n if @sum < sum
end
p num
p @sum

