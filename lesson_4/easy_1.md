# Practice Problems: Easy 1

#### Question 1

Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

1. `true`
2. `"hello"`
3. `[1, 2, 3, "happy days"]`
4. `142`

=> They are all objects (Remember that, in Ruby, everything is an object!)

We can use `Object#class` method to return the class of the object.

```ruby
p true.class
p "hello".class
p [1, 2, 3, "happy days"].class
p 142.class

TrueClass
String
Array
Integer
```



#### Question 2

If we have a `Car` class and a `Truck` class and we want to be able to `go_fast`, how can we add the ability for them to `go_fast`using the module `Speed`? How can you check if your `Car` or `Truck` can now go fast?

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

How can we add the ability for them to `go_fast`using the module `Speed`?

=> We need to mix in module into `Car` and `Truck` classes by using `include` method invocation. 

```ruby
class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed    
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end
```

How can you check if your `Car` or `Truck` can now go fast?

=> We can instantiate a `Car` instance and a `Truck` instance and call `go_fast` method for each.

```ruby
car = Car.new
car.go_fast
truck = Truck.new
truck.go_fast
```



#### Question 3

In the last question we had a module called `Speed` which contained a `go_fast` method. We included this module in the `Car` class as shown below.

```ruby
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end
```

When we called the `go_fast` method from an instance of the `Car` class (as shown below) you might have noticed that the `string` printed when we go fast includes the name of the type of vehicle we are using. 

```ruby
>> small_car = Car.new
>> small_car.go_fast
I am a Car and going super fast!
```

How is this done?

=> This is because `go_fast` method uses `self.class`. Inside an instance method, `self` represents the calling object (in our case `small_car` object). As we have seen in Question 1, we can call `Object#class` method to return the class of the object. String interpolation automatically calls `to_s` method to display the class name (or type of vehicle).



#### Question 4

If we have a class `AngryCat`, how do we create a new instance of this class?

The `AngryCat` class might look something like this:

```ruby
class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end
```

=> We simply need to call `#new` class method to create a new instance of this class.

```ruby
my_cat = AngryCat.new
```



#### Question 5

Which of these two classes has an instance variable and how do you know?

```ruby
class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end
```

`Pizza` class has an instance variable `@name`. This is because instance variables are declared using `@` symbol.

Note: it is also possible to verify this by asking to the objects if they have instance variables using the `Object#instance_variables` method.

```ruby
hot_pizza = Pizza.new("cheese")
orange    = Fruit.new("apple")

>> hot_pizza.instance_variables
=> [:@name]
>> orange.instance_variables
=> []
```



#### Question 6

What could we add to the class below to access the instance variable `@volume`?

```ruby
class Cube
  def initialize(volume)
    @volume = volume
  end
end
```

=> We could add a *getter* method by using one of the following into the `Cube` class definition:

```ruby
attr_reader :volume
```

or

```ruby
def volume
  @volume
end
```



#### Question 7

What is the default return value of `to_s` when invoked on an object?

=> By default, the `to_s` method will return the name of the object's class and an encoding of the object id. This is the default `Object#to_s` implementation.

```
#<Pizza:0x007fd7c9026a18>
```

Where could you go to find out if you want to be sure?

=> We could verify this in Ruby Docs. See [Object#to_s method definition](http://ruby-doc.org/core-2.4.1/Object.html#method-i-to_s).



#### Question 8

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

You can see in the `make_one_year_older` method we have used `self`. What does `self` refer to here?

Within instance methods, `self` represents the calling object. `self` is necessary when *setting* an instance variable because `self.age += 1` is actually a method call. This is equivalent to `self.age=(age.+(1))`.

In this case, Ruby can determine this is a method and sets the instance variable as expected. Otherwise, Ruby thinks age is a local variable to the `make_one_year_older` and does not set `@age` variable.



#### Question 9

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

In the name of the `cats_count` method we have used `self`. What does `self` refer to in this context?

=> Here, `self` refers to the `Cat` Class. This is how a class method is defined. So you can call `Cat.cats_count` without having to instantiate a `Cat` object.



#### Question 10

If we have the class below, what would you need to call to create a new instance of this class.

```ruby
class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end
```



We would have to call `new` with 2 arguments: color and material

```ruby
my_bag = Bag.new('red', 'leather')
```

