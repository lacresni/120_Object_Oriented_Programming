# Update your solution to accept a low and high value when you create
# a GuessingGame object, and use those values to compute a secret number
# for the game. You should also change the number of guesses allowed so the
# user can always win if he uses a good strategy.
# You can compute the number of guesses with:
#
# Math.log2(size_of_range).to_i + 1#

# Note that a game object should start a new game with a new number to guess
# with each call to #play.

class GuessingGame

  def initialize(min, max)
    @range = (min..max)
    @number = 0
    @nb_guess = Math.log2(@range.to_a.size).to_i + 1
  end

  def play
    reset
    user_nb = nil
    @nb_guess.downto(1) do |guess_left|
      display_nb_guess(guess_left)
      user_nb = prompt_guess
      break if win?(user_nb)
      display_indication(user_nb)
    end
    display_result(user_nb)
  end

  private

  def reset
    @number = @range.to_a.sample
  end

  def display_nb_guess(left)
    puts
    if left == 1
      puts "You have 1 guess remaining."
    else
      puts "You have #{left} guesses remaining."
    end
  end

  def prompt_guess
    choice = nil
    loop do
      puts "Enter a number between #{@range.first} and #{@range.last}:"
      choice = gets.chomp.to_i
      break if @range.cover?(choice)
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
    if win?(user_nb)
      puts "You win!"
    else
      puts "You are out of guesses. You lose."
    end
  end

  def win?(user_choice)
    user_choice == @number
  end
end

game = GuessingGame.new(501, 1500)
game.play
