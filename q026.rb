#!/usr/bin/ruby

#A unit fraction contains 1 in the numerator. The decimal representation of the unit fractions with denominators 2 to 10 are given:
#
#    1/2	= 	0.5
#    1/3	= 	0.(3)
#    1/4	= 	0.25
#    1/5	= 	0.2
#    1/6	= 	0.1(6)
#    1/7	= 	0.(142857)
#    1/8	= 	0.125
#    1/9	= 	0.(1)
#    1/10	= 	0.1
#
#Where 0.1(6) means 0.166666..., and has a 1-digit recurring cycle. It can be seen that 1/7 has a 6-digit recurring cycle.
#
#Find the value of d < 1000 for which 1/d contains the longest recurring cycle in its decimal fraction part.

# have an idea, but details bothered me.
# in fact, I think I left a small non-strict problem here when it tests 1/1 to 1/10, which didn't affect the final result.

def div(d,int)
  return [d/int,d%int]
end
length=0
number=0
dd=[]
rr=[]

(2..1000).each do |n|
  rtmp = []
  dtmp = []
  d = 1
  res = div(d,n)
  while res[1] != 0 && rtmp.index(res[1]).nil?
    rtmp << res[1]
    tmp = res[1]
    res = div(tmp*10,n)
    while res[0] == 0
      tmp *= 10
      dtmp << 0
      res = div(tmp,n)
    end
    dtmp << res[0]
    if res[1] == 0
      #p "1/#{n} is finite"
      #p dtmp
      break
    end
    if rtmp.index(res[1])
      if length < rtmp.length - rtmp.index(res[1])
        length = rtmp.length - rtmp.index(res[1])
        number = n
        rr = rtmp
        dd = dtmp
      end
      break
    end
  end
end
p "from 1/1 to 1/1000, 1/#{number} has a #{length} recurring cycle, that is the longest."
