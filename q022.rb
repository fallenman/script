#!/usr/bin/ruby

#Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
#
#For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
#
#What is the total of all the name scores in the file?

# hum... use each_byte


sum = 0
a = File.read('names.txt').split(',').sort
a.each do |c|
  b = c.split('"')[1]
  tmpsum = 0
  b.each_byte do |d|
    tmpsum += (d-64)
  end
  sum += (tmpsum*(a.index(c)+1))
end
p sum
