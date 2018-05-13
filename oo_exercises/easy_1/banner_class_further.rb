# Complete this class so that the test cases shown below work as intended.
# You are free to add any methods or instance variables you need.
# However, do not make the implementation details public.
#
# You may assume that the input will always fit in your terminal window.
require 'pry'

class Banner
  MAX_WIDTH = 80

  def initialize(message, fixed_width = MAX_WIDTH)
    @message = message
    update_fixed_width(fixed_width)
  end

  def to_s
    [horizontal_rule,
     empty_line,
     message_line,
     empty_line,
     horizontal_rule].flatten.join("\n")
  end

  private

  def longest_word
    return 0 if @message == ''
    @message.split.map(&:size).max
  end

  def update_fixed_width(width)
    @fixed_width = if width > MAX_WIDTH
                     MAX_WIDTH
                   elsif width < longest_word
                     longest_word
                   else
                     width
                   end
  end

  def horizontal_rule
    "+-#{'-' * @fixed_width}-+"
  end

  def empty_line
    "| #{' ' * @fixed_width} |"
  end

  def message_line
    words = @message.split(' ')
    lines = []
    str = ''
    until words.empty?
      word = words.first
      size = str.size + word.size
      if size <= @fixed_width
        str += "#{word} "
        words.shift
      end

      if size > @fixed_width || words.empty?
        lines << "| #{str.strip.center(@fixed_width)} |"
        str = ''
      end
    end
    lines
  end
end

banner = Banner.new('To boldly go where no one has gone before.', 20)
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('', 0)
puts banner
# +--+
# |  |
# |  |
# |  |
# +--+
