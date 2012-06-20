#!/usr/bin/ruby

#The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.
#
#We shall consider fractions like, 30/50 = 3/5, to be trivial examples.
#
#There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.
#
#If the product of these four fractions is given in its lowest common terms, find the value of the denominator.

#have problems on coding, i mean, it's too ugly.


a=(1..9).to_a

def find_curious_fraction(a=[1,2,3])
  list = []
  tmp_a = a.combination(2).to_a
  while tmp_a.length > 1
    element = tmp_a[0]
    tmp_a -= [element]
    tmp_a.each do |ta|
      common_num = element & ta
      tmp_b = [element,element.reverse,ta,ta.reverse].sort
      while tmp_b.length > 1
	b = tmp_b[0]
	tmp_b -= [b]
	tmp_b.each do |tb|
	  next if tb.sort == b.sort
	  list << "#{b}/#{tb}" if (tb.to_s.to_f)/(b.to_s.to_f) == ((tb-common_num).to_s.to_f)/((b-common_num).to_s.to_f)
	  #p "#{tb},#{b}" if (b.to_s.to_i)%((b-common_num).to_s.to_i) == 0 && (tb.to_s.to_i)%((tb-common_num).to_s.to_i) == 0 && (b.to_s.to_i)/((b-common_num).to_s.to_i) == (tb.to_s.to_i)/((tb-common_num).to_s.to_i)
	end
      end
    end
  end
  list
end

result = []
a.combination(3).to_a.each do |ta|
  result += find_curious_fraction(ta)
end
p result
