class MovesHistory
  def initialize
    @history = {
      'rock' => { loss: 0, total: 0 },
      'paper' => { loss: 0, total: 0 },
      'scissors' => { loss: 0, total: 0 },
      'lizard' => { loss: 0, total: 0 },
      'spock' => { loss: 0, total: 0 }
    }
  end

  def increase_move_totals(move)
    @history[move.value][:total] += 1
  end

  def increase_move_wins(move)
    @history[move.value][:loss] += 1
  end

  def loss_rate(move_value)
    return 0 unless @history.key?(move_value)

    move_history = @history[move_value]
    percentage_loss = 0
    unless move_history[:total] == 0
      percentage_loss = 100 * move_history[:loss] / move_history[:total]
    end
    percentage_loss
  end

  def to_s
    str = ''
    @history.keys.each do |key|
      percentage_loss = loss_rate(key)
      str << "#{key}: #{percentage_loss}% "
      str << "(#{@history[key][:loss]}/#{@history[key][:total]}) "
    end
    str
  end
end

class Move
  VALUES = %w[rock paper scissors lizard spock]
  attr_reader :value

  # key beats elements in the array
  HASH_RESULT = {
    'rock' => %w[scissors lizard],
    'paper' => %w[rock spock],
    'scissors' => %w[paper lizard],
    'lizard' => %w[spock paper],
    'spock' => %w[scissors rock]
  }

  def initialize(value)
    @value = value
  end

  def >(other_move)
    HASH_RESULT[@value].include?(other_move.value)
  end

  def <(other_move)
    HASH_RESULT[other_move.value].include?(@value)
  end

  def to_s
    @value
  end
end

class Player
  NB_ROUNDS = 5
  attr_accessor :move, :name, :history
  attr_reader :score

  def reset_score
    @score = 0
  end

  def increase_score
    @score += 1
  end

  def initialize
    @history = MovesHistory.new
    reset_score
    set_name
  end

  def won?
    score >= NB_ROUNDS
  end

  def log_move_to_history
    history.increase_move_totals(move)
  end
end

class Human < Player
  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp.strip
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp
      break if Move::VALUES.include?(choice)
      puts "Sorry, invalid choice..."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class R2D2 < Computer
  def set_name
    self.name = 'R2D2'
  end

  def choose
    self.move = Move.new('rock')
  end
end

class Chappie < Computer
  def set_name
    self.name = 'Chappie'
  end

  def choose
    sample_list = fill_samples_list
    self.move = Move.new(sample_list.sample)
  end

  private

  def fill_samples_list
    sample_list = []
    Move::VALUES.each do |move|
      rate = history.loss_rate(move)
      sample_list << case rate
                     when (0..40) then ([move] * 3)
                     when (41..70) then ([move] * 2)
                     else move
                     end
    end
    sample_list.flatten
  end
end

class Hal < Computer
  def set_name
    self.name = 'Hal'
  end

  def choose
    sample_list = %w[rock scissors scissors scissors lizard spock]
    self.move = Move.new(sample_list.sample)
  end
end

class Sonny < Computer
  def set_name
    self.name = 'Sonny'
  end
end

class Number5 < Computer
  def set_name
    self.name = 'Number 5'
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = [R2D2, Hal, Chappie, Sonny, Number5].sample.new
  end

  private

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock. Good bye!"
  end

  def display_moves
    puts
    [human, computer].each do |player|
      puts "#{player.name} chose = #{player.move}."
    end
    puts
  end

  def display_moves_history
    [human, computer].each do |player|
      puts "#{player.name} loss moves history is:"
      puts player.history
    end
    puts
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

  def update_moves(winner)
    return if winner.nil?

    loser = winner.is_a?(Human) ? computer : human
    loser.history.increase_move_wins(loser.move)
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
    puts "Start new game!"
    puts "You are playing against #{computer.name}."
    puts "First to reach #{Player::NB_ROUNDS} wins!"
    puts
  end

  def choose_moves
    [human, computer].each do |player|
      player.choose
      player.log_move_to_history
    end
  end

  def play_single_round
    # display_moves_history
    choose_moves
    display_moves
    winner = determine_winner
    update_moves(winner)
    display_winner(winner)
    update_scores(winner)
    display_scores
  end

  def play_full_round
    round_init
    loop do
      play_single_round
      break if human.won? || computer.won?
    end

    display_full_round_result
  end

  public

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
