# Practice Problems: Easy 2

#### Question 1

You are given the following code:

```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end
```

What is the result of calling

```ruby
oracle = Oracle.new
oracle.predict_the_future
```

On line 1, we are instantiating a new `Oracle` object. It is assigned to the `oracle` variable.

On line 2, we are calling the instance method `predict_the_future` on the `oracle` variable. This method returns a string. On line 3, instance method `Oracle#choices` is called and returns an array of string. Thus,  `Array#sample` method can be chained. `choices.sample` returns one of the three strings contained in the array. 

`predict_the_future` method returns a string that is the concatenation of the two strings "You will " and the one returned by `choices.sample`



#### Question 2

We have an `Oracle` class and a `RoadTrip` class that inherits from the `Oracle` class.

```ruby
class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end
```

What is the result of the following:

```ruby
trip = RoadTrip.new
trip.predict_the_future
```

=> The principle is the same as the one described in question 1. Calling `predict_the_future` method will return a string of type "You will <something>". However, this time, thanks to polymorphism and inheritance, `RoadTrip` class has overriden the `choices` method from its parent class to return its own array of choices. This works because we are calling the `choices` method on a `RoadTrip` object. In order to resolve a method name, Ruby starts with the methods defined in the class you are calling before going up into the inheritance hierarchy.

Thus the returned string will be composed of one of the three values of the array on line 13.



#### Question 3

How do you find where Ruby will look for a method when that method is called?

=> We can find this in the lookup path. Ruby will look for a method starting in the first class in the chain and eventually lookup `BasicObject` if the method is found nowhere in the lookup chain. 

How can you find an object's ancestors?

=> We can find an object's ancestors by calling the `Object#ancestors` method on its class.

```ruby
module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end
```

What is the lookup chain for `Orange` and `HotSauce`?

```
puts Orange.ancestors
Orange
Taste
Object
Kernel
BasicObject

puts HotSauce.ancestors
HotSauce
Taste
Object
Kernel
BasicObject
```



#### Question 4

What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?

```ruby
class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
```

We could remove the `type` and `type=` methods and replace them by adding a call to `attr_accessor` method. This gives us the ability to get and set the @type instance variable as we can do now.

```ruby
class BeesWax
  attr_accessor :type
    
  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end
```

Note that we have replaced the `@type` access by `type` on line 15. It is standard practice to refer to instance variables inside the class without `@` if the getter method is available.



#### Question 5

There are a number of variables listed below. What are the different types and how do you know which is which?

```ruby
excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"
```

On line 1, `excited_dog` is a local variable.

On line 2, `@excited_dog` is an instance variable. This is because the variable is prefixed with an `@`

On line 3, `@@excited_dog` is a class variable. This is because the variable is prefixed with `@@`



#### Question 6

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

Which one of these is a class method (if any) and how do you know?

=> `self.manufacturer` is a class method. This is because the method is prefixed with `self` whereas an instance method has no prefix.

How would you call a class method? 

=> Simply, prepend the class name as is:

```ruby
Television.manufacturer
```



#### Question 7

If we have a class such as the one below:

```ruby
class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end
```

Explain what the `@@cats_count` variable does and how it works. 

=> `@@cats_count` is a class variable. It is used to count the total number of `Cat` objects that have been instantiated in your program. It is initialized at the class level on line 2. Then it is incremented in the constructor or `#initialize` method. Finally, its value can be accessed through the class variable `self.cats_count`

What code would you need to write to test your theory?

```ruby
puts Cat.cats_count 		# 0
cat1 = Cat.new('angora')
puts Cat.cats_count 		# 1
cat2 = Cat.new('angora')
cat3 = Cat.new('angora')
puts Cat.cats_count 		# 3
```



#### Question 8

If we have this class:

```ruby
class Game
  def play
    "Start the game!"
  end
end
```

And another class:

```ruby
class Bingo
  def rules_of_play
    #rules of play
  end
end
```

What can we add to the `Bingo` class to allow it to inherit the `play` method from the `Game` class?

```ruby
class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

bingo = Bingo.new
puts bingo.play    # Start the game!
```



#### Question 9

If we have this class:

```ruby
class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end
```

What would happen if we added a `play` method to the `Bingo` class, keeping in mind that there is already a method of this name in the `Game` class that the `Bingo` class inherits from.

=> The `play` method from the `Game` class would be overriden and `Bingo` class could define its own behavior for the `play` method.



#### Question 10

What are the benefits of using Object Oriented Programming in Ruby? Think of as many as you can.

* Encapsulation hides complexity by instantiating objects and providing interfaces to interact with these objects
* Avoid code duplication (inheritance, modules)
* Better code organization (abstraction)
* Better code maintenance
* Reusability
* Polymorphism



**LaunchSchool solution**

Because there are so many benefits to using OOP we will just summarize some of the major ones:

1. Creating objects allows programmers to think more abstractly about the code they are writing.
2. Objects are represented by nouns so are easier to conceptualize.
3. It allows us to only expose functionality to the parts of code that need it, meaning namespace issues are much harder to come across.
4. It allows us to easily give functionality to different parts of an application without duplication.
5. We can build applications faster as we can reuse pre-written code.
6. As the software becomes more complex this complexity can be more easily managed.