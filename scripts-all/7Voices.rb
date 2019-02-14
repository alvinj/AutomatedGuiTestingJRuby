#
# gui regression tests for google chrome
#
require 'java'
require 'AgileGuiTesting'
require 'MacOsX'

voices = [ "Alex", "Ralph", "Bruce", "Fred", "Junior", "Princess" ]

#voices = [ "Agnes", "Albert", "Bad News", "Bahh", "Bells", "Boing", 
#           "Bruce", "Bubbles", "Cellos ", "Deranged", "Fred", "Good News", 
#           "Hysterical", "Junior", "Kathy", "Princess", "Pipe Organ", "Ralph", 
#           "Trinoids", "Vicki", "Victoria", "Whisper", "Zarvox" ]

#voices = [ "Agnes", "Bruce", "Fred",  
#           "Junior", "Kathy", 
#           "Ralph", "Trinoids", "Vicki", "Victoria" ]

voices.each { |v|

  #speak "My name is #{v}", v
  speak "Good morning Dave. How can I help you?", v


}

