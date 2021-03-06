#!/usr/bin/ruby

#If we are presented with the first k terms of a sequence it is impossible to say with certainty the value of the next term, as there are infinitely many polynomial functions that can model the sequence.
#
#As an example, let us consider the sequence of cube numbers. This is defined by the generating function,
#un = n3: 1, 8, 27, 64, 125, 216, ...
#
#Suppose we were only given the first two terms of this sequence. Working on the principle that "simple is best" we should assume a linear relationship and predict the next term to be 15 (common difference 7). Even if we were presented with the first three terms, by the same principle of simplicity, a quadratic relationship should be assumed.
#
#We shall define OP(k, n) to be the nth term of the optimum polynomial generating function for the first k terms of a sequence. It should be clear that OP(k, n) will accurately generate the terms of the sequence for n ≤ k, and potentially the first incorrect term (FIT) will be OP(k, k+1); in which case we shall call it a bad OP (BOP).
#
#As a basis, if we were only given the first term of sequence, it would be most sensible to assume constancy; that is, for n ≥ 2, OP(1, n) = u1.
#
#Hence we obtain the following OPs for the cubic sequence:
#OP(1, n) = 1 	1, 1, 1, 1, ...
#OP(2, n) = 7n−6 	1, 8, 15, ...
#OP(3, n) = 6n2−11n+6      	1, 8, 27, 58, ...
#OP(4, n) = n3 	1, 8, 27, 64, 125, ...
#
#Clearly no BOPs exist for k ≥ 4.
#
#By considering the sum of FITs generated by the BOPs (indicated in red above), we obtain 1 + 15 + 58 = 74.
#
#Consider the following tenth degree polynomial generating function:
#
#un = 1 − n + n2 − n3 + n4 − n5 + n6 − n7 + n8 − n9 + n10
#
#Find the sum of FITs for the BOPs.
#

require 'mathn'
def erow(ay,az,mo)
  #eliminate a non-zero element in az
  az.each_with_index.map{|a,i|a-ay[i]*mo}
end

def eliminate(array)
  (array.length-1).times do |n|
    #take the nth row as a basic row
    basic = array[n]
    #eliminate the nth element in the rows below the basic row
    (array.length-1-n).times do |k|
      #compute the proper mo for erow function
      mo = array[n+k+1][n]/basic[n]
      array[n+k+1] = erow(basic,array[n+k+1],mo)
    end
  end
  array
end

def resolve_row(row,res)
  #resolve a row using a proper existing resolution which makes this row a linear equation
  new_ele = (row[-1]-res.reverse.each_with_index.map{|x,i|row[-2-i]*x}.inject(0){|a,b|a+=b})
  new_ele /= row[-2-res.length]
  [new_ele]+res
end

def resolve_matrix(array)
  res = []
  array = eliminate(array)
  #resolve a matrix that is already been eliminated
  array.reverse_each do |a|
    #resolve each row in a reverse order
    res = resolve_row(a,res)
  end
  res
end

def formulate(m)
  res = 0
  11.times do |j|
    res += (-1)**j*m**j
  end
  res
end

def build_matrix(array)
  matrix = []
  array.length.times do |n|
    matrix << array.length.times.map{|x|(n+1)**x}+[array[n]]
  end
  matrix
end

@queue=[]
@res=0
(1..10).each do |k|
  #@queue << k**3
  @queue << formulate(k)
  eq = build_matrix(@queue)
  y = resolve_matrix(eq)
  @res += y.each_with_index.map{|x,i|x*(@queue.length+1)**i}.inject(0){|c,d|c+=d}
end
p @res
