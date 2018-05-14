# Consider the following class definition:
class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

# There is nothing technically incorrect about this class,
# but the definition may lead to problems in the future.
# How can this class be fixed to be resistant to future problems?
=begin
My thoughts:
Flight class has a setter method defined for @database_handle instance variable.
This means that anyone knowing the Flight object can also modify the database_handle.

`attr_accessor` method should be replaced by `attr_reader` method

LaunchSchool solution:
Delete line 3 'attr_accessor :database_handle`
Database looks like an implementation detail and thus should not be provided
outside the class.
If we don't remove it and someone uses it in its code then it will much more
difficult to make some modifications to remove it later from this class...
=end
