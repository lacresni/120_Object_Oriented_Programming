# This code "works" because of that mysterious to_s call in Pet#initialize.
# However, that doesn't explain why this code produces the result it does.
# Can you?

class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s
  end

  def to_s
    @name.upcase!
    "My name is #{@name}."
  end
end

name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name
puts fluffy
puts fluffy.name
puts name

=begin
This code outputs:
42
My name is 42.
42
43

This time local variable name is not modified because name is an Integer which is immutable.
When calling to_s on line 9, a string is returned and @name now references this string.
So there is no link between name and instance variable @name.
Moreover, name is reassigned on line 20 to a new integer object 43.

=end
