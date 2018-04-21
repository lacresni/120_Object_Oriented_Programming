class Person
  attr_accessor :first_name, :last_name

  def initialize(fullname)
    fill_names_attr(fullname)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(fullname)
    fill_names_attr(fullname)
  end

  private

  def fill_names_attr(fullname)
    name_arr = fullname.split
    self.first_name = name_arr.first
    self.last_name = name_arr.size > 1 ? name_arr.last : ''
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

nico = Person.new('Nicolas Lacressonniere')
p nico.name
nico.name = 'Lacresni'
p nico.first_name
p nico.last_name
