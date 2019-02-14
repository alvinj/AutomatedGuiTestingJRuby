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

@robot = Robot.new
@robot.setAutoDelay(40)
@robot.setAutoWaitForIdle(true)

def wait (time_ms)
  @robot.delay(time_ms)
end

wait 2000

# move down to the Space below
ctrl VK_DOWN
ctrl VK_RIGHT
ctrl VK_UP
ctrl VK_LEFT


