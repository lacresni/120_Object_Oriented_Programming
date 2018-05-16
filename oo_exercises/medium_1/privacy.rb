# Modify this class so both flip_switch and the setter method switch= are
# private methods.

class Machine

  def start
    flip_switch(:on)
  end

  def stop
    flip_switch(:off)
  end

  def switch_state
    switch
  end

  private

  attr_reader :switch
  attr_writer :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

my_machine = Machine.new
my_machine.start
puts my_machine.switch_state
my_machine.stop
puts my_machine.switch_state
