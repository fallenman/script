#!/usr/bin/ruby

#How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?

#use Date is quite... lazy.
require 'date'

a="1901-01-01"
sum=0
while Date.parse(a) < Date.parse("2000-12-31") do
  if Date.parse(a).wday == 0
    sum +=1
  end
  atmp=Date.parse(a).to_s.split('-')
  atmp[1] = atmp[1].to_i + 1
  if atmp[1] > 12
    atmp[1] = atmp[1].to_i - 12
    atmp[0] = atmp[0].to_i + 1
  end
  a=atmp.join('-')
end
p sum
