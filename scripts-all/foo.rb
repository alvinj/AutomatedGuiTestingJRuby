
require 'java'
require 'AgileGuiTesting'
require 'Keys'

# String
# Fixnum

def apple_fixnum (num)
  puts "num: #{num}"
end

def apple_string (string)
  puts "string: #{string}"
end

def apple (data)
  apple_fixnum(data) if data.instance_of? Fixnum
  apple_string(data) if data.instance_of? String
end

apple 't'
apple VK_T

