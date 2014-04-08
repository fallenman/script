
digits=ARGV[0].to_i
res={}
res[1]={}
(1..9).to_a.each do |i|
  res[1][i]={0=>1,1=>0,-1=>0,:b=>0}
end
res[1][:b]=0
res[1][:all]=9
n=1
while n < digits do
  n+=1
  res[n]={}
  #for n-1 digits, it's a little complicated
  (1..9).each do |i|
    res[n][i]={}
    res[n][i][0]=res[n-1][i][0]
    res[n][i][:b]=res[n-1][i][:b]
    #1 for all zero
    res[n][i][-1]=1+res[n-1][i][-1]
    (1..i-1).each do |j|
      res[n][i][-1]+=res[n-1][j][-1]+res[n-1][j][0]
      res[n][i][:b]+=res[n-1][j][:b]+res[n-1][j][1]
    end
    res[n][i][1]=res[n-1][i][1]
    (i+1..9).each do |j|
      res[n][i][1]+=res[n-1][j][1]+res[n-1][j][0]
      res[n][i][:b]+=res[n-1][j][:b]+res[n-1][j][-1]
    end
    #any number start with "n0" but has at least one non-zero digit in the rest must be bouncing
    unless res[n-2].nil?
      res[n][i][:b]+=res[n-2][:all]
    end
  end
  res[n][:b]=0
  (1..9).each do |i|
    res[n][:b]+=res[n][i][:b]
  end
  res[n][:b]+=res[n-1][:b]
  res[n][:all]=10**n-1
end
p res[n][:b]
p res[n][:all]
p res[n][:all]-res[n][:b]
res[n].keys.reject{|x|x.class!=Fixnum}.sort.each do |i|
  p res[n][i]
end
