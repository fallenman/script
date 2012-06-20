#!/usr/bin/ruby

#In the game, Monopoly, the standard board is set up in the following way:
#
#GO	A1	CC1	A2	T1	R1	B1	CH1	B2	B3	JAIL
#H2	 									C1
#T2	 									U1
#H1	 									C2
#CH3	 									C3
#R4	 									R2
#G3	 									D1
#CC3	 									CC2
#G2	 									D2
#G1	 									D3
#G2J	F3	U2	F2	F1	R3	E3	E2	CH2	E1	FP
#A player starts on the GO square and adds the scores on two 6-sided dice to determine the number of squares they advance in a clockwise direction. Without any further rules we would expect to visit each square with equal probability: 2.5%. However, landing on G2J (Go To Jail), CC (community chest), and CH (chance) changes this distribution.
#
#In addition to G2J, and one card from each of CC and CH, that orders the player to go directly to jail, if a player rolls three consecutive doubles, they do not advance the result of their 3rd roll. Instead they proceed directly to jail.
#
#At the beginning of the game, the CC and CH cards are shuffled. When a player lands on CC or CH they take a card from the top of the respective pile and, after following the instructions, it is returned to the bottom of the pile. There are sixteen cards in each pile, but for the purpose of this problem we are only concerned with cards that order a movement; any instruction not concerned with movement will be ignored and the player will remain on the CC/CH square.
#
#Community Chest (2/16 cards):
#Advance to GO
#Go to JAIL
#Chance (10/16 cards):
#Advance to GO
#Go to JAIL
#Go to C1
#Go to E3
#Go to H2
#Go to R1
#Go to next R (railway company)
#Go to next R
#Go to next U (utility company)
#Go back 3 squares.
#The heart of this problem concerns the likelihood of visiting a particular square. That is, the probability of finishing at that square after a roll. For this reason it should be clear that, with the exception of G2J for which the probability of finishing on it is zero, the CH squares will have the lowest probabilities, as 5/8 request a movement to another square, and it is the final square that the player finishes at on each roll that we are interested in. We shall make no distinction between "Just Visiting" and being sent to JAIL, and we shall also ignore the rule about requiring a double to "get out of jail", assuming that they pay to get out on their next turn.
#
#By starting at GO and numbering the squares sequentially from 00 to 39 we can concatenate these two-digit numbers to produce strings that correspond with sets of squares.
#
#Statistically it can be shown that the three most popular squares, in order, are JAIL (6.24%) = Square 10, E3 (3.18%) = Square 24, and GO (3.09%) = Square 00. So these three most popular squares can be listed with the six-digit modal string: 102400.
#
#If, instead of using two 6-sided dice, two 4-sided dice are used, find the six-digit modal string.
#

# i wonder if we can compute or analysis this by hand?
# something wrong with it, although the answer is roughly and coincidentally right. because i misunderstand the "concecutive doubles". i should not sort the array. because that the word "concecutive" means...
# now it's real.
dice=[1,2,3,4]
ditu=(0..39).to_a
result={}
ditu.map {|x| result[x]=0}
rolls=[1,1,1]
pos=0
@ch_pos=[7,22,36]
@cc_pos=[2,17,33]
# cards has an order. let's shuffle once at first
@ch_cards=([1]*6+[0,10,11,24,39,5,"r","r","u",-3]).shuffle
@cc_cards=([0,10]+[1]*14).shuffle
@u_pos=[12,28]
@r_pos=[5,15,25,35]
class Array
  def rotate
    tmp = self[0]
    self.shift
    self << tmp
  end
end
def compute(m)
  if @cc_pos.include?(m)
    move = @cc_cards[0]
    @cc_cards.rotate
    (move == 1 ? m : move)
  elsif @ch_pos.include?(m)
    chance = @ch_cards[0]
    @ch_cards.rotate
    if chance == 1
      m
    elsif chance == -3
      m-3
    elsif chance == "u"
      (m == 22 ? 28 : 12)
    elsif chance == "r"
      (m == 36 ? 5 : @r_pos[@ch_pos.index(m)+1])
    else
      chance
    end
  elsif m == 30
    10
  else
    m
  end
end
runs = 1000000
runs.times do |rrr|
  rolls.shift
  rolls << dice.shuffle.first+dice.shuffle.first
  sorted = rolls
  if sorted.first%2 == 0 && sorted[1]-sorted[0] == 2 && sorted[2]-sorted[1] == 2
    pos = 10
    result[pos] += 1
    #rolls = [1,1,1]
  else
    pos += rolls[-1]
    pos -= 40 if pos > 39
    while true
      tmp = pos
      pos = compute(pos)
      break if tmp == pos
    end
    result[pos] += 1
  end
end
p result.sort {|a,b| a[1]<=>b[1]}.reverse.map {|ccc| [ccc[0],ccc[1]/runs.to_f]}
