# A fixed-length array is an array that always has a fixed number of elements.
# Write a class that implements a fixed-length array, and provides the necessary
# methods to support the following code:
#
# The code below should output true 15 times.
require 'pry'

class FixedArray
  def initialize(nb_elements)
    @fixed_array = Array.new(nb_elements)
  end

  def [](index)
    # I could have used Array#fetch method that throws an IndexError
    # exception automatically if index is out of bounds
    check_index_validity(index)
    @fixed_array[index]
  end

  def []=(index, value)
    # check_index_validity(index)
    @fixed_array[index] = value
  end

  def to_a
    # use of clone is mandatory to avoid any further mutating call on
    # @fixed_array by the requester of this method
    @fixed_array.clone
  end

  def to_s
    @fixed_array.to_s
  end

  private

  def check_index_validity(index)
    raise IndexError.new("out of bounds") unless index < @fixed_array.size
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end
