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

  def to_s
    name
  end

  private

  def fill_names_attr(fullname)
    name_arr = fullname.split
    self.first_name = name_arr.first
    self.last_name = name_arr.size > 1 ? name_arr.last : ''
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
