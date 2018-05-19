# Using the Card class from the previous exercise, create a Deck class that
# contains all of the standard 52 playing cards.
#
# The Deck class should provide a #draw method to draw one card at random.
# If the deck runs out of cards, the deck should reset itself by generating
# a new set of 52 cards.

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

deck = Deck.new
drawn = []
52.times { drawn << deck.draw }
puts drawn.count { |card| card.rank == 5 } == 4
puts drawn.count { |card| card.suit == 'Hearts' } == 13

drawn2 = []
52.times { drawn2 << deck.draw }
puts drawn != drawn2 # Almost always.
