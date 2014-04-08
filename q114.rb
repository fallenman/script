res={}
min=ARGV[0].to_i
limit=ARGV[1].to_i
#res[3]={"3+0"=>1,0=>1,:complex=>0}
#res[4]={"3+1"=>2,"4+0"=>1,0=>1,:complex=>0}
#res[5]={"3+2"=>3,"4+1"=>2,"5+0"=>1,0=>1,:complex=>0}
#res[6]={"3+3"=>4,"4+2"=>3,"5+1"=>2,"6+0"=>1,0=>1,:complex=>0}
#res[7]={"3+4"=>5,"4+3"=>4,"5+2"=>3,"6+1"=>2,"7+0"=>1,"3+1+3"=>res[7-3]["3+1"]-1,0=>1}
#res[7]["3+4"]=res[6]["3+3"]+1+res[4]["3+1"]-1
#res[8]={"3+5"=>6,"4+4"=>5,"5+3"=>4,"6+2"=>3,"8+0"=>1,"3+1+4"=>res[8-3]["4+1"]-1,"3+2+3"=>res[8-3]["3+2"]-1,"4+1+3"=>res[8-4]["3+1"]-1,0=>1}
#res[9]={"3+6"=>res[8]["3+5"]+1+res[9-3]["3+3"]-1+res[9-3]["4+2"]-1+res[9-3]["5+1"]-1
#res[1]={:simple=>1,:complex=>0}
#res[2]={:simple=>1,:complex=>0}
#res[3]={:simple=>2,:complex=>0}
#res[4]={:simple=>4,:complex=>0}
#res[5]={:simple=>7,:complex=>0}
#res[6]={:simple=>11,:complex=>0}
#initialize
(0..min-1).each do |i|
  res[i]=1
end
res[min]=2
#res[4]=4
#res[5]=7
#res[6]=11
(min+1..limit).each do |n|
  #start with black
  res[n]=res[n-1]
  #start with red(n) where n >= 3
  (0..n-min-1).each do |i|
    res[n]+=res[n-min-1-i]
  end
  #all red
  res[n]+=1
  #(3..n-1).each do |i|
  #  res[n]["#{i}+#{n-i}"]=res[n-1]["#{i}+#{n-i-1}"]+1
  #end
  #res[n][:simple]=res[n-1][:simple]+n-2
  #(n-6).times do |j|
  #  res[n][:complex]+=(res[n-4-j].values.inject(0){|a,b|a+=b}-1)*2
  #end
  #1.times do |k|
  #  res[n][:complex]-=res[n-4].values.inject(0){|a,b|a+=b}-1
  #end
  # this is for q115. comment out this for q114
  if res[n] > 1000000
    p n
    exit
  end
end
p res
p res[limit]
