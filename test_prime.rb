#!/usr/bin/ruby

class Integer
  def prime?
    return true if self == 2
    return false if self%2 == 0 || self < 2
    dd = Math.sqrt(self).to_i
    (3..dd).step(2).each do |div|
      if self%div == 0
	return false
      end
    end
    return true
  end
end
