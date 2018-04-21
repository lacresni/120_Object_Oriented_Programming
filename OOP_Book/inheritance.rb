class Vehicle
  @@nb_vehicles = 0

  # Accessors
  attr_accessor :color
  attr_reader :year, :model

  # Class method
  def self.gas_mileage(liters, kms)
    mileage = 100.0 * liters / kms
    puts "Your gas consumption was #{mileage.round(2)} liters per 100 kms"
  end

  def self.get_nb_vehicles
    @@nb_vehicles
  end

  # Constructor
  def initialize(model, year, color)
    @model = model
    @year = year
    @color = color
    @current_speed = 0

    @@nb_vehicles += 1
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

  def age
    puts "Your vehicle is #{compute_age} years old."
  end

  private

  def compute_age
    current_year = Time.now.year
    current_year - year
  end

end

module Towable
  def transport_goods
    "I can transport goods"
  end
end

class MyCar < Vehicle
  NB_WHEELS = 4

  def nb_wheels
    NB_WHEELS
  end

  def to_s
    "Your car is a #{color} #{model} from #{year}."
  end
end

class MyTruck < Vehicle
  NB_WHEELS = 6

  include Towable

  def nb_wheels
    NB_WHEELS
  end

  def to_s
    "Your truck is a #{color} #{model} from #{year}."
  end
end

puts "There are #{Vehicle.get_nb_vehicles} vehicles"

ford_focus = MyCar.new('Ford Focus', 2008, 'yellow')
puts "Your vehicle is of type #{ford_focus.class} and has #{ford_focus.nb_wheels} wheels."
puts ford_focus

renault_truck = MyTruck.new('Renault', 1998, 'white')
puts
puts "Your vehicle is of type #{renault_truck.class} and has #{renault_truck.nb_wheels} wheels."
puts renault_truck
puts "I am a vehicle of type #{renault_truck.class} and #{renault_truck.transport_goods}."

puts "There are #{Vehicle.get_nb_vehicles} vehicles"

puts "Vehicle ancestors"
puts "-----------------"
puts Vehicle.ancestors

puts
puts "MyCar ancestors"
puts "-----------------"
puts MyCar.ancestors

puts
puts "MyTruck ancestors"
puts "-----------------"
puts MyTruck.ancestors

puts
ford_focus.age
renault_truck.age

class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student)
    self.grade < student.grade
  end

  protected
  attr_reader :grade
end

joe = Student.new('Joe', 'B')
bob = Student.new('Bob', 'C')
puts "Well done!" if joe.better_grade_than?(bob)
