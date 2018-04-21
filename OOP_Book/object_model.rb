module Board
  def display(msg)
    puts msg
  end
end

class MyClass
  include Board
end

my_class = MyClass.new
my_class.display("Welcome to my Class!!")
p my_class.object_id
