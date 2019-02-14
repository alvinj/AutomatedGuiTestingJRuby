#
# This is a test script to show you how to bring a program
# like TextEdit to the foreground, and enter text into it.
#
require 'java'
require 'AgileGuiTesting'

foreground 'TextEdit'
wait 2000

c 'move the mouse into the TextEdit area'
click 35, 130
wait 500

# a string with '\n'
type 'Hello, world. This is Alvin Alexander, with devdaily.com.\n'

# a string followed by an enter keystroke
type 'I hope you like our Agile GUI Testing program.'
enter

