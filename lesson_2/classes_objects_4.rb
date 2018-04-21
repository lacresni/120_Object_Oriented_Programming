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

  def compare_name?(other)
    name == other.name
  end

  private

  def fill_names_attr(fullname)
    name_arr = fullname.split
    self.first_name = name_arr.first
    self.last_name = name_arr.size > 1 ? name_arr.last : ''
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

# If we're trying to determine whether the two objects contain the same name,
# how can we compare the two objects?

puts "Solution 1: use name method for comparison"
p bob.name == rob.name

puts "Solution 2: use first_name and last_name getter methods for comparison"
p bob.first_name == rob.first_name && bob.last_name == rob.last_name

puts "Solution 3: create a dedicated method for comparison"
p bob.compare_name?(rob)
