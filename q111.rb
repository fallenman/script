
tails=[1,3,7,9]
evens=[2,4,6,8]
digits=(0..9).to_a
len=ARGV[0].to_i

def prime?(n)
  return false if n < 2
  return true if n == 2
  return false if n.even?
  (3..Math.sqrt(n).to_i).step(2).each do |i|
    return false if n%i==0
  end
  return true
end

def rotate(a)
  return a[1,a.length-1]+[a[0]]
end

#def gen_permutations(d,n,e,m)
#  if m == 1
#    tmp=[]
#    n.times do |i|
#      tmp<<d
#    end
#    return add_one_digit_to_array(tmp,e)
#  else
#    tmp=gen_permutations(d,n,e,m-1)
#    res=[]
#    tmp.each do |t|
#      res|=add_one_digit_to_array(t,e)
#    end
#    tmp.each do |t|
#      t<<e
#      res<<t
#      tmp[0].length.times do |i|
#        res<<rotate(res[-1])
#      end
#    end
#    res
#  end
#end

#far from optimize, but fast enough for 10 digits
def add_one_digit_to_array(a,n)
  res=[]
  res<<a+[n]
  a.length.times do |i|
    res << rotate(res[-1])
  end
  res
end

def add_one_digit_to_permutation(p,n)
  p.inject([]){|x,y|x+=add_one_digit_to_array(y,n)}.uniq
end

def add_array_to_permutation(p,a)
  res=[]
  a.each do |i|
    res+=add_one_digit_to_permutation(p,i)
  end
  res.uniq
end

def gen_array(d,n)
  a=[]
  n.times do |i|
    a<<d
  end
  a
end

sum=0
digits.each do |d|
  tmp_len=len-1
  primes=[]
  while primes.length==0 && tmp_len > 0 do
    tmp=[gen_array(d,tmp_len)]
    pos=[]
    (len-tmp_len).times do |i|
      pos=add_array_to_permutation(tmp,digits)
      tmp=pos
    end
    primes=pos.reject{|x|x[0]==0||!tails.include?(x[-1])}.map{|x|x.join('').to_i}.select{|x|prime?(x)}
    tmp_len-=1
  end
  sum+=primes.inject(0){|x,y|x+=y}
end
p sum
