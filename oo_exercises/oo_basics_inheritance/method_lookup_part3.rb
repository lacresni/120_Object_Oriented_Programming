# Using the following code, determine the lookup path used when invoking
# bird1.color. Only list the classes or modules that were checked by Ruby
# when searching for the #color method.

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

p Bird.ancestors

bird1 = Bird.new('Red')
bird1.color

=begin
Bird => no method color
Flyable => no method color
Animal => OK, color method found and invoked
=end
