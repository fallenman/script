#!/usr/bin/ruby

#How many distinct ways can a player checkout with a score less than 100 in a dart game?

#not a difficult problem, yet the code is ugly.

finish_range=ARGV[0].to_i
S=(1..20).to_a<<25
D=S.map{|x|x*2}
T=S.map{|x|x*3}
T.delete_at(-1)

finish_hash={}

(2..finish_range).each do |s|
  if s > T.max+T.max+D.max
    p s
    break
  end
  finish_hash[s]={}
  #at first, pretend that all doubles less than s could finish s
  finish_hash[s][1]=D.select{|x|x<=s}.map{|x|[:D,x]}
  finish_hash[s][2]=[]
  #in a "two shot finish" situation, no possibility for repeat/equal situation.
  finish_hash[s][1].each do |f|
    e=f[-1]
    if s - e > 0
      finish_hash[s][2]<<[[:S,s-e],f] if S.include?(s-e)
      finish_hash[s][2]<<[[:D,s-e],f] if D.include?(s-e)
      finish_hash[s][2]<<[[:T,s-e],f] if T.include?(s-e)
    end
  end
  finish_hash[s][3]=[]
  finish_hash[s][1].each do |f|
    e=f[-1]
    g=(s-e)/2
    if g > 0
      (1..g).each do |t|
	#since s-e is divided by 2, the only possiblity for equal situation is when t==s-e-t and their type is different
	#for example, when s=6, the equal situation is [[[:D,2],[:S,2],[:D,2]],[[:S,2],[:D,2],[:D,2]]]
	finish_hash[s][3]<<[[:S,t],[:S,s-e-t],f] if S.include?(t) && S.include?(s-e-t)
	finish_hash[s][3]<<[[:D,t],[:S,s-e-t],f] if D.include?(t) && S.include?(s-e-t)
	finish_hash[s][3]<<[[:T,t],[:S,s-e-t],f] if T.include?(t) && S.include?(s-e-t)
	finish_hash[s][3]<<[[:S,t],[:D,s-e-t],f] if S.include?(t) && D.include?(s-e-t) && (t!=s-e-t)
	finish_hash[s][3]<<[[:D,t],[:D,s-e-t],f] if D.include?(t) && D.include?(s-e-t)
	finish_hash[s][3]<<[[:T,t],[:D,s-e-t],f] if T.include?(t) && D.include?(s-e-t)
	finish_hash[s][3]<<[[:S,t],[:T,s-e-t],f] if S.include?(t) && T.include?(s-e-t) && (t!=s-e-t)
	finish_hash[s][3]<<[[:D,t],[:T,s-e-t],f] if D.include?(t) && T.include?(s-e-t) && (t!=s-e-t)
	finish_hash[s][3]<<[[:T,t],[:T,s-e-t],f] if T.include?(t) && T.include?(s-e-t)
      end
    end
  end
  D.include?(s) ? finish_hash[s][1]=[[:D,s]] : finish_hash[s][1]=[]
end
p finish_hash[finish_range]
#p finish_hash[finish_range].values.inject(0){|a,b|a+=b.length}
p finish_hash.values.inject(0){|a,b|a+=b.values.inject(0){|c,d|c+=d.length}}
