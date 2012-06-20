#!/usr/bin/ruby

#In the card game poker, a hand consists of five cards and are ranked, from lowest to highest, in the following way:
#
#High Card: Highest value card.
#One Pair: Two cards of the same value.
#Two Pairs: Two different pairs.
#Three of a Kind: Three cards of the same value.
#Straight: All cards are consecutive values.
#Flush: All cards of the same suit.
#Full House: Three of a kind and a pair.
#Four of a Kind: Four cards of the same value.
#Straight Flush: All cards are consecutive values of same suit.
#Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
#The cards are valued in the order:
#2, 3, 4, 5, 6, 7, 8, 9, 10, Jack, Queen, King, Ace.
#
#If two players have the same ranked hands then the rank made up of the highest value wins; for example, a pair of eights beats a pair of fives (see example 1 below). But if two ranks tie, for example, both players have a pair of queens, then highest cards in each hand are compared (see example 4 below); if the highest cards tie then the next highest cards are compared, and so on.
#
#Consider the following five hands dealt to two players:
#Hand	 	Player 1	 	Player 2	 	Winner
#1	 	5H 5C 6S 7S KD
#Pair of Fives
# 	2C 3S 8S 8D TD
# 	Pair of Eights
# 	 	Player 2
# 	 	2	 	5D 8C 9S JS AC
# 	 	Highest card Ace
# 	 	 	2C 5C 7D 8S QH
# 	 	 	Highest card Queen
# 	 	 	 	Player 1
# 	 	 	 	3	 	2D 9C AS AH AC
# 	 	 	 	Three Aces
# 	 	 	 	 	3D 6D 7D TD QD
# 	 	 	 	 	Flush with Diamonds
# 	 	 	 	 	 	Player 2
# 	 	 	 	 	 	4	 	4D 6S 9H QH QC
# 	 	 	 	 	 	Pair of Queens
# 	 	 	 	 	 	Highest card Nine
# 	 	 	 	 	 	 	3D 6D 7H QD QS
# 	 	 	 	 	 	 	Pair of Queens
# 	 	 	 	 	 	 	Highest card Seven
# 	 	 	 	 	 	 	 	Player 1
# 	 	 	 	 	 	 	 	5	 	2H 2D 4C 4D 4S
# 	 	 	 	 	 	 	 	Full House
# 	 	 	 	 	 	 	 	With Three Fours
# 	 	 	 	 	 	 	 	 	3C 3D 3S 9S 9D
# 	 	 	 	 	 	 	 	 	Full House
# 	 	 	 	 	 	 	 	 	with Three Threes
# 	 	 	 	 	 	 	 	 	 	Player 1
#
#The file, poker.txt, contains one-thousand random hands dealt to two players. Each line of the file contains ten cards (separated by a single space): the first five are Player 1's cards and the last five are Player 2's cards. You can assume that all hands are valid (no invalid characters or repeated cards), each player's hand is in no specific order, and in each hand there is a clear winner.
#
#How many hands does Player 1 win?

# too long subject, and also will got a long algorithm.
# although the result is right, the code is too dirty. i'm such a stupid person. i should think about it these days.
# the main idea here is not bad, i think. most of the dirty part is coding experience, mainly on how to compare one pair and two pairs condition when the pair part equal. should find a way to simplify the method, because now it's unreadable.
NUMBER_ORDER = ["2","3","4","5","6","7","8","9","T","J","Q","K","A"]
COLOR_ORDER = ["D","C","H","S"]
class Poker
  attr_accessor :cards,:poker
  def initialize(poker)
    tmp = []
    poker.each do |card|
      tmp << Card.new(card)
    end
    @poker=poker
    @cards = tmp
  end

  def count_repeat(n)
    self.get_type("number").uniq.each {|x| return true if self.get_type("number").grep(x).length == n }
    return false
  end

  def find_repeat(n)
    tmp = []
    self.get_type("number").uniq.each {|x| tmp << x if self.get_type("number").grep(x).length == n }
    tmp
  end

  def has_one_pair?
    return true if self.count_repeat(2) 
    return false
  end

  def has_three_element?
    return true if self.get_type("number").uniq.length == 3
    return false
  end

  def is_three?
    return true if self.count_repeat(3)
    return false
  end

  def is_straight?
    return true if self.get_type("number").sort[-1] - self.get_type("number").sort[0] == 4
    return false
  end

  def is_flush?
    return true if self.get_type("color").uniq.length == 1
    return false
  end

  def is_full_house?
    return true if self.count_repeat(3) && self.count_repeat(2)
    return false
  end

  def is_four?
    return true if self.count_repeat(4)
    return false
  end

  def is_straight_flush?
    return true if self.is_flush? && self.is_straight?
    return false
  end

  def is_royal?
    return true if self.get_type("number").sort == (8..12).to_a
    return false
  end

  def get_type(type)
    list = []
    @cards.each do |current_card|
      list << current_card.get_type(type)
    end
    list
  end

  def get_rank
    m = self.get_type("number")
    if m.uniq.length == 5 && m.max - m.min > 4
      return [0,m.sort.reverse,self.cards[m.index(m.max)].color]
    elsif self.has_one_pair?
      if m.uniq.length == 3
	return [2,[self.find_repeat(2).max,self.find_repeat(2).min,m-[self.find_repeat(2).max,self.find_repeat(2).min]].first,[self.cards[m.index(self.find_repeat(2).max)].color,self.cards.reverse[m.reverse.index(self.find_repeat(2).max)].color].max]
      elsif m.uniq.length == 2
	return [6,self.find_repeat(3)]
      else
	return [1,self.find_repeat(2)+(m-self.find_repeat(2)).sort.reverse,[self.cards[m.index(self.find_repeat(2).first)].color,self.cards.reverse[m.reverse.index(self.find_repeat(2).first)].color].max]
      end
    elsif self.is_three?
      return [3,self.find_repeat(3)]
    elsif self.is_four?
      return [7,self.find_repeat(4)]
    elsif self.is_flush?
      if self.is_straight?
	if m.max == 12
	  return [9,[m.max],self.cards.first.color]
	else
	  return [8,[m.max],self.cards.first.color]
	end
      else
	return [5,m.sort.reverse,self.cards.first.color]
      end
    elsif self.is_straight?
      return [4,[m.max],self.cards[m.index(m.max)].color]
    end

  end

end
class Card
  attr_accessor :card,:color,:number
  def initialize(card)
    @card = card
    @color = COLOR_ORDER.index(card.split('')[1])
    @number = NUMBER_ORDER.index(card.split('')[0])
  end

  def get_type(type)
    type == "number" ? @number : @color
  end

end
#tt=["2S","3S","4S","5S","7S"]

a=File.new('poker.txt','r')
def compare_array(a1,a2)
  a1.length.times do |n|
    return true if a1[n] > a2[n]
    return false if a1[n] < a2[n]
  end
  return false
end
sum = 0
a.readlines.each do |line|
  player_one = Poker.new(line.split("\r")[0].split(" ")[0..4])
  player_two = Poker.new(line.split("\r")[0].split(" ")[5..9])
  score1 = player_one.get_rank
  score2 = player_two.get_rank
  if score1[0] > score2[0]
    p "#{player_one.poker} beats #{player_two.poker}"
    p "#{player_one.get_rank} beats #{player_two.get_rank}"
    sum += 1
  elsif score1[0] == score2[0]
    if compare_array(score1[1],score2[1])
      p "#{player_one.poker} beats #{player_two.poker}"
      p "#{player_one.get_rank} beats #{player_two.get_rank}"
      sum += 1
    elsif !compare_array(score2[1],score1[1])
      p "#{player_one.poker} beats #{player_two.poker}"
      p "#{player_one.get_rank} beats #{player_two.get_rank}"
      sum +=1 if score1[2] > score2[2]
    end
  end
end
p sum
