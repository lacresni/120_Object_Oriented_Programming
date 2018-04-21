class MyCar
  # Accessors
  attr_accessor :color
  attr_reader :year, :model

  # Class method
  def self.gas_mileage(liters, kms)
    mileage = 100.0 * liters / kms
    puts "Your gas consumption was #{mileage.round(2)} liters per 100 kms"
  end

  # Constructor
  def initialize(model, year, color)
    @model = model
    @year = year
    @color = color
    @current_speed = 0
  end

  # Instance methods
  def speed_up(number)
    @current_speed += number
    puts "You push the gas and accelerate #{number} km/h"
  end

  def brake(number)
    @current_speed -= number
    puts "You push the brake and decelerate #{number} km/h"
  end

  def current_speed
    puts "You are now going to #{@current_speed} km/h"
  end

  def shut_down
    @current_speed = 0
    puts "It's time to stop!"
  end

  def spray_paint(color)
    self.color = color
    puts "Your new #{color} paint job looks great!"
  end

  def to_s
    "Your car is a #{color } #{model} from #{year}."
  end
end

ford_focus = MyCar.new('Ford Focus', 2008, 'yellow')

puts "Your car was built in #{ford_focus.year}."

puts "Your car was #{ford_focus.color}."
ford_focus.spray_paint('blue')
puts "Your car is now #{ford_focus.color}."

ford_focus.speed_up(30)
ford_focus.current_speed
ford_focus.speed_up(30)
ford_focus.current_speed
ford_focus.brake(30)
ford_focus.current_speed
ford_focus.brake(30)
ford_focus.current_speed
ford_focus.shut_down
ford_focus.current_speed

MyCar.gas_mileage(47, 680)

# Illustrate #to_s overriden
puts
puts ford_focus
