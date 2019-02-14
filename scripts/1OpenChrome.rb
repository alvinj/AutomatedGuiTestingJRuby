require 'java'
require 'AgileGuiTesting'
require 'AGTMacOsX'

#----------------------------------------------------------------
# PURPOSE: A little script to demonstrate AGT with Google Chrome.
# PRECONDITIONS:
#   - You’re running a MacOS system
#   - Chrome is installed
#   - Chrome is not running
# POSTCONDITIONS:
#   - Chrome will be left open, with two new tabs open
#----------------------------------------------------------------

foreground 'Google Chrome'

# i should use a `wait_for_color` or `wait_for_image` call here, 
# but i'm being lazy
wait 3000

c 'get the mouse out of the way'
move_mouse_animated 30, 200
wait 250

# note: the VK_* keys are defined in AGTKeys.rb, and get imported here,
# so this is not a string, it refers to `KeyEvent::VK_L`.
c 'putting focus in the Chrome url field'
apple VK_L

# note: could use VK_ENTER at the end, but that’s more work
c 'opening AA.COM ...'
type 'alvinalexander.com \n'

c 'waiting X seconds ...'
wait 4000

c 'new tab, then go to oma site'
apple 't'

# used to be a `\n` at the end of this string
c 'go to the OMA site; url field should automatically gain focus'
type 'www.onemansalaska.com \n'



