#!/usr/bin/ruby

#By replacing each of the letters in the word CARE with 1, 2, 9, and 6 respectively, we form a square number: 1296 = 362. What is remarkable is that, by using the same digital substitutions, the anagram, RACE, also forms a square number: 9216 = 962. We shall call CARE (and RACE) a square anagram word pair and specify further that leading zeroes are not permitted, neither may a different letter have the same digital value as another letter.
#
#Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, find all the square anagram word pairs (a palindromic word is NOT considered to be an anagram of itself).
#
#What is the largest square number formed by any member of such a pair?
#
#NOTE: All anagrams formed must be contained in the given text file.

#i got the idea almost in the first ten minutes....
#this is not difficult, but i don't believe that the result is such a small number and try to find out what's wrong and make the code more and more ugly.............waste almost 5 days on this....
#main idea: sort each word, find those same words and make them a group, and check the square number in each group, the lower bound and the upper bound clearly depends on the length of any single word in the group. use a tmp_hash to restore a mapping between character and digit, and set the rules such as no leading zeros.
#still a small problem in coding. i didn't make it a group but a pair. it's wrong.
words=[]
pairs=[]
File.open('words98.txt','r') do |f|
  f.gets.split(",").each do |w|
    words << w.gsub('"','').split('')
  end
end
sorted_words=words.map(&:sort)
sorted_words.uniq.each do |s|
  if sorted_words.grep(s).length > 1
    pairs << words.select{|w| w.sort == s}
  end
end
words_hash={}
words.each do |w|
  words_hash[w.length].nil? ? words_hash[w.length]=[w] : words_hash[w.length] << w
end
words_hash.keys.sort.reverse.each do |k|
  tmp_words=words_hash[k]
  tmp_sorted=tmp_words.map(&:sort)
  if tmp_words.length > tmp_sorted.uniq.length
    tmp_sorted.each do |t|
      if tmp_sorted.grep(t).length > 1
	anagrams = tmp_words.select{|x|x.sort==t}
        up_limit,down_limit=Math.sqrt(10**k).to_i-1,Math.sqrt(10**(k-1)).to_i+1
	(down_limit..up_limit).each do |n|
	  s=(n**2).to_s.split('')
	  next if (s.length - s.uniq.length) != (anagrams[0].length - anagrams[0].uniq.length)
	  tmp_hash={}
	  test = 0
	  anagrams[0].each_with_index do |an,i|
	    if (tmp_hash[an] && tmp_hash[an] != s[i]) || (tmp_hash.values.include?(s[i]) && tmp_hash.index(s[i]) && tmp_hash[s[i]] != an)
	      test = 1
	      break
	    else
	      tmp_hash[an] ||= s[i]
	    end
	  end
	  next if test == 1
	  if Math.sqrt(anagrams[1].map{|x|tmp_hash[x]}.join('').to_i)%1==0 && tmp_hash[anagrams[1].first].to_i != 0
	    p anagrams[1].map{|x|tmp_hash[x]}.join('').to_i,s.to_s.to_i,anagrams
	    exit
	  end
	end
      end
    end
  end
end
