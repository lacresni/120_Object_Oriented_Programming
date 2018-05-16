require 'pry'

class Owner
  attr_reader :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def adopt(pet)
    @pets << pet
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    pets.each { |pet| puts pet }
  end
end

class Pet
  attr_reader :animal, :name

  def initialize(animal, name)
    @animal = animal
    @name = name
  end

  def to_s
    "a #{animal} named #{name}"
  end
end

class Shelter
  def initialize
    @owners = []
    @unadopted_pets = []
  end

  def add_pet(pet)
    @unadopted_pets << pet unless @unadopted_pets.include?(pet)
  end

  def adopt(owner, pet)
    if @unadopted_pets.include?(pet)
      owner.adopt(pet)
      @owners << owner unless @owners.include?(owner)
      @unadopted_pets.delete(pet)
    end
  end

  def print_adoptions
    @owners.each do |owner|
      puts "#{owner.name} has adopted the following pets:"
      owner.print_pets
      puts ""
    end
  end

  def unadopted_pets
    @unadopted_pets.size
  end

  def print_unadopted_pets
    puts "The Animal Shelter has the following unadopted pets:"
    @unadopted_pets.each { |pet| puts pet }
    puts ""
  end
end

butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
saphir       = Pet.new('cat', 'Saphir')
asta         = Pet.new('dog', 'Asta')
laddie       = Pet.new('dog', 'Laddie')
fluffy       = Pet.new('cat', 'Fluffy')
kat          = Pet.new('cat', 'Kat')
ben          = Pet.new('cat', 'Ben')
chatterbox   = Pet.new('parakeet', 'Chatterbox')
bluebell     = Pet.new('parakeet', 'Bluebell')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')
nlacress = Owner.new('N Lacresonniere')

shelter = Shelter.new
shelter.add_pet(butterscotch)
shelter.add_pet(pudding)
shelter.add_pet(darwin)
shelter.add_pet(kennedy)
shelter.add_pet(sweetie)
shelter.add_pet(molly)
shelter.add_pet(chester)
shelter.add_pet(saphir)
shelter.add_pet(asta)
shelter.add_pet(laddie)
shelter.add_pet(fluffy)
shelter.add_pet(kat)
shelter.add_pet(ben)
shelter.add_pet(chatterbox)
shelter.add_pet(bluebell)

puts "The Animal shelter has #{shelter.unadopted_pets} unadopted pets."
puts ""

shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.adopt(nlacress, saphir)
shelter.print_adoptions
shelter.print_unadopted_pets

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "#{nlacress.name} has #{nlacress.number_of_pets} adopted pets."
puts "The Animal shelter has #{shelter.unadopted_pets} unadopted pets."

# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin
#
# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester
#
# The Animal Shelter has the following unadopted pets:
# a dog named Asta
# a dog named Laddie
# a cat named Fluffy
# a cat named Kat
# a cat named Ben
# a parakeet named Chatterbox
# a parakeet named Bluebell
#
# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.
# The Animal shelter has 7 unadopted pets.
