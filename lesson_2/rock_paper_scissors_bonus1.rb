require 'pry'

class Move
  VALUES = %w[rock paper scissors]

  def initialize(value)
    @value = value
  end

  def scissors?
    @value == 'scissors'
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissors?) ||
      (scissors? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  NB_ROUNDS = 5
  attr_accessor :move, :name
  attr_reader :score

  def reset_score
    @score = 0
  end

  def increase_score
    @score += 1
  end

  def initialize
    @move = nil # not mandatory (initialized to nil by default...)
    reset_score
    set_name
  end

  def won?
    score >= NB_ROUNDS
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper or scissors:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice..."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = %w[R2D2 Hal Chappie Sonny Number5].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good bye!"
  end

  def display_moves
    [human, computer].each do |player|
      puts "#{player.name} chose = #{player.move}."
    end
  end

  def display_scores
    puts "-----------------------"
    [human, computer].each do |player|
      puts "#{player.name} score = #{player.score}"
    end
    puts "-----------------------"
  end

  def determine_winner
    winner = nil
    if human.move > computer.move
      winner = human
    elsif human.move < computer.move
      winner = computer
    end
    winner
  end

  def display_winner(winner)
    puts winner.nil? ? "It's a tie!" : "#{winner.name} won!"
  end

  def update_scores(winner)
    winner&.increase_score
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w[y n].include?(answer)
      puts "Sorry, must be y or n..."
    end
    answer == 'y'
  end

  def display_full_round_result
    if human.won?
      puts "Congratulations, #{human.name}! You are the Great winner!!!"
    else
      puts "Sorry, computer #{computer.name} won..."
    end
  end

  def round_init
    human.reset_score
    computer.reset_score
    system 'clear'
  end

  def play_full_round
    round_init
    loop do
      human.choose
      computer.choose
      display_moves
      winner = determine_winner
      display_winner(winner)
      update_scores(winner)
      display_scores
      break if human.won? || computer.won?
    end

    display_full_round_result
  end

  def play
    display_welcome_message

    loop do
      play_full_round
      break unless play_again?
    end

    display_goodbye_message
  end
end

RPSGame.new.play
