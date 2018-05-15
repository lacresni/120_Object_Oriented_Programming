# Consider the following classes:
# Refactor these classes so they all use a common superclass,
# and inherit behavior as needed.

class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end

  def wheels
    self.class::WHEELS
  end
end

class Car < Vehicle
  WHEELS = 4
end

class Motorcycle < Vehicle
  WHEELS = 2
end

class Truck < Vehicle
  WHEELS = 6

  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end
end

my_car = Car.new('Ford', 'Focus')
puts my_car
puts my_car.wheels

my_moto = Motorcycle.new('Kawasaki', '500')
puts my_moto
puts my_moto.wheels

my_truck = Truck.new('Scania', '8000', 7500)
puts my_truck
puts my_truck.wheels
puts my_truck.payload
