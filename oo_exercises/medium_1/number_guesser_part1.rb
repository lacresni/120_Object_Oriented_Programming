# Create an object-oriented number guessing class for numbers
# in the range 1 to 100, with a limit of 7 guesses per game.
# The game should play like this:
#
# game = GuessingGame.new
# game.play
#
# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low
#
# Note that a game object should start a new game with a new number to guess
# with each call to #play.

class GuessingGame
  RANGE = (1..100)
  NB_GUESS = 7

  def initialize
    @number = 0
    @nb_guess = 0
  end

  def play
    reset
    user_nb = nil
    loop do
      display_nb_guess
      user_nb = prompt_guess
      @nb_guess -= 1
      break if user_nb == @number || @nb_guess == 0
      display_indication(user_nb)
    end
    display_result(user_nb)
  end

  private

  def reset
    @number = RANGE.to_a.sample
    @nb_guess = NB_GUESS
  end

  def display_nb_guess
    puts
    if @nb_guess == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{@nb_guess} guesses remaining."
    end
  end

  def prompt_guess
    choice = nil
    loop do
      puts "Enter a number between #{RANGE.first} and #{RANGE.last}:"
      choice = gets.chomp.to_i
      break if RANGE.cover?(choice)
      puts "Invalid guess."
    end
    choice
  end

  def display_indication(user_nb)
    if user_nb < @number
      puts "Your guess is too low"
    else
      puts "Your guess is too high"
    end
  end

  def display_result(user_nb)
    if user_nb == @number
      puts "You win!"
    else
      puts "You are out of guesses. You lose."
    end
  end
end

game = GuessingGame.new
game.play
