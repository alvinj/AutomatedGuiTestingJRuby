#------------------------------------------------------------------------------------
# MacOsX.rb
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

voices = [ "Agnes", "Albert", "Bad News", "Bahh", "Bells", "Boing", 
           "Bruce", "Bubbles", "Cellos ", "Deranged", "Fred", "Good News", 
           "Hysterical", "Junior", "Kathy", "Princess", "Pipe Organ", "Ralph", 
           "Trinoids", "Vicki", "Victoria", "Whisper", "Zarvox" ]

# Invokes the [Apple] key on a Mac OS X system.
# (Also known as the [Command] key.)
# Contract: call this method with one character ('n', 'o')
#           or one number (VK_N, VK_O), and it will invoke
#           [Command][n] (or whatever character you give it)
# def apple (the_key)
#   apple_fixnum(the_key) if the_key.instance_of? Fixnum
#   apple_string(the_key) if the_key.instance_of? String
#   # could do this cleaner with 'overload' package, see:
#   # http://www.artima.com/forums/flat.jsp?forum=123&thread=155354
# end


def apple (the_key)
  if the_key.instance_of? Integer
    apple_fixnum(the_key)
  elsif the_key.instance_of? String
    apple_string(the_key)
  end
  # could do this cleaner with 'overload' package, see:
  # http://www.artima.com/forums/flat.jsp?forum=123&thread=155354
end



# Don't call this method directly.
# TODO - make this method private.
def apple_fixnum (the_key)

  old_auto_delay = @robot.getAutoDelay
  @robot.setAutoDelay(0)

  wait 10
  @robot.keyPress VK_META
  wait 10
  @robot.keyPress the_key
  wait 200
  @robot.keyRelease the_key
  wait 10
  @robot.keyRelease VK_META
  wait 50

  # return to the previous auto_delay
  @robot.setAutoDelay(old_auto_delay)

end

# Don't call this method directly.
# TODO - make this method private.
def apple_string (c)
  # essentially converts the string we're given to a character,
  # then to the proper keycode
  
  #AJA/2019 this helped so that [Command][t] worked
  #i = c[0].to_i
  i = c[0].ord
  
  # notes: i really needs to be [65-90] (decimal)
  # [A-Z] == [65-90]
  # [a-z] == [97-122]
  # need to subtract 32 b/c java takes only the 26 cap
  # char's. need to add 'shift' to really get caps tho.
  i = i - 32 if i > 96 && i < 123
  apple_fixnum(i)
end

# Bring the given app name to the foreground ("TextEdit", "Google Chrome", etc.)
# Currently only works on Mac OS X
def foreground (app_name)
  cmd = "osascript -e 'tell application \"#{app_name}\"' -e 'activate' -e 'end tell'"
  `#{cmd}`
end

def speak (text, voice="Vicki")
  q = '"'
  cmd = "osascript -e 'say \"#{text}\" using \"#{voice}\"'"
  `#{cmd}`
end

#speak "welcome. today we will be testing the google chrome browser", "victoria"
#speak "hello, al"
#speak "dev daily dot com", "cellos"
#speak "I could do this all day", "ralph"

