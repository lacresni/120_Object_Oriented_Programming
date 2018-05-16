# What is wrong with the following code? What fix(es) would you make?

=begin
  In to_s method on line 13, we are calling a private method with self.
  This is not authorized because self represents the calling object when used
  within an instance method.So this code will raise an exception...
=> private method `expand' called for #<Expander:0x007f7fe594b670 @string
="xyz"> (NoMethodError)

  One way to fix this is to remove self from line 13
=end

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    # self.expand(3)
    expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander
