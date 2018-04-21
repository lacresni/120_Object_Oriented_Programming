# Class Hierarchy Diagram
#
#            Pet
#            / \
#           /   \
#         Dog   Cat
#         /
#        /
#     Bulldog

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

puts "Pet lookup path"
puts "---------------"
puts Pet.ancestors.join(' < ')

puts
puts "Dog lookup path"
puts "---------------"
puts Dog.ancestors.join(' < ')

puts
puts "Bulldog lookup path"
puts "-------------------"
puts Bulldog.ancestors.join(' < ')

puts
puts "Cat lookup path"
puts "---------------"
puts Cat.ancestors.join(' < ')

=begin
What is the method lookup path and how is it important?

Method lookup path is the order in which Ruby will traverse the hierarchy path
to look for the method to invoke

Method lookup path is important in order to understand which method will be
called for a particular class

=end
