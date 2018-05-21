# Create a class, PokerHand, that takes 5 cards from a Deck of Cards and
# evaluates those cards as a Poker hand.

class PokerHand
  HAND_CLASSIFICATION = { 'High card' => 1, 'Pair' => 2, 'Two pair' => 3,
                          'Three of a kind' => 4, 'Straight' => 5,
                          'Flush' => 6, 'Full house' => 7,
                          'Four of a kind' => 8, 'Straight flush' => 9,
                          'Royal flush' => 10 }
  include Comparable

  def initialize(hand)
    @hand = hand
    @hand.sort!
  end

  def print
    @hand.each { |card| puts card }
  end

  def <=>(other_hand)
    my_hand_value = HAND_CLASSIFICATION[evaluate]
    other_hand_value = HAND_CLASSIFICATION[other_hand.evaluate]

    return 1 if my_hand_value > other_hand_value
    return -1 if my_hand_value < other_hand_value
    return 0 if my_hand_value == other_hand_value
    nil
  end

  def evaluate
    case
    when self.class.royal_flush?(@hand)     then 'Royal flush'
    when self.class.straight_flush?(@hand)  then 'Straight flush'
    when self.class.four_of_a_kind?(@hand)  then 'Four of a kind'
    when self.class.full_house?(@hand)      then 'Full house'
    when self.class.flush?(@hand)           then 'Flush'
    when self.class.straight?(@hand)        then 'Straight'
    when self.class.three_of_a_kind?(@hand) then 'Three of a kind'
    when self.class.two_pair?(@hand)        then 'Two pair'
    when self.class.pair?(@hand)            then 'Pair'
    else                                         'High card'
    end
  end

  def self.royal_flush?(cards)
    straight_flush?(cards) && cards.max.rank == 'Ace'
  end

  def self.straight_flush?(cards)
    flush?(cards) && straight?(cards)
  end

  def self.four_of_a_kind?(cards)
    n_identical_cards?(cards, 4)
  end

  def self.full_house?(cards)
    n_identical_cards?(cards, 3) && n_identical_cards?(cards, 2)
  end

  def self.flush?(cards)
    # 5 cards with same suit
    first_suit = cards.first.suit
    cards.all? { |card| card.suit == first_suit }
  end

  def self.straight?(cards)
    ranks = cards.map do |card|
      case card.rank
      when (2..10) then card.rank.to_i
      when 'Jack' then 11
      when 'Queen' then 12
      when 'King' then 13
      when 'Ace' then 14
      end
    end

    return false unless ranks.uniq.size == 5

    # Note: Ace can be considered either as 1 or as Ace...
    # The only case where it can cause trouble is 2/3/4/5/Ace => Ace/2/3/4/5
    if ranks.first == 2 && ranks.last == 14
      ranks[4] = 1
      ranks.sort!
    end

     ranks.min == ranks.max - 4
  end

  def self.three_of_a_kind?(cards)
    n_identical_cards?(cards, 3)
  end

  def self.two_pair?(cards)
    ranks = cards.map(&:rank)
    n_identical_cards?(cards, 2) && ranks.uniq.size == 3
  end

  def self.pair?(cards)
    n_identical_cards?(cards, 2)
  end

  def best_combination
    all_combinations = combination(5).to_a
    # need to transform array of cards to an array of PokerHand
    # so that they can be sorted (compared with <=> method)
    all_combinations.map! { |hand| self.class.new(hand) }
    all_combinations.sort!
    all_combinations.max # get best combination
  end

  private

  def self.n_identical_cards?(cards, n)
    ranks = cards.map(&:rank)
    counts = cards.map { |card| ranks.count(card.rank) }
    counts.uniq.include?(n)
  end

  def combination(n)
    @hand.combination(n)
  end
end

class Deck
  RANKS = (2..10).to_a + %w(Jack Queen King Ace).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    reset
  end

  def draw
    reset if @cards.empty?
    @cards.pop
  end

  def hand(nb_cards = 5)
    hand = []
    nb_cards.times { hand << draw }
    hand
  end

  private

  def reset
    @cards = []
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << Card.new(rank, suit)
      end
    end
    @cards.shuffle!
  end
end

class Card
  CARDS_POWER_SUITE = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
                       'Jack', 'Queen', 'King', 'Ace']

  attr_reader :rank, :suit
  include Comparable

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{rank} of #{suit}"
  end

  def <=>(other_card)
    pos_a = CARDS_POWER_SUITE.find_index(rank.to_s)
    pos_b = CARDS_POWER_SUITE.find_index(other_card.rank.to_s)

    return 1 if pos_a > pos_b
    return -1 if pos_a < pos_b
    return 0 if pos_a == pos_b
    nil
  end
end

puts "Best Combination (5 out of 7)"
deck = Deck.new
hand_with_7_cards = PokerHand.new(deck.hand(7))
puts "My seven cards are:"
hand_with_7_cards.print
puts
puts "Best 5 cards combination is:"
best_hand = hand_with_7_cards.best_combination
best_hand.print
puts "=> #{best_hand.evaluate}"
