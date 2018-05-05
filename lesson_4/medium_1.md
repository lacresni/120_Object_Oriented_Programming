# Practice Problems: Medium 1

#### Question 1

Ben asked Alyssa to code review the following code:

```ruby
class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end
```

Alyssa glanced over the code quickly and said - "It looks fine, except that you forgot to put the `@` before `balance` when you refer to the balance instance variable in the body of the `positive_balance?` method."

"Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an `@`!"

Who is right, Ben or Alyssa, and why?

=> In fact, they are both right. But I think Ben's solution is better.

Alyssa thinks `balance` instance variable cannot be referenced without `@` on line 9. I agree that adding `@` before `balance` would work and code would behave the same way. However, Ben has defined a getter accessor for instance variable `balance` on line 2. This automatically creates a method named `balance` that returns the value of instance variable `@balance`. Thus, he's perfectly right to have written line 9 this way. It is even recommended to use getter method instead of instance variable directly if getter method is available.



#### Question 2

Alyssa created the following code to keep track of items for a shopping cart application she's writing:

```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end
```

Alan looked at the code and spotted a mistake. "This will fail when `update_quantity` is called", he says.

Can you spot the mistake and how to address it?

=> `quantity` variable on line 11 is not the instance variable `@quantity`. It is just a local variable to the method `update_quantity`.

This mistake can be addressed in two different ways:

* By using instance variable `@quantity` directly in the instance method `update_quantity`

```ruby
  def update_quantity(updated_count)
    # prevent negative quantities from being set
    @quantity = updated_count if updated_count >= 0
  end
```

* By defining a setter method for instance variable `@quantity` (with `attr_accessor` method) and using this setter method in the instance method `update_quantity`

```ruby
class InvoiceEntry
  attr_accessor :quantity
  attr_reader :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end
end
```



#### Question 3

In the last question Alyssa showed Alan this code which keeps track of items for a shopping cart application:

```ruby
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end
```

Alan noticed that this will fail when `update_quantity` is called. Since quantity is an instance variable, it must be accessed with the `@quantity` notation when setting it. One way to fix this is to change `attr_reader` to `attr_accessor` and change `quantity` to `self.quantity`.

Is there anything wrong with fixing it this way?

=> Except that it adds "complexity" to the method because it adds a method call (setter method), I don't see anything wrong.

**LaunchSchool explanation**

Nothing incorrect syntactically. However, you are **altering the public interfaces of the class**. In other words, you are now allowing clients of the class to **change the quantity directly** (calling the accessor with the `instance.quantity = <new value>` notation) rather than by going through the `update_quantity` method. It means that the protections built into the `update_quantity` method can be circumvented and potentially pose problems down the line.



#### Question 4

Let's practice creating an object hierarchy.

Create a class called `Greeting` with a single method called `greet` that takes a string argument and prints that argument to the terminal.

Now create two other classes that are derived from `Greeting`: one called `Hello` and one called `Goodbye`. The `Hello` class should have a `hi` method that takes no arguments and prints "Hello". The `Goodbye` class should have a `bye` method to say "Goodbye". Make use of the `Greeting` class `greet` method when implementing the `Hello` and `Goodbye` classes - do not use any `puts` in the `Hello` or `Goodbye` classes.

```ruby
class Greeting
  def greet(msg)
    puts msg
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class GoodBye < Greeting
  def bye
    greet("Goodbye")
  end
end
```



#### Question 5

You are given the following class that has been implemented:

```ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
end
```

And the following specification of expected behavior:

```ruby
donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  => "Plain"

puts donut2
  => "Vanilla"

puts donut3
  => "Plain with sugar"

puts donut4
  => "Plain with chocolate sprinkles"

puts donut5
  => "Custard with icing"
```

Write additional code for `KrispyKreme` such that the `puts` statements will work as specified above.

```ruby
class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end

  def to_s
    str = @filling_type ? @filling_type : "Plain"
    str += " with #{@glazing}" if @glazing
    str
  end
end
```



#### Question 6

If we have these two methods:

```ruby
class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end
```

and

```ruby
class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end
```

What is the difference in the way the code works?

There's actually no difference in the result, only in the way each example accomplishes the task.

On line 5, we are assigning the instance variable `@template` directly to the string object `"template 14231"` whereas, in the second example, we are using the setter method `template=` to assign the instance variable `@template`. `self` is used to force Ruby to understand that this is a setter method call.

In the first example, on line 9, `show_template` method references the `template` getter method defined on line 2 with `attr_accessor :template`. This method returns the value of the instance variable `@template` which is also implicitly returned by `show_template` method. In the second example, getter method `template` is accessed by the mean of `self`. This is syntactically correct but it is not necessary because Ruby is able to reference the getter method `template` without using `self`.

Both examples are technically fine, however, the general rule from the [Ruby style guide](https://github.com/bbatsov/ruby-style-guide#no-self-unless-required) is to `"Avoid self where not required."`



#### Question 7

How could you change the method name below so that the method name is more clear and less repetitive.

```ruby
class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.light_information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end
```

=> `light_information` is a class method of `Light` class and is mandatory called using the class name (ex `Light.light_information`). So there is no need to include `light` in the method's name. It could have been simply named:

```ruby
  def self.information
    "I want to turn on the light with a brightness level of super high and a colour of green"
  end
```