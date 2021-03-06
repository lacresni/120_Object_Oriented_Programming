require 'pry'

module Joinable
  def joinor(arr, separator = ', ', word = 'or')
    case arr.size
    when 0 then ''
    when 1 then arr.first.to_s
    when 2 then arr.join(" #{word} ")
    else
      arr.join(separator).insert(-2, "#{word} ")
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

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]] # diagonals

  def initialize
    @squares = {}
    reset
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  # returns winning marker or nil
  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def find_at_risk_square(marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      markers, no_markers = squares.partition(&:marked?)
      markers.map!(&:marker)
      if markers.count(marker) == 2 && no_markers.size == 1
        return line.select { |key| @squares[key].unmarked? }.first
      end
    end
    nil
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).map(&:marker)
    markers.size == 3 && markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    !unmarked?
  end
end

class Player
  include Scoreable

  attr_reader :marker, :name
  def initialize(marker)
    @marker = marker
    reset_score
  end
end

class Human < Player
  attr_writer :marker

  def set_name
    n = ""
    loop do
      puts "What's your name?"
      n = gets.chomp
      break if valid_name?(n)
      puts "Sorry, must enter a name starting with a char (a-z)"
    end
    @name = n
  end

  private

  def valid_name?(n)
    (n.empty? == false) && ('a'..'z').cover?(n.downcase.chars.first)
  end
end

class Computer < Player
  def set_name
    @name = %w[R2D2 Hal Chappie Sonny Number5].sample
  end
end

class TTTGame
  include Joinable

  COMPUTER_MARKER_1 = "O"
  COMPUTER_MARKER_2 = "X"
  DEFAULT_HUMAN_MARKER = COMPUTER_MARKER_2
  FIRST_TO_MOVE = "choose"

  attr_reader :board, :human, :computer

  def initialize
    clear
    @board = Board.new
  end

  private

  def initialize_players
    @human = Human.new(DEFAULT_HUMAN_MARKER)
    human.set_name
    human.marker = choose_human_marker

    computer_marker = COMPUTER_MARKER_1
    computer_marker = COMPUTER_MARKER_2 if human.marker == COMPUTER_MARKER_1
    @computer = Computer.new(computer_marker)
    computer.set_name
  end

  def initialize_first_player
    case FIRST_TO_MOVE
    when "player" then @current_marker = human.marker
    when "computer" then @current_marker = computer.marker
    else
      choose_first_player
    end
    @first_player = @current_marker
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
    puts "First to win #{Scoreable::WINNING_ROUNDS} rounds wins!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear
    system 'clear'
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def display_board
    puts "You're a #{human.marker}. #{computer.name} is a #{computer.marker}."
    puts ""
    board.draw
    puts ""
  end

  def marker_valid?(marker)
    marker.size == 1 &&
      marker != Square::INITIAL_MARKER
  end

  def choose_human_marker
    marker = nil
    loop do
      puts "Which marker do you want to play with? (1 char only)"
      marker = gets.chomp.upcase
      break if marker_valid?(marker)
      puts "Sorry, invalid choice."
    end
    marker
  end

  def choose_first_player
    choice = nil
    loop do
      puts "#{human.name}, do you want to play first? (y/n)"
      choice = gets.chomp.downcase
      break if %w[y n].include?(choice)
      puts "Invalid choice... Select y or n"
    end
    @current_marker = choice == 'y' ? human.marker : computer.marker
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}):"
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    # offensive move
    square = board.find_at_risk_square(computer.marker)
    # defensive move
    square = board.find_at_risk_square(human.marker) if square.nil?
    if square.nil?
      unmarked = board.unmarked_keys
      # pick square 5 if available otherwise random move
      square = unmarked.include?(5) ? 5 : unmarked.sample
    end
    board[square] = computer.marker
  end

  def human_turn?
    @current_marker == human.marker
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def update_scores
    case board.winning_marker
    when human.marker
      human.increase_score
    when computer.marker
      computer.increase_score
    end
  end

  def winner?
    human.winner? || computer.winner?
  end

  def display_scores
    puts "#{human.name} score: #{human.score}    \
    #{computer.name} score : #{computer.score}"
  end

  def display_winner
    clear_screen_and_display_board

    if human.winner?
      puts "Congratulations, #{human.name}, you won the game!"
    else
      puts "Sorry, #{computer.name} won..."
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won this round, #{human.name}!"
    when computer.marker
      puts "#{computer.name} won this round!"
    else
      puts "It's a tie!"
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

  def reset(score: false)
    board.reset
    clear
    @current_marker = @first_player
    [human, computer].each(&:reset_score) if score
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def pause
    puts "Press Enter to continue..."
    gets.chomp
  end

  def play_rounds
    loop do
      display_board
      display_scores

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end

      update_scores
      display_result
      break if winner?
      pause
      reset
    end

    display_winner
  end

  public

  def play
    clear
    display_welcome_message
    initialize_players
    initialize_first_player
    clear

    loop do
      play_rounds
      break unless play_again?
      reset(score: true)
      display_play_again_message
    end

    display_goodbye_message
  end
end

game = TTTGame.new
game.play
