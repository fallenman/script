#!/usr/bin/ruby

#Consider quadratic Diophantine equations of the form:
#
#x**2 – D*y**2 = 1
#
#For example, when D=13, the minimal solution in x is 649*2 – 13*180**2 = 1.
#
#It can be assumed that there are no solutions in positive integers when D is square.
#
#By finding minimal solutions in x for D = {2, 3, 5, 6, 7}, we obtain the following:
#
#3**2 – 2*2**2 = 1
#2**2 – 3*1**2 = 1
#9**2 – 5*4**2 = 1
#5**2 – 6*2**2 = 1
#8**2 – 7*3**2 = 1
#
#Hence, by considering minimal solutions in x for D  7, the largest x is obtained when D=5.
#
#Find the value of D <= 1000 in minimal solutions of x for which the largest value of x is obtained.

# !!! this is totaly math !!! i had to wiki to get information about this famous Pell's equation. the positive integer solution has something to do with continued fraction of sqrt(D) !!! this question almost can not be solved by brute force directly (perhaps someday, 16421658242965910275055840472270471049 is not diffcult for brute force?) . in fact, i should start wiki when i first encounter 61, for it is such a small one and get such a large solution.
# using the theory, it is just 0.2 seconds computing.
# what a lesson !

# after learning the basic knowledge of this math theory, there are 2 labor steps left: generate the continued fraction circle of the square root excluding those square numbers, then compute the convergent and see if the convergent is the solution. finally get the largest one and its order, which is the D number.
# by the way, those who get the solution without help, should not do coding, but math... again, i proved how stupid i am...
# in fact, the first method is unnecessary. we can get each an in the iterator. but no energy to refactor...
def fraction(hash,n)
  result = {}
  result[:n] = (n - hash[:minus]**2)/hash[:n]
  result[:i] = (Math.sqrt(n).to_i + hash[:minus])/result[:n]
  result[:minus] = result[:i]*result[:n]-hash[:minus]
  result
end

def convergent(h,k,an)
  tmp = [an*h[0]+h[1],an*k[0]+k[1]]
  [[tmp[0],h[0]],[tmp[1],k[0]]]
end

square_hash={}
(1..35).each {|x| square_hash[x**2] = x }
result,order = 0,0
(2..1000).each do |n|
  next if square_hash.has_key?(n)
  a0 = Math.sqrt(n).to_i
  fir = fraction({:n=>1,:minus=>a0},n)
  array = []
  fir=fraction({:n=>1,:minus=>a0},n)
  while !array.include?(fir)
    array << fir
    fir=fraction(fir,n)
  end
  ring = array.collect {|x|x[:i]}
  number = convergent([1,0],[0,1],a0)
  m = 0
  while number[0][0]**2 - n*number[1][0]**2 != 1
    number = convergent(number[0],number[1],ring[m%ring.length])
    m += 1
  end
  p [number[0][0],n,number[1][0]]
  result,order = number[0][0],n if result < number[0][0]
end
p result,order
exit
result = [0,0,0]
square_hash = {}
candidate = []
p 1
(1..1000).each do |n|
  test = 0
  (1..10000).each do |m|
    if square_hash.has_key?(n*m**2+1) || Math.sqrt(n*m**2+1)%1 == 0
      result = [Math.sqrt(n*m**2+1),n,m] if result[0] < Math.sqrt(n*m**2+1)
      p [Math.sqrt(n*m**2+1),n,m]
      test = 1
      break
    end
  end
  candidate << n if test == 0
end
p candidate
candidate.each do |n|
  (10001..10000000).each do |m|
    #if square_hash.has_key?(n*m**2+1) || Math.sqrt(n*m**2+1)%1 == 0
    if Math.sqrt(n*m**2+1)%1 == 0
      result = [Math.sqrt(n*m**2+1),n,m] if result[0] < Math.sqrt(n*m**2+1)
      p [Math.sqrt(n*m**2+1),n,m]
      test = 1
      candidate -= [n]
      break
    end
  end
end
p candidate
