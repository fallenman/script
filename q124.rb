#The radical of n, rad(n), is the product of the distinct prime factors of n. For example, 504 = 23 × 32 × 7, so rad(504) = 2 × 3 × 7 = 42.
#
#If we calculate rad(n) for 1 ≤ n ≤ 10, then sort them on rad(n), and sorting on n if the radical values are equal, we get:
#
#	Unsorted		Sorted
#	n	rad(n)		n	rad(n)	k
#	1	1		1	1	1
#	2	2		2	2	2
#	3	3		4	2	3
#	4	4		8	2	4
#	5	5		3	3	5
#	6	6		9	3	6
#	7	7		5	5	7
#	8	2		6	6	8
#	9	3		7	7	9
#	10	10		10	10	10
#
#Let E(k) be the kth element in the sorted n column; for example, E(4) = 8 and E(6) = 9.
#
#If rad(n) is sorted for 1 ≤ n ≤ 100000, find E(10000).

def generate_primes(n)
  primes = [2]
  (3..n).step(2).each do |i|
    res = 0
    primes.each do |pri|
      if i % pri == 0
	res = 1
	break
      end
    end
    primes << i if res == 0
  end
  primes
end

def distinct_factors(n,res,primes)
  tmp = 0
  limit = Math.sqrt(n)
  primes.each do |pri|
    break if pri > limit
    if n % pri == 0
      tmp = 1
      n /= pri
      res |= [pri]
    end
  end
  if tmp == 0
    res |= [n]
  else
    distinct_factors(n,res,primes)
  end
end

def rad(n)
  res = { 1 => [1], 2 => [2] }
  primes = generate_primes(Math.sqrt(n).to_i)
  (3..n).each do |m|
    tmp = distinct_factors(m,[],primes).inject(1){|a,b|a*=b}
    res.key?(tmp) ? res[tmp] << m : res[tmp] = [m]
  end
  res
end

LIMIT = 100000
POS = 10000
res = rad(LIMIT)
sum = 0
res.keys.sort.each do |k|
  if sum + res[k].length >= POS
    p res[k][POS-sum-1]
    exit
  else
    sum += res[k].length
  end
end
