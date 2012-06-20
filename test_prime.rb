#!/usr/bin/ruby

class Integer
  def prime?
    test_num = self.abs
    if test_num >= 9
      dd = Math.sqrt(test_num).to_i
      (3..dd).step(2).each do |div|
	if test_num%div == 0
	  return false
	end
      end
    end
    return true if test_num == 2
    return false if test_num%2 == 0
    return false if test_num == 1
    return true
  end
end
