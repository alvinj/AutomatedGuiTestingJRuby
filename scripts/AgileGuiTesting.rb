#------------------------------------------------------------------------------------
# AgileGuiTesting.rb
# Copyright 2010, Alvin J. Alexander, devdaily.com
#
# This file is part of the devdaily.com Agile GUI Testing Software.
# 
# Agile GUI Testing Software is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# Agile GUI Testing Software is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with Agile GUI Testing Software.  If not, see <http://www.gnu.org/licenses/>.
#------------------------------------------------------------------------------------

require 'java'
require 'AGTPixelColorValidator'
require 'AGTKeys'

java_import 'java.awt.MouseInfo'
java_import 'java.awt.Robot'
java_import 'java.awt.event.InputEvent'
java_import 'java.awt.event.KeyEvent'

# misc variables
@count = 0
@comments = Array.new
MENU_TEST_MODE = false

# timer variables
@t0 = nil
@t1 = nil
@t_delta = nil

# a map of keys that can't be typed directly,
# pointing to the key that must be typed in 
# combination with the [shift] key to achieve
# the desired keystroke.
@shift_key_hash = { 
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

# You can call this method at the end of each script to show
# that you script completed successfully. This is useful when
# you run a series of scripts, one after the other.
def done
  puts "Reached the end of the script."
  exit 0
end

# Write a string out to the console (stdout). Useful for debugging,
# and also for documenting pre-conditions.
def echo (data)
  puts data
end

# Not really needed by the tester. This will probably become a 
# private method.
def start_timer
  @t0 = Time.new
end

# Not really needed by the tester. This will probably become a 
# private method.
def stop_timer
  @t1 = Time.new
  @t_delta = @t1 - @t0
end

# Not really needed by the tester. This will probably become a 
# private method.
def get_elapsed_time
  @t_delta
end

# Move the mouse to the given x/y coordinates. Does not use
# animation, and also does not click at this point. Useful
# when you want to move the mouse out of the way, and will 
# likely be used later when drag and drop capabilities are added.
def move_mouse (x, y)
  @robot.mouseMove(x,y)
  sleep 0.5
end

# The same as mouse_move, but animates the mouse cursor movement
# by beginning at the current mouse position, and then moving
# smoothly to the given x/y coordinates.
def move_mouse_animated (x,y)

  # get the old auto_delay, then set it to what we
  # want it to be
  old_auto_delay = @robot.getAutoDelay
  @robot.setAutoDelay(15)

  p = MouseInfo.getPointerInfo().getLocation()
  x_last = p.x
  y_last = p.y

  x_dist = x - x_last
  y_dist = y - y_last
  x_new = x_last
  y_new = y_last
  steps = 50
  (1...steps).each { |i|
    x_new = x_new + x_dist / steps.to_f
    y_new = y_new + y_dist / steps.to_f
    @robot.mouseMove(x_new,y_new);
  }
  # just to be sure we get to the destination
  @robot.mouseMove(x,y);
  sleep 0.5
  
  # return to the previous auto_delay
  @robot.setAutoDelay(old_auto_delay)
end


# This is a special method used to click a menu item. It's not
# strictly necessary, but it allows for a  special menu and 
# menu-item testing mode, as described in the documentation.
# Our menu-method generating program calls this method for menu
# items.
def menu_item_click (x, y)
  if MENU_TEST_MODE == true
    # we're in test mode, so just move the mouse to the
    # coordinates to demonstrate that the coordinates
    # are right (or wrong)
    move_mouse_animated(x,y) 
  else
    # we're in production mode, so click the x/y coordinate
    click(x,y)
  end
end


# Does a single-click at the given x/y coordinates.
# The "delay" is the time between the mousePress and
# mouseRelease method calls. The "do_animation" field
# lets you specify whether you want to animate the mouse
# movement from the current location to the new x/y
# coordinates, prior to the click.
def click (x, y, delay=250, do_animation=true)
  if do_animation
    move_mouse_animated(x,y)
  else
    move_mouse(x,y);
  end
  @robot.mousePress(InputEvent::BUTTON1_MASK);
  @robot.delay(delay);
  @robot.mouseRelease(InputEvent::BUTTON1_MASK);
end

# Perform a mouse double-click operations at the
# given x/y coordinates.
# TODO - this currently does not let the user
# choose a "delay" or "do_animation".
def doubleclick (x, y)
  click(x, y, 0.2, false)
  click(x, y, 0.2, false)
end


#---------------------------#
# simulated-typing commands #
#---------------------------#

# TODO This method needs to become private.
# For the most part, a tester shouldn't need access
# to this.
# Characters like ':' can't be typed directly.
# You must use the character beneath them on the keyboard,
# and add in the [Shift] key.
# See the shift_key_hash hash for keys that can't be 
# typed directly.
def shift_type_keycode (i)
  @robot.keyPress(VK_SHIFT);
  @robot.keyPress(i);
  wait 250
  @robot.keyRelease(i);
  @robot.keyRelease(VK_SHIFT);
end

# Type data represented by integers or bytes, such as VK_TAB,
# or any other VK_* character. Usage is like this:
# type_keys VK_TAB
def type_keys (data)
  wait(15)
  @robot.keyPress(data)
  wait(50)
  @robot.keyRelease(data)
  wait(50)
end

def type_keycode (char_as_int)
  wait(10)
  @robot.keyPress(char_as_int)
  wait(20)
  @robot.keyRelease(char_as_int)
end


# TODO - REFACTOR this method
# Types a string of data, wherever the input focus is currently
# located. Usage is like this:
# type 'www.devdaily.com\n'
def type (data)
  
  old_auto_delay = @robot.getAutoDelay
  @robot.setAutoDelay(0)
  
  data.strip!
  data.chomp!
  # puts "TYPE: #{data}"
  count = 0
  while count < data.length

    # this gets the character (a,b,c, etc.)
    the_char = data[count,1]
    
    # this very similar call returns the ascii value
    #i = data[count]   #AJA the old (2010) approach
    i = the_char.ord

    # handle the character backslash (ascii 92) sequences
    # (like \n, \t, etc.)
    if i == 92
      # get next char
      # f=102(\f=12), n=110(10), r=114(13), t=116(9)
      c = data[count+1]
      c = c.ord  #AJA/2019: need to use this conversion
      
      # TODO - refactor all these keyPress/keyRelease sequences
      # send corresponding escape sequence
      if c == 102
        @robot.keyPress(12)
        wait(15)
        @robot.keyRelease(12)
      elsif c == 110
        @robot.keyPress(10)
        wait(15)
        @robot.keyRelease(10)
      elsif c == 114
        @robot.keyPress(13)
        wait(15)
        @robot.keyRelease(13)
      elsif c == 116
        @robot.keyPress(9)
        wait(15)
        @robot.keyRelease(9)
        
      # TODO: temporary kludge
      # make \b == backspace
      elsif c == 98
        @robot.keyPress(KeyEvent::VK_BACK_SPACE)
        wait(15)
        @robot.keyRelease(KeyEvent::VK_BACK_SPACE)
      elsif c == 100
        @robot.keyPress(KeyEvent::VK_DELETE)
        wait(15)
        @robot.keyRelease(KeyEvent::VK_DELETE)
      end
      # count as two chars
      count += 2
    else
      
      # come here for "regular" keystrokes (no backslashes)
      
      # handle the "shift" key characters first
      if @shift_key_hash.has_key?(the_char)
        #puts "\nDEBUG: Got an #{a} character (#{i})"
        key_to_press = @shift_key_hash[the_char]
        keycode = key_to_press[0]
        #keycode = c.to_i
        # call our special method to type these characters
        shift_type_keycode(keycode)
      
      # need to subtract 32 b/c java takes only the 26 cap
      # char's. need to add 'shift' to really get caps tho.
      elsif i > 31 && i < 65
        # keyboard chars (32-64); by handling the shift key
        # characters first, i should just be able to type whatever
        # comes here
        type_keycode(i)
      elsif i > 64 && i < 91
        # uppercase characters (65-90)
        shift_type_keycode(i)
        #@robot.keyPress(KeyEvent::VK_SHIFT)
        #wait(10)
        #@robot.keyPress(i)
        #wait(20)
        #@robot.keyRelease(i)
        #wait(10)
        #@robot.keyRelease(KeyEvent::VK_SHIFT)
        #wait(10)
      elsif i > 90 && i < 97
        # more keyboard chars (91-96)
        type_keycode(i)
      elsif i > 122 && i < 127
        # more keyboard chars (123-126)
        type_keycode(i)
      else
        # lowercase characters
        # java really only handles uppercase characters, so convert lowercase
        # values to uppercase here
        i = i - 32 if i > 96 && i < 123
        type_keycode(i)
        #@robot.keyPress(i)
        #wait(20)
        #@robot.keyRelease(i)
      end
      count += 1
    end
    # sleep between char entries
    # (don't forget, now have autoDelay, so this can possibly go away)
    sleep 0.1
  end

  # return to the previous auto_delay
  @robot.setAutoDelay(old_auto_delay)
  
end

# Not really needed by a tester, this will probably become
# private in the future.
def get_formatted_time
  t = Time.now
  t_out = t.strftime("(%H:%M:%S%p)")
end

# The comment method lets the tester adds a comment to a
# stack of comments. This does nothing visible, unless a test
# fails, in which case the stack of comments will be printed
# for debugging purposes.
def comment (s)
  @comments.push("#{get_formatted_time} #{s}")
end

# This is an alias for the "comment" method, so you can
# just type "c" instead of "comment".
def c (s)
  comment(s)
end

# This method writes the stack of comments, and will
# probably become a private method in the future.
def write_comments
  count = 0
  @comments.each { |c|
    count += 1
    puts "(#{count}) #{c}"
  }
end

# Tells the system to wait, similar to the Java Thread.sleep
# method. Time is in milliseconds.
def wait (time_ms)
  # AJA
  # time_ms = time_ms/1000.0
  # sleep time_ms
  @robot.delay(time_ms)
end

#
# This method means "Wait for the given RGB color at the given
# x/y coordinates. If the color does not appear withing the 
# given wait-time, exit the script (or throw an exception if the
# exception_mode paramter is supplied)."
#
# specify parameters like this:
#
#   wait_for_xycolor x, y, r, g, b, <wait-time-in-seconds>
#   wait_for_xycolor x, y, r, g, b, wait-time-in-seconds, exception_mode
#   wait_for_xycolor x, y, colorname, <wait-time-in-seconds>
#
# 'exception_mode' is a new param. set it to true if you want this method
# to throw an exception instead of exiting.
#
# if 'colorname' is used it needs to be an array with three elements, like this:
#
#    WIN2K_BG_COLOR = [233, 234, 235]
#
def wait_for_xycolor(*data)
  raise "invalid # of args to wait_for_xycolor" if data.length < 3 || data.length > 7

  pause = 30
  x = data[0]
  y = data[1]
  if data.length >= 5
    r = data[2]
    g = data[3]
    b = data[4]
    pause = data[5] if data.length >= 6
    exception_mode = data[6] if data.length == 7
  elsif data.length == 3 || data.length == 4
    colorname = data[2]
    # colorname should be an array w/ 3 elements
    raise "invalid # of elements in 'colorname' array in wait_for_xycolor" if colorname.length != 3
    r = colorname[0]
    g = colorname[1]
    b = colorname[2]
    pause = data[3] if data.length == 4
  end

  if wait_for_color(x,y,r,g,b,pause)
    sleep 0.25
  else
    # program should die here
    puts "     ***************************************"
    puts "     ********** DIED WHILE WAITING *********"
    puts "     ***************************************"
    puts "Waited #{pause} seconds, but did not find the color"
    puts "(#{r}/#{g}/#{b}) at (#{x}, #{y}), quitting"
    puts "Here are the comments you provided (in order):"
    write_comments
    if exception_mode
      raise "COLOR (#{r}/#{g}/#{b}) at (#{x}, #{y}) NOT FOUND"
    else
      exit
    end
  end
end

# Very similar to the wait_for_xycolor method, except this method
# waits for the given color at the given x/y location to go away.
# Useful for situations like waiting for a dialog to go away.
# TODO refactor this method, as it is very similar to the previous method.
#
#   wait_for_xycolor_to_go_away x, y, r, g, b, <wait-time-in-seconds>
#   wait_for_xycolor_to_go_away x, y, r, g, b, wait-time-in-seconds, exception_mode
#   wait_for_xycolor_to_go_away x, y, colorname, <wait-time-in-seconds>
#
def wait_for_xycolor_to_go_away(*data)
  raise "invalid # of args to wait_for_xycolor" if data.length < 3 || data.length > 7

  pause = 30
  x = data[0]
  y = data[1]
  if data.length >= 5
    r = data[2]
    g = data[3]
    b = data[4]
    pause = data[5] if data.length >= 6
    exception_mode = data[6] if data.length == 7
  elsif data.length == 3 || data.length == 4
    colorname = data[2]
    # colorname should be an array w/ 3 elements
    raise "invalid # of elements in 'colorname' array in wait_for_xycolor" if colorname.length != 3
    r = colorname[0]
    g = colorname[1]
    b = colorname[2]
    pause = data[3] if data.length == 4
  end

  if wait_for_color_to_go_away(x,y,r,g,b,pause)
    sleep 0.25
  else
    # program should die here
    puts "     ***************************************"
    puts "     ********** DIED WHILE WAITING *********"
    puts "     ***************************************"
    puts "Waited #{pause} seconds, but did not find the color"
    puts "(#{r}/#{g}/#{b}) at (#{x}, #{y}), quitting"
    puts "Here are the comments you provided (in order):"
    write_comments
    if exception_mode
      raise "COLOR (#{r}/#{g}/#{b}) at (#{x}, #{y}) NOT FOUND"
    else
      exit
    end
  end
end

# Gets the RGB colors at the given pixel location.
# Returns a Color object so you can use c.getRed, c.getGreen, c.getBlue
# to get the values.
def get_pixel_color (x,y)
  c = @robot.getPixelColor(x,y)
end

# Returns true if the colors are the same (well, almost the same).
def colors_are_equal (color, r, g, b)
  if (almost_equal(r, color.getRed)    && 
      almost_equal(g, color.getGreen)  &&
      almost_equal(b, color.getBlue) )
    return true
  else
    return false
  end
end

# Simulates pressing the [Control] key in combination
# with the key code you pass in. For instance, on
# Mac OS X, this works with VK_LEFT, VK_UP, VK_RIGHT, 
# and VK_DOWN to move through the Mac Spaces.
#
# Specifically, this method expects an integer
# key code, and not a string or character. I may
# modify this method to let you pass in an int,
# string, or character in the future, though I need to
# look and see if this will cause problems. For instance,
# if you type "ctrl 9", do you really want [Ctrl][9],
# or do you want [Ctrl][Tab], where the ASCII value for
# [Tab] is 9?
#
# As a practical matter, I don't use the [Ctrl] much on
# Mac OS X, so I haven't given this much thought.
# However, it needs to be consisten with other methods, like
# apple/command, alt, shift, etc. (Sorry for rambling, I'm
# tired atm.)
#
# TODO decide on this implementation
# 
def ctrl (key_code)
  wait 20
  @robot.keyPress VK_CONTROL
  wait 10
  @robot.keyPress key_code
  wait 250
  @robot.keyRelease key_code
  wait 10
  @robot.keyRelease VK_CONTROL
  wait 50
end



# Invokes the [Apple] key on a Mac OS X system.
# (Also known as the [Command] key.)
# Contract: call this method with one character  ('n', 'o')
#           or one number (VK_N, VK_O) 
#def apple (the_key)
#  apple_fixnum(the_key) if the_key.instance_of? Fixnum
#  apple_string(the_key) if the_key.instance_of? String
#  # could do this cleaner with 'overload' package, see:
#  # http://www.artima.com/forums/flat.jsp?forum=123&thread=155354
#end

# Don't call this method directly.
# TODO - make this method private.
#def apple_fixnum (the_key)
#  wait 25
#  @robot.keyPress VK_META
#  wait 25
#  @robot.keyPress the_key
#  wait 500
#  @robot.keyRelease the_key
#  wait 25
#  @robot.keyRelease VK_META
#  wait 50
#end

# Don't call this method directly.
# TODO - make this method private.
#def apple_string (c)
#  # essentially converts the string we're given to a character,
#  # then to the proper keycode
#  i = c[0].to_i
#  # notes: i really needs to be [65-90] (decimal)
#  # [A-Z] == [65-90]
#  # [a-z] == [97-122]
#  # need to subtract 32 b/c java takes only the 26 cap
#  # char's. need to add 'shift' to really get caps tho.
#  i = i - 32 if i > 96 && i < 123
#  apple_fixnum(i)
#end

# A convenience method for typing a [Tab] character.
def tab
  type_keys VK_TAB
end

# A convenience method for typing an [Enter] character.
def enter
  type_keys VK_ENTER
end

# A convenience method for typing an [Escape] character.
def esc
  type_keys VK_ESC
end

# Bring the given app name to the foreground ("TextEdit", "Google Chrome", etc.)
# Currently only works on Mac OS X
#def foreground (app_name)
#  cmd = "osascript -e 'tell application \"#{app_name}\"' -e 'activate' -e 'end tell'"
#  `#{cmd}`
#end

# TODO - add shift_tab method
# TODO - add ALT key support
# TODO - add CTRL key support
# TODO - add SHIFT key support
# TODO - add right-click support

# initialize the robot
@robot = Robot.new
@robot.setAutoDelay(40)
@robot.setAutoWaitForIdle(true)



