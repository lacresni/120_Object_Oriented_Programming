class MinilangRuntimeError < RuntimeError; end
class MinilangEmptyStackError < MinilangRuntimeError; end
class MinilangTokenError < MinilangRuntimeError; end

class Minilang
  def initialize(str_program)
    @str_program = str_program
    @stack = []
    @register = 0
  end

  def eval
    p @str_program
    commands = @str_program.split

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

  private

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

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
