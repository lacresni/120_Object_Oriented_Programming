# Modify the following code so that Hello! I'm a cat! is printed
# when Cat.generic_greeting is invoked.
=begin
class Cat
end

Cat.generic_greeting
=end

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

# Further exploration
kitty = Cat.new
kitty.class.generic_greeting
=begin
Class methods cannot be called on instance objects. However, here, #class
method returns the object Class. So kitty.class returns Cat class.
The expression is then equivalent to Cat.generic_greeting which is a valid
class method call.
=end
