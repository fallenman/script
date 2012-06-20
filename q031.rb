#!/usr/bin/ruby

#In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:
#
#    1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
#
#It is possible to make £2 in the following way:
#
#    1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
#
#How many different ways can £2 be made using any number of coins?

a=[100,50,20,10,5,2,1]
@sum=0
@all=[]

#it's something like indeterminate equation question, i will try to solve it in a recursive way.
#at the very first time, I ran into a totally wrong direction, complex it by myself...
#it's just simply brute force... recursively remove the elements one by one, just try (0..remainder/element).times for each element

#def get_combine(list,n)
#  list.combination(n).to_a
#end

def recursive(list,remainder)
  if list.length == 1
    if remainder%list.first == 0
      @sum += 1
      #p "success once"
      #p "#{remainder} is divisible by #{list.first}"
    else
      #p "fail once"
      #p "#{remainder} is not divisible by #{list.first}"
    end
  else
    element = list.first
    list -= [element]
    ((remainder/element)+1).times.each do |n|
      recursive(list,remainder-n*element)
    end
  end
end

recursive(a,200)
p @sum+1
