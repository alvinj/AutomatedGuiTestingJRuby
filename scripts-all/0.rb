#
# This is a test script to show you how to bring a program
# like TextEdit to the foreground, and enter text into it.
#
require 'java'
require 'AGTKeys'
require 'MacOsX'

include_class 'java.awt.MouseInfo'
include_class 'java.awt.Robot'
include_class 'java.awt.event.InputEvent'
include_class 'java.awt.event.KeyEvent'

shift_key_hash = { 
  ':' => ';', '"' => "'",
  '<' => ',', '>' => '.',
  '?' => '/', '{' => '[',
  '}' => '',  '|' => '\\',
  '_' => '-', '+' => '=',
  '~' => '`', '!' => '1',
  '@' => '2', '#' => '3',
  '$' => '4', '%' => '5',
  '^' => '6', '&' => '7',
  '*' => '8', '(' => '9',
  ')' => '0'
}

#shift_key_hash = Hash.new
#shift_key_hash[':'] = ';'
#shift_key_hash['"'] = "'"
#shift_key_hash['<'] = ','
#shift_key_hash['>'] = '.'
#shift_key_hash['?'] = '/'
#shift_key_hash['{'] = '['
#shift_key_hash['}'] = ']'
#shift_key_hash['|'] = '\\'
#shift_key_hash['_'] = '-'
#shift_key_hash['+'] = '='
#shift_key_hash['~'] = '`'
#shift_key_hash['!'] = '1'
#shift_key_hash['@'] = '2'
#shift_key_hash['#'] = '3'
#shift_key_hash['$'] = '4'
#shift_key_hash['%'] = '5'
#shift_key_hash['^'] = '6'
#shift_key_hash['&'] = '7'
#shift_key_hash['*'] = '8'
#shift_key_hash['('] = '9'
#shift_key_hash[')'] = '0'

@robot = Robot.new
@robot.setAutoDelay(40)
@robot.setAutoWaitForIdle(true)

def wait (time_ms)
  @robot.delay(time_ms)
end

def type (data)
  
  data.strip!
  data.chomp!
  count = 0

  while count < data.length
    # returns the ascii value
    a = data[count]
    i = a.to_i

    wait(20)
    @robot.keyPress(i)
    wait(100)
    @robot.keyRelease(i)
    wait(20)

    count += 1
    sleep 0.1
  end
end

# TODO This method needs to become private.
# For the most part, a tester shouldn't need access
# to this.
# Characters like ':' can't be typed directly.
# You must use the character beneath them on the keyboard,
# and add in the [Shift] key.
# See the shift_key_hash hash for keys that can't be 
# typed directly.
def shift_type (i)
  @robot.keyPress(VK_SHIFT);
  @robot.keyPress(i);
  wait 250
  @robot.keyRelease(i);
  @robot.keyRelease(VK_SHIFT);
end

def key_with_mask (i)
  @robot.keyPress(SHIFT_DOWN_MASK + i);
  wait 250
  @robot.keyRelease(SHIFT_DOWN_MASK + i);
end

wait 4000

#c 'move the mouse into the TextEdit area'
#click 35, 130
#wait 500

# SHIFT_MASK
# SHIFT_DOWN_MASK
# VK_SHIFT

# passed
#a = [ ':', '<', '>', '?', '\\', '|' ]
#a = [ '!', '@', '#', '$' ]
#a = [ '%', '^', '&', '*', '(', ')', '_', '+' ]
# not working:
# a = [ "\"" ]
# a = [ '~' ]
#a = [ '"' ]
a = [ '%', '^', '&', '*', '(', ')', '_', '+' ]
a.each { |char| 
  if shift_key_hash.has_key?(char)
    key_to_press = shift_key_hash[char]
    c = key_to_press[0]
    i = c.to_i
    # normally good
    shift_type(i)
    puts "i = #{i}"
  end
}


# NONE OF THESE WORK
#type '< > ? : " { } | ~ ! @ # $ % ^ & * ( ) _ +'







