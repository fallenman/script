#The palindromic number 595 is interesting because it can be written as the sum of consecutive squares: 62 + 72 + 82 + 92 + 102 + 112 + 122.
#
#There are exactly eleven palindromes below one-thousand that can be written as consecutive square sums, and the sum of these palindromes is 4164. Note that 1 = 02 + 12 has not been included as this problem is concerned with the squares of positive integers.
#
#Find the sum of all the numbers less than 108 that are both palindromic and can be written as the sum of consecutive squares.

def palin?(n)
  n.to_s == n.to_s.reverse
end

def limited_palin_sum(n,limit)
  res = []
  i = 1
  sum = n**2
  while i <= n-1 do
    sum += (n-i)**2
    return res if sum >= limit
    res << sum if palin?(sum)
    i += 1
  end
  res
end

def generate_sum(limit)
  i = 1
  j = Math.sqrt(limit).to_i
  res = []
  while i < j do
    res |= limited_palin_sum(i,limit)
    i += 1
  end
  res.inject(0){|a,b|a+=b}
end

p generate_sum(1000)
p generate_sum(10**8)
