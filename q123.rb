#Let pn be the nth prime: 2, 3, 5, 7, 11, ..., and let r be the remainder when (pn−1)n + (pn+1)n is divided by pn2.
#
#For example, when n = 3, p3 = 5, and 43 + 63 = 280 ≡ 5 mod 25.
#
#The least value of n for which the remainder first exceeds 109 is 7037.
#
#Find the least value of n for which the remainder first exceeds 1010.

primes = [2,3,5,7,11,13,17,19]
n = 21
i = 7

while i.odd? || 2*primes.last*(i+1) < 10**10 do
  j = 1
  res = 0
  while primes[j] <= Math.sqrt(n).to_i
    if n % primes[j] == 0
      res = 1
      break
    end
    j += 1
  end
  if res == 0
    primes << n
    i += 1
  end
  n += 2
end
p primes.last,i+1
