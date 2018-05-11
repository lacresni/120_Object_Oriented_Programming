require 'pry'

module GameVariable
  WINNING_TOTAL = 21
  ACE_DEFAULT_VALUE = 1
  ACE_MAX_VALUE = 11
  DEALER_HITS_LIMIT = 17
end

module Joinable
  def joinor(arr, separator = ', ', word = 'and')
    case arr.size
    when 0 then ''
    when 1 then arr.first.to_s
    when 2 then arr.join(" #{word} ")
    else
      "#{arr[0..-2].join(separator)}#{separator}#{word} #{arr[-1]}"
    end
  end
end

module Scoreable
  WINNING_ROUNDS = 5

  attr_reader :score

  def reset_score
    @score = 0
  end

  def increase_score
    @score += 1
  end

  def winner?
    @score >= WINNING_ROUNDS
  end
end

class Participant
  include Joinable
  include GameVariable
  include Scoreable

  attr_reader :cards, :total_cards

  def initialize(deck)
    @deck = deck
    reset(score: true)
  end

  def add_card_to_hand(card)
    @cards << card
  end

  def busted?
    @total_cards > WINNING_TOTAL
  end

  def reset(score: false)
    @cards = []
    @stay = false
    @total_cards = 0
    reset_score if score
  end

  def compute_total
    @total_cards = total
  end

  private

  def prompt(message)
    puts "=> #{message}"
  end

  def total
    sum = 0
    cards.map do |card|
      sum += case card.value
             when "Ace"
               if sum + card.points > WINNING_TOTAL
                 ACE_DEFAULT_VALUE
               else
                 card.points
               end
             else
               card.points
             end
    end
    sum
  end

  def stay
    @stay = true
  end

  def stay?
    @stay
  end

  def hit
    add_card_to_hand(@deck.deal)
  end
end

class Player < Participant
  def play
    prompt "Player turn"
    loop do
      choice = hit_or_stay
      choice == "h" ? hit : stay
      compute_total
      show_cards
      break if busted? || stay?
    end

    if busted?
      puts "Busted... You lose this round..."
    else
      puts "You choose to stay!"
    end
    puts ""
  end

  def show_cards(hide_total: false)
    card_values = cards.map(&:value)
    str = "You have: #{joinor(card_values)}"
    str += " for a total of #{total_cards}" unless hide_total
    puts str
  end

  private

  def hit_or_stay
    choice = nil
    loop do
      prompt "Would you like to (h)it or (s)tay?"
      choice = gets.chomp.downcase
      break if %w[h s].include?(choice)
      puts "Invalid choice. Enter 'h' or 's'."
    end
    choice
  end
end

class Dealer < Participant
  def play
    prompt "Dealer turn"
    show_cards(show_all_cards: true)
    loop do
      total_cards < DEALER_HITS_LIMIT ? hit : stay
      compute_total
      show_cards(show_all_cards: true) unless stay?
      break if busted? || stay?
    end

    if busted?
      prompt "Dealer busted... You won this round!"
    else
      prompt "Dealer stays"
    end
    puts ""
  end

  def show_cards(show_all_cards: false)
    card_values = cards.map(&:value)
    if show_all_cards
      puts "Dealer has: #{joinor(card_values)}"
    else
      puts "Dealer has: #{card_values[0]} and unknown card"
    end
  end

  private

  def hit
    prompt "Dealer hits!"
    super
  end
end

class Deck
  SUITS = ['H', 'D', 'S', 'C']
  VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10',
            'Jack', 'Queen', 'King', 'Ace']

  def initialize
    reset
  end

  def deal
    @cards.pop
  end

  def reset
    @cards = []
    SUITS.each do |suit|
      VALUES.each do |value|
        @cards << Card.new(suit, value)
      end
    end
    @cards.shuffle!
  end
end

class Card
  include GameVariable

  attr_reader :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def points
    if ('2'..'9').cover?(value)
      value.to_i
    elsif %w[10 Jack Queen King].include?(value)
      10
    else # ace
      ACE_MAX_VALUE
    end
  end
end

class Game
  attr_reader :player, :dealer, :deck

  def initialize
    @deck = Deck.new
    @player = Player.new(deck)
    @dealer = Dealer.new(deck)
    clear
  end

  private

  def clear
    system 'clear'
  end

  def reset(score: false)
    clear
    deck.reset
    player.reset(score: score)
    dealer.reset(score: score)
  end

  def display_welcome_message
    puts "Welcome to Twenty One!"
    puts ""
    puts "First to win #{Scoreable::WINNING_ROUNDS} rounds wins!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Twenty One!"
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def show_initial_cards
    dealer.show_cards
    player.show_cards
    puts ""
  end

  def show_result
    dealer.show_cards(show_all_cards: true)
    player.show_cards(hide_total: true)
    puts "=> Results: Dealer has #{dealer.total_cards}. \
    You have #{player.total_cards}."
    puts ""
  end

  def winner?
    player.winner? || dealer.winner?
  end

  def busted?
    player.busted? || dealer.busted?
  end

  def display_winner
    if player.winner?
      puts "Congratulations, you won the game!"
    else
      puts "Sorry, dealer won the game..."
    end
  end

  def display_result
    if player.total_cards > dealer.total_cards
      puts "Congratulations, you won this round!"
    elsif player.total_cards < dealer.total_cards
      puts "Sorry, dealer won this round..."
    else
      puts "It's a tie!"
    end
    puts ""
  end

  def display_scores
    puts "Your score: #{player.score}    Dealer score : #{dealer.score}"
    puts ""
  end

  def update_player_score
    if dealer.busted? ||
       (!player.busted? && player.total_cards > dealer.total_cards)
      player.increase_score
    end
  end

  def update_dealer_score
    if player.busted? ||
       (!dealer.busted? && player.total_cards < dealer.total_cards)
      dealer.increase_score
    end
  end

  def update_scores
    update_player_score
    update_dealer_score
  end

  def deal_cards
    [player, dealer].each do |participant|
      2.times { participant.add_card_to_hand(deck.deal) }
      participant.compute_total
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y n].include?(answer)
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def pause
    puts "Press Enter to continue..."
    gets.chomp
  end

  def play_participants
    player.play
    dealer.play unless player.busted?
  end

  def play_rounds
    loop do
      display_scores
      deal_cards
      show_initial_cards
      play_participants
      show_result unless busted?
      display_result unless busted?
      update_scores

      break if winner?
      pause
      reset
    end
    display_winner
  end

  public

  def start
    display_welcome_message

    loop do
      play_rounds
      break unless play_again?
      reset(score: true)
      display_play_again_message
    end

    display_goodbye_message
  end
end

Game.new.start
