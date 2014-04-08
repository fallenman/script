res={}
min=ARGV[0].to_i
limit=ARGV[1].to_i
(0..min-1).each do |i|
  res[i]=0
end
res[min]=1
(min+1..limit).each do |n|
  res[n]=res[n-1]
  (0..n-min-1).step(min).each do |i|
    res[n]+=res[n-min-1-i]+1
  end
  res[n]+=1 if n%min==0
end
p res
p res[limit]
