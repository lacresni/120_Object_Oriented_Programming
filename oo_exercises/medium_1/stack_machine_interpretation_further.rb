class MinilangRuntimeError < RuntimeError; end
class MinilangEmptyStackError < MinilangRuntimeError; end
class MinilangTokenError < MinilangRuntimeError; end

class Minilang
  def initialize(str_program)
    @str_program = str_program
    @stack = []
    @register = 0
  end

  def eval_c2f(degrees_c:)
    puts "#{degrees_c} celsius degrees = (in fahrenheit degrees)"

    commands = format(@str_program, degrees_c: degrees_c).split
    eval_program(commands)
  end

  def eval_f2c(degrees_f:)
    puts "#{degrees_f} fahrenheit = (in celsius degrees)"

    commands = format(@str_program, degrees_f: degrees_f).split
    eval_program(commands)
  end

  def eval_mph2kmh(mph:)
    puts "#{mph} mph = (in km/h)"

    commands = format(@str_program, mph: mph).split
    eval_program(commands)
  end

  def eval_area(length_a:, length_b:)
    puts "The rectangle area is #{length_a} * #{length_b} ="

    commands = format(@str_program, length_a: length_a, length_b: length_b).split
    eval_program(commands)
  end

  private

  def eval_program(commands)
    begin
      commands.each do |cmd|
        case cmd
        when 'PRINT' then print
        when 'PUSH' then push
        when 'POP' then pop
        when 'MULT' then mult
        when 'DIV' then div
        when 'MOD' then mod
        when 'ADD' then add
        when 'SUB' then sub
        else
          if valid_number?(cmd)
            @register = cmd.to_i
          else
            raise MinilangTokenError.new("Invalid token: #{cmd}")
          end
        end
      end
    rescue MinilangRuntimeError => e
      puts e.message
    end
  end

  def valid_number?(cmd)
    cmd.to_i.to_s == cmd
  end

  def print
    puts @register
  end

  def push
    @stack.push(@register)
  end

  def pop
    @register = stack_pop
  end

  def mult
    @register *= stack_pop
  end

  def div
    @register /= stack_pop
  end

  def add
    @register += stack_pop
  end

  def sub
    @register -= stack_pop
  end

  def mod
    @register %= stack_pop
  end

  def stack_pop
    raise MinilangEmptyStackError.new("Empty stack!") if @stack.empty?
    @stack.pop
  end
end

CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
minilang_celsius_to_fahrenheit = Minilang.new(CENTIGRADE_TO_FAHRENHEIT)
minilang_celsius_to_fahrenheit.eval_c2f(degrees_c: 100)
# 212
minilang_celsius_to_fahrenheit.eval_c2f(degrees_c: 0)
# 32
minilang_celsius_to_fahrenheit.eval_c2f(degrees_c: -40)
# -40

FAHRENHEIT_TO_CENTIGRADE =
  '9 PUSH 5 PUSH 32 PUSH %<degrees_f>d SUB MULT DIV PRINT'
minilang_fahrenheit_to_celsius = Minilang.new(FAHRENHEIT_TO_CENTIGRADE)
minilang_fahrenheit_to_celsius.eval_f2c(degrees_f: 50)
# 10

MILES_TO_KILOMETERS_PER_HOUR =
  '1000 PUSH 1609 PUSH %<mph>d MULT DIV PRINT'
minilang_mph_to_kmh = Minilang.new(MILES_TO_KILOMETERS_PER_HOUR)
minilang_mph_to_kmh.eval_mph2kmh(mph: 30)

RECTANGLE_AREA =
  '%<length_a>d PUSH %<length_b>d MULT PRINT'
minilang_area = Minilang.new(RECTANGLE_AREA)
minilang_area.eval_area(length_a: 25, length_b: 4)
# 100
