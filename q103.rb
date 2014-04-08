#!/usr/bin/env ruby

FI=(Math.sqrt(5)+1)/2
pro=1
@fib={}

@fib[1]=1
@fib[2]=1

def fibo(n)
  return @fib[n] if @fib[n]
  return (n%2 == 0 ? @fib[n] = fibo(n/2)*(fibo(n/2+1)+fibo(n/2-1)) : @fib[n] = fibo((n+1)/2)**2+fibo((n-1)/2)**2)
end

(3..10000).to_a.each do |i|
  @fib[i] = fibo(i)
end

def fib(n)
  fib_iter(1,0,0,1,n)
end

def fib_iter(a,b,p,q,count)
  return b if count == 0
  if count.even?
    fib_iter(a,b,p**2+q**2,q**2+2*p*q,count/2)
  else
    fib_iter(b*q+a*q+a*p,b*p+a*q,p,q,count-1)
  end
end

def pandi?(n)
  n.to_s.split('').sort.join('').to_i == 123456789 ? true : false
end

def test_both_pandi(a,n)
  if pandi?(a)
    tmp = fib(n)
    p @fib.length
    p n
    return [tmp,n] if pandi?(tmp.to_s[0,9])
  end
  return false
end

a=b=1
n=3
pro=(pro*FI).to_s[0,20].to_f
pro=(pro*FI).to_s[0,20].to_f
while true
  a=(a+b)%1000000000
  pro=(pro*FI).to_s[0,20].to_f
  if pandi?(a)
    p n
    p (pro/Math.sqrt(5)).to_s.sub('.','')[0,9].to_i
    exit if pandi?((pro/Math.sqrt(5)).to_s.sub('.','')[0,9].to_i)
  end
  b=(a+b)%1000000000
  pro=(pro*FI).to_s[0,20].to_f
  if pandi?(b)
    p n+1
    p (pro/Math.sqrt(5)).to_s.sub('.','')[0,9].to_i
    exit if pandi?((pro/Math.sqrt(5)).to_s.sub('.','')[0,9].to_i)
  end
  #if test = test_both_pandi(a,n) || test = test_both_pandi(b,n+1)
  #  p test[0].to_s.length, test[1]
  #  exit
  #end
  n += 2
end
