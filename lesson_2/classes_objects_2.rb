class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    name_arr = name.split
    @first_name = name_arr.first
    @last_name = name_arr.size > 1 ? name_arr.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

nico = Person.new('Nicolas Lacressonniere')
p nico.name

# Note that there is no name= setter method now.
# Hint: let first_name and last_name be "states" and create an instance method
# called name that uses those states.
