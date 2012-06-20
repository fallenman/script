#!/usr/bin/ruby

n = 2
m = 0
a=[]
a[0] = 1
a[1] = 1
while m != 1000 do
  a[n] = a[n-1] + a[n-2]
  m = a[n].to_s.length
  n += 1
end
p n
p a[n-1]
