# What output does this code print?
# Fix this class so that there are no surprises waiting in store for
# the unsuspecting developer.

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    # @name.upcase!
    "My name is #{@name.upcase}" # "My name is #{@name}."
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

=begin
1. What output does this code print?
On line 10, String#to_s method is called, this @name is initialized with 'Fluffy'
On line 22, puts fluffy.name <=> puts fluffy.name.to_s. Here, it is once again String#to_s
method that is called on fluffy.name returned value. fluffy.name returns 'Fluffy' so this is
waht is displayed on line 22.
Line 23 is equivalent to puts fluffy.to_s. Here, it is the Pet#to_s method that is called.
Pet#to_s method mutates the @name instance variable by calling #upcase! method on it.
So line 23 outputs 'My name is FLUFFY.'
Line 24 now outputs 'FLUFFY' because @name instance variable has been mutated on line 23.
Local variable name and fluffy instance variable @name reference the same string object.
As @name instance variable has been mutated, local variable name is also mutated and line 24 will
output 'FLUFFY'

puts fluffy.name => "Fluffy"
puts fluffy <=> puts fluffy.to_s => "My name is FLUFFY."
puts fluffy.name => "FLUFFY"
puts name => 'FLUFFY'

=end
