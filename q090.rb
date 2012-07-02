#!/usr/bin/ruby

#Each of the six faces on a cube has a different digit (0 to 9) written on it; the same is done to a second cube. By placing the two cubes side-by-side in different positions we can form a variety of 2-digit numbers.
#
#In fact, by carefully choosing the digits on both cubes it is possible to display all of the square numbers below one-hundred: 01, 04, 09, 16, 25, 36, 49, 64, and 81.
#
#For example, one way this can be achieved is by placing {0, 5, 6, 7, 8, 9} on one cube and {1, 2, 3, 4, 8, 9} on the other cube.
#
#However, for this problem we shall allow the 6 or 9 to be turned upside-down so that an arrangement like {0, 5, 6, 7, 8, 9} and {1, 2, 3, 4, 6, 7} allows for all nine square numbers to be displayed; otherwise it would be impossible to obtain 09.
#
#In determining a distinct arrangement we are interested in the digits on each cube, not the order.
#
#{1, 2, 3, 4, 5, 6} is equivalent to {3, 6, 4, 1, 2, 5}
#{1, 2, 3, 4, 5, 6} is distinct from {1, 2, 3, 4, 5, 9}
#
#But because we are allowing 6 and 9 to be reversed, the two distinct sets in the last example both represent the extended set {1, 2, 3, 4, 5, 6, 9} for the purpose of forming 2-digit numbers.
#
#How many distinct arrangements of the two cubes allow for all of the square numbers to be displayed?

#not that difficult yet made too many similar mistakes on coding!!!
a=(0..9).to_a
S=(1..9).to_a.map {|n| n**2}
res=[]
a.combination(6).to_a.each do |aa|
  a.combination(6).to_a.each do |bb|
    test = 0
    S.each do |s|
      if (s/10 == 6 || s/10 == 9)
	test = 1 unless ((aa.include?(6)||aa.include?(9)) && bb.include?(s%10)) || ((bb.include?(6)||bb.include?(9)) && aa.include?(s%10))
      elsif (s%10 == 6 || s%10 == 9)
	test = 1 unless ((aa.include?(6)||aa.include?(9)) && bb.include?(s/10)) || ((bb.include?(6)||bb.include?(9)) && aa.include?(s/10))
      else
	test = 1 unless (aa.include?(s/10) && bb.include?(s%10)) || (bb.include?(s/10) && aa.include?(s%10))
      end
    end
    if test == 0
      res << [aa.sort,bb.sort].sort
    end
  end
end
p res.uniq.length
