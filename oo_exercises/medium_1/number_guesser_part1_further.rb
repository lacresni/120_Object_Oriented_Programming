# Create an object-oriented number guessing class for numbers
# in the range 1 to 100, with a limit of 7 guesses per game.
#
# Note that a game object should start a new game with a new number to guess
# with each call to #play.

# Further Exploration:
# Do you think it's a good idea to have a Player class?
# What methods and data should be part of it?
# How many Player objects do you need?
# Should you use inheritance, a mix-in module, or a collaborative object?
class Player
  def initialize
  end

  def guess(min, max)
    choice = nil
    loop do
      puts "Enter a number between #{min} and #{max}:"
      choice = gets.chomp.to_i
      break if (min..max).cover?(choice)
      puts "Invalid guess."
    end
    choice
  end
end

class GuessingGame
  RANGE = (1..100)
  NB_GUESS = 7

  def initialize
    @player = Player.new
    @number = 0
  end

  def play
    reset
    user_nb = nil
    NB_GUESS.downto(1) do |nb_guess|
      display_nb_guess(nb_guess)
      user_nb = @player.guess(RANGE.first, RANGE.last)
      break if win?(user_nb)
      display_indication(user_nb)
    end

    display_result(user_nb)
  end

  private

  def reset
    @number = RANGE.to_a.sample
    @nb_guess = NB_GUESS
  end

  def win?(nb)
    nb == @number
  end

  def display_nb_guess(nb_guess)
    puts
    if nb_guess == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{@nb_guess} guesses remaining."
    end
  end

  def display_indication(user_nb)
    if user_nb < @number
      puts "Your guess is too low"
    else
      puts "Your guess is too high"
    end
  end

  def display_result(user_nb)
    if win?(user_nb)
      puts "You win!"
    else
      puts "You are out of guesses. You lose."
    end
  end
end

game = GuessingGame.new
game.play
