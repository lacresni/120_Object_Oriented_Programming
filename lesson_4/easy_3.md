# Practice Problems: Easy 3

#### Question 1

If we have this code:

```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

What happens in each of the following cases:

case 1:

```ruby
hello = Hello.new
hello.hi
=> "Hello"
```

case 2:

```ruby
hello = Hello.new
hello.bye
# => undefined method `bye' for #<Hello:0x007fee81a274f8> (NoMethodError)
```

case 3:

```ruby
hello = Hello.new
hello.greet
# => wrong number of arguments (given 0, expected 1) (ArgumentError)
```

case 4:

```ruby
hello = Hello.new
hello.greet("Goodbye")
=> "Goodbye"
```

case 5:

```ruby
Hello.hi
# => undefined method `hi' for class Hello:Class (NoMethodError)
```



#### Question 2

In the last question we had the following classes:

```ruby
class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end
```

If we call `Hello.hi` we get an error message. How would you fix this?

```ruby
class Greeting
  def self.hi
    puts "Hi"
  end

  def greet(message)
    puts message
  end
end
```



#### Question 3

When objects are created they are a separate realization of a particular class.

```ruby
class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end
```

Given the class above, how do we create two different instances of this class, both with separate names and ages?

=> Simply by calling `new` method with different names and ages as arguments. These variables will become the instance variables of the class. The two objects will give us different information. This can be confirmed by using getter methods on each object.

```ruby
misty = AngryCat(3, 'Misty')
saphir = AngryCat(15, 'Saphir')

misty.age	# 3
misty.name	# Misty
saphir.age	# 15
saphir.name	# Saphir
```



#### Question 4

Given the class below, if we created a new instance of the class and then called `to_s` on that instance we would get something like `"#<Cat:0x007ff39b356d30>"`

```ruby
class Cat
  def initialize(type)
    @type = type
  end
end
```

How could we go about changing the `to_s` output on this method to look like this: `I am a tabby cat`? (this is assuming that `"tabby"` is the `type` we passed in during initialization).

```ruby
class Cat
  def initialize(type)
    @type = type
  end
    
  def to_s
    "I am a #{@type} cat"
  end
end

my_cat = Cat.new('tabby')
puts my_cat # automatically calls to_s method
```



#### Question 5

If I have the following class:

```ruby
class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end
```

What would happen if I called the methods like shown below?

```ruby
tv = Television.new
tv.manufacturer # undefined method `manufacturer' for #<Television:0x007fab52924398> (NoMethodError)
tv.model		# OK

Television.manufacturer # OK
Television.model  # undefined method `model' for Television:Class (NoMethodError)
```



#### Question 6

If we have a class such as the one below:

```ruby
class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end
```

In the `make_one_year_older` method we have used `self`. What is another way we could write this method so we don't have to use the `self` prefix?

=> We could use the instance variable `age` directly with the `@` symbol. Here, `self` allows to use the setter method `age=`  

```ruby
  def make_one_year_older
    @age += 1
  end
```



#### Question 7

What is used in this class but doesn't add any value?

```ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end
```

=> The class method `information` doesn't add any value. It returns an hardcoded string and cannot use instance variables `brightness` and `colors`. It should have been more interesting to have an instance method `information` that uses the instance variables `brightness` and `colors` to return useful information on the state of the object.

Moreover, on line 10, `return` is useless as method returns implicitely the evaluated result of the last line that is executed in the method.