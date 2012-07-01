#!/usr/bin/ruby

#The rules for writing Roman numerals allow for many ways of writing each number (see About Roman Numerals...). However, there is always a "best" way of writing a particular number.
#
#For example, the following represent all of the legitimate ways of writing the number sixteen:
#
#IIIIIIIIIIIIIIII
#VIIIIIIIIIII
#VVIIIIII
#XIIIIII
#VVVI
#XVI
#
#The last example being considered the most efficient, as it uses the least number of numerals.
#
#The 11K text file, roman.txt (right click and 'Save Link/Target As...'), contains one thousand numbers written in valid, but not necessarily minimal, Roman numerals; that is, they are arranged in descending units and obey the subtractive pair rule (see About Roman Numerals... for the definitive rules for this problem).
#
#Find the number of characters saved by writing each of these in their minimal form.
#
#Note: You can assume that all the Roman numerals in the file contain no more than four consecutive identical units.

#How do you read and write Roman numerals?
#
#Traditional Roman numerals are made up of the following denominations:
#
#I = 1
#V = 5
#X = 10
#L = 50
#C = 100
#D = 500
#M = 1000
#
#You will read about many different rules concerning Roman numerals, but the truth is that the Romans only had one simple rule:
#
#Numerals must be arranged in descending order of size.
#
#For example, three ways that sixteen could be written are XVI, XIIIIII, VVVI; the first being the preferred form as it uses the least number of numerals.
#
#The "descending size" rule was introduced to allow the use of subtractive combinations. For example, four can be written IV because it is one before five. As the rule requires that the numerals be arranged in order of size it should be clear to a reader that the presence of a smaller numeral out of place, so to speak, was unambiguously to be subtracted from the following numeral. For example, nineteen could be written XIX = X + IX (9). Note also how the rule requires X (ten) be placed before IX (nine), and IXX would not be an acceptable configuration.
#
#Generally the Romans tried to use as few numerals as possible when displaying numbers. For this reason, XIX would be the preferred form of nineteen over other valid combinations, like XVIIII or XVIV. However, this was NOT a rule and there still remain in Rome many examples where economy of numerals has not been employed. For example, in the famous Colesseum the the numerals above the forty-ninth entrance is written XXXXVIIII and not IL nor XLIX (see rules below).
#
#Despite this, over time we have continued to introduce new restrictive rules. By mediaeval times it had become standard practice to avoid more than three consecutive identical numerals. That is, IV would be written instead of IIII, IX would be used instead of VIIII, and so on. In addition, the subtractive combinations had the following rules superimposed:
#
#Only I, X, and C can be used as the leading numeral in part of a subtractive pair.
#I can only be placed before V and X.
#X can only be placed before L and C.
#C can only be placed before D and M.
#These last four rules are considered to be law, and generally it is preferred, but not necessary, to display numbers using the minimum number of numerals. Which means that IL is considered an invalid way of writing forty-nine, and whereas XXXXVIIII, XXXXIX, XLVIIII, and XLIX are all quite legitimate, the latter is the preferred (minimal) form.
#
#It is also expected that higher denominations should be used whenever possible; for example, L should be used in place of XXXXX, or C should be used in place of LL. However, even this "rule" has been flaunted: in the church of Sant'Agnese fuori le Mura (St Agnes' outside the walls), found in Rome, the date, MCCCCCCVI (1606), is written on the gilded and coffered wooden ceiling; I am sure that many would argue that it should have been written MDCVI.
#
#However, if we believe the adage, "when in Rome do as the Romans do," and we see how the Romans write numerals, then it clearly gives us much more freedom than many would care to admit.


#i'm quite sure the convert function is correct but the answer i input is totally wrong. so i googled the answer, and slap my head: saved !!! it means subtractive !!!
#my poor English....
#the most interesting thing is, when i look at the posts in the forum, i found that the last post on page 1 is a Chinese and complaint the misunderstanding which is exactly the same to mine.

#well, code would be much clearer if we use regex. but i used a number way.
MAPS={1=>"I",5=>"V",10=>"X",50=>"L",100=>"C",500=>"D",1000=>"M"}
text=[]
File.new('roman.txt','r').readlines.each do |line|
  text << line.chomp.split(",").to_s
end
def r_to_n(r)
  sum = 0
  tmp = r.split('').map {|a| MAPS.index(a)}
  tmp.each_with_index do |c,i|
    if i == r.length - 1
      sum += c
    else
      c < tmp[i+1] ? sum -= c : sum += c
    end
  end
  sum
end
def write_r(n,m)
  tmp = (n/m)%10
  if tmp == 9
    MAPS[m]+MAPS[10*m]
  elsif tmp > 5
    MAPS[5*m]+MAPS[m]*(tmp-5)
  elsif tmp == 5
    MAPS[5*m]
  elsif tmp == 4
    MAPS[m]+MAPS[5*m]
  else
    MAPS[m]*tmp
  end
end
def n_to_r(n)
  roman = ""
  roman << "M"*(n/1000)
  roman << write_r(n,100)
  roman << write_r(n,10)
  roman << write_r(n,1)
  roman
end
min = 0
sum = 0
ori_sum = 0
right_sum = 0
RES={}
text.each do |t|
  right_sum += t.length if t == n_to_r(r_to_n(t))
  ori_sum += t.length
  sum += n_to_r(r_to_n(t)).length
end
p ori_sum-sum
