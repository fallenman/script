#A bag contains one red disc and one blue disc. In a game of chance a player takes a disc at random and its colour is noted. After each turn the disc is returned to the bag, an extra red disc is added, and another disc is taken at random.
#
#The player pays £1 to play and wins if they have taken more blue discs than red discs at the end of the game.
#
#If the game is played for four turns, the probability of a player winning is exactly 11/120, and so the maximum prize fund the banker should allocate for winning in this game would be £10 before they would expect to incur a loss. Note that any payout will be a whole number of pounds and also includes the original £1 paid to play the game, so in the example given the player actually wins £9.
#
#Find the maximum prize fund that should be allocated to a single game in which fifteen turns are played.

#quick and dirty
require 'mathn'

@r = 15

def base(a)
  3+@r-a
end

#[blue, red]
res = { [0,1] => 1/2, [1,0] => 1/2 }
def recursive(h,n)
  if n == 1
    h
  else
    tmp = {}
    h.keys.each do |k|
      if tmp[[k[0]+1,k[1]]]
	tmp[[k[0]+1,k[1]]] += h[k]/base(n)
      else
	tmp[[k[0]+1,k[1]]] = h[k]/base(n)
      end
      if tmp[[k[0],k[1]+1]]
	tmp[[k[0],k[1]+1]] += h[k]*(1-1/base(n))
      else
	tmp[[k[0],k[1]+1]] = h[k]*(1-1/base(n))
      end
    end
    recursive(tmp,n-1)
  end
end
p (1/(recursive(res,@r).select{|x,y|x[0]>x[1]}.values.inject(0){|a,b|a+=b})).to_i
