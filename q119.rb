#!/usr/bin/env ruby

#The number 512 is interesting because it is equal to the sum of its digits raised to some power: 5 + 1 + 2 = 8, and 8**3 = 512. Another example of a number with this property is 614656 = 28**4.
#
#We shall define an to be the nth term of this sequence and insist that a number must contain at least two digits to have a sum.
#
#You are given that a2 = 512 and a10 = 614656.
#
#Find a30.

# two tricks: search along power numbers and use a proper digits sum limit
def digits_sum(n)
  n.to_s.split('').inject(0){|a,b|a+=b.to_i}
end

def next_power_hash(last_hash)
  last_hash[2] = last_hash[2]*2
  n = 3
  while !last_hash[n].nil?
    if last_hash[n]*n <= last_hash[2]
      last_hash[n]=last_hash[n]*n
    end
    if !last_hash[:res].include?(last_hash[n]) && n == digits_sum(last_hash[n])
      last_hash[:res] << last_hash[n]
    end
    n+=1
  end
  # assume the result will not exceed 1000 digits
  while n < 1000 && n**2 <= last_hash[2]
    last_hash[n]=n**2
    n+=1
  end
  last_hash
end

power_hash={2=>16,3=>27,:res=>[]}
while power_hash[:res].length < 30 do
  power_hash=next_power_hash(power_hash)
  p power_hash[:res]
end
