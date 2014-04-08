res={}
min=[2,3,4]
limit=ARGV[0].to_i
res[0]=1
res[1]=1
res[2]=2
res[3]=4
res[4]=res[0]+res[1]+res[2]+res[3]
(5..limit).each do |n|
  res[n]=res[n-4]+res[n-3]+res[n-2]+res[n-1]
end
p res
p res[limit]
