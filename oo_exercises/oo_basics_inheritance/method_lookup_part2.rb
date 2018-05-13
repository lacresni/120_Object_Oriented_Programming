# Using the following code, determine the lookup path used when invoking
# cat1.color. Only list the classes and modules that Ruby will check when
# searching for the #color method.

class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

=begin
Cat => no method color
Animal => no method color
Object => no method color
Kernel => no method color
BasicObject => no method color

So this leads to the following error
=> undefined method `color' for #<Cat:0x007fbb10947168> (NoMethodError)
=end
