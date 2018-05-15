# What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata # => 'ByeBye'
puts thing.dupdata # => 'HelloHello'

=begin
On line 18, we are calling the class method dupdata.
So line 18 will output: 'ByeBye'

On line 19, we are calling the instance method dupdata on the thing object.
So this will output the duplicated content of instance variable @data:
'HelloHello'
=end
