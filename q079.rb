#!/usr/bin/ruby

#A common security method used for online banking is to ask the user for three random characters from a passcode. For example, if the passcode was 531278, they may ask for the 2nd, 3rd, and 5th characters; the expected reply would be: 317.
#
#The text file, keylog.txt, contains fifty successful login attempts.
#
#Given that the three characters are always asked for in order, analyse the file so as to determine the shortest possible secret passcode of unknown length.

# i know many people would do it by hand, but i thought it would be faster to code... and maybe it's true..
# 
hash={}
File.new('keylog.txt','r').readlines.each do |line|
  array = line.chomp.split('')
  array.map {|n| hash[n] ||= 1}
  hash[array[1]] = hash[array[0]]+1 if hash[array[1]] <= hash[array[0]]
  hash[array[2]] = hash[array[1]]+1 if hash[array[2]] <= hash[array[1]] 
end
p hash.sort {|a,b| a[1]<=>b[1]}
p hash.sort {|a,b| a[1]<=>b[1]}.map {|c| c[0]}.join('')
