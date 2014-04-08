
def bouncy?(n)
  return false if n.to_s.length < 3
  sign=0
  (n.to_s.length-1).times do |i|
    if n.to_s[i+1] > n.to_s[i]
      sign < 0 ? (return true) : sign=1
    elsif n.to_s[i+1] < n.to_s[i]
      sign > 0 ? (return true) : sign=-1
    end
  end
  return false
end

bouncies=0
range=ARGV[0].to_f
n=2
while bouncies/(n-1).to_f < range/100.to_f do
  if bouncy?(n)
    bouncies+=1
  end
  n+=1
end
p bouncies,n-1,bouncies/(n-1).to_f
