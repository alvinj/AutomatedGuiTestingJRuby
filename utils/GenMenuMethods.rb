
#------------------------------------------------------------------------
#
# GenMenuMethods.rb
#
# Purpose: This script automatically generates all the "click" menu
#          methods for a given input file.
#
# Usage:   jruby GenMenuMethods.rb Firefox-menus.dat
#
# Output:  This creates the following output files:
#
#          FirefoxMenuMethods.rb
#          Test-Firefox-menus.rb
#
#          These two files can then be copied to your "scripts" folder,
#          and then the high-level menu items can be tested like this:
#
#          jruby Test-Firefox-menus.rb
#
#          This will go through and click all the hi-level menu items,
#          making sure the "x" values for the menus are correct.
#          Because I make assumptions about the widths of characters,
#          these x-values can be wrong, or at least a little off.
#
#------------------------------------------------------------------------

#------------------------------------------------------------------------
# TODO - create constants for the x-values so the tester only needs
#        to change the x-value in one place (i.e., firefox_x, file_x,
#        edit_x, view_x, history_x). I need to change how I write the
#        FirefoxMenuMethods.rb file, so add this when I modify that code.
#------------------------------------------------------------------------

#
# constants
#
APP_POSTFIX = 'MenuMethods.rb'
MENU_METHODS_POSTFIX = 'MenuMethods.rb'

#
# a helper class to make the array work easier
#
class AGTMenu <
  Struct.new(:menu_name, :menu_item_name)
end

def get_first_menu_x (menu_name)
  w = get_menu_width(menu_name)
  # the apple menu center x is 28; add 10 for right-padding; add 1/2 menu width
  x = 28 + 10 + w/2
end


#
# todo - get this method working
# TODO not used ???
#
def get_menu_x (menu_name, last_menu_far_right_pixel)
  w = get_menu_width_pixels(menu_name)
end

#
# the first menu item is row 1
# todo - normally ok, but need to account for SEPARATOR
#
def get_menu_item_y (row)
  # mac menubar is 21 pixels; need 3 extra pixels for some reason
  # each row is 19 pixels
  y = 24 + row*19 - 10
end


def get_menu_width_pixels (name)
  num_chars = name.length
  # width 10 (left pad), 10 (right pad), 8 (first char), 5/char,
  # (also, add 5 for a 'w', add 4 for a 'm')
  width = 10 + 10 + 8 + 5*num_chars
  name.each_char {|c|
    width = width + 1 if c == 'a'
    width = width + 4 if c == 'B'
    width = width + 4 if c == 'D'
    width = width + 1 if c == 'e'
    width = width + 1 if c == 'E'
    width = width + 1 if c == 'F'
    width = width + 2 if c == 'k'
    width = width + 5 if c == 'm'
    width = width + 4 if c == 'M'
    width = width + 3 if c == 'O'
    width = width + 3 if c == 'o'
    width = width + 1 if c == 'P' # guess
    width = width + 3 if c == 'Q' # guess
    width = width + 5 if c == 'S'
    width = width + 5 if c == 'T'
    width = width + 3 if c == 'Y' # guess
    width = width + 4 if c == 'w'
    width = width + 5 if c == 'W'
    #width = width - 1 if c == 'i'
  }
  return width
end

def get_num_rows (file)
  num_rows = 0
  File.readlines(file).each do |line|
    num_rows = num_rows + 1
  end
  num_rows
end

#
# returns an array of the top-level menu names
# (File, Edit, View, ...)
#
def get_top_level_menu_names (menu_array)

  top_menus = Array.new

  # start looping through all the menus and menu items
  last_menu = 'x987Zygf'
  menu_array.each do |m|
    # m1 is menu_name, m2 is an optional menu_item_name
    m1 = m.menu_name.downcase
    m2 = m.menu_item_name.downcase

    if m1 == 'separator' || m1.match('---')
      next
    elsif m1 == ''
      next
    elsif m1 == last_menu
      next
    else
      if m2 == ''
        top_menus.push(m1)
      end
    end
    last_menu = m1
  end # end do
  
  return top_menus
end

# takes an array of strings, and determines the length
# of the longest string in the array
def get_max_num_chars (top_menus)
  max = 0
  top_menus.each do |m|
    max = m.length if m.length > max
  end
  return max
end

def write_test_menus_file (app_name, menu_array)

  filename = "Test-#{app_name}-menus.rb"
  
  top_menus = get_top_level_menu_names(menu_array)

  open(filename, 'w') do |f|
    f.puts "#"
    f.puts "# This is a small, auto-generated jruby script that can be used"
    f.puts "# to help make sure the x/y menu coordinates have been"
    f.puts "# calulated correctly."
    f.puts "#"
    f.puts "# this script specifically only tests the top-level"
    f.puts "# menus, not the menu items, so ..."
    f.puts "# RUN THIS TEST first. Run it like this:"
    f.puts "#"
    f.puts "# jruby #{filename}"
    f.puts "#"

    f.puts "require 'java'"
    f.puts "require 'AgileGuiTesting'"
    f.puts "require 'AGTMacOsX'"
    
    # TODO FIXTHIS
    f.puts "require '#{app_name}#{APP_POSTFIX}'"
    f.puts ""
    f.puts "# this tells the agt system we want to test the menu system"
    f.puts "MENU_TEST_MODE = true"
    f.puts ""

    f.puts ""
    f.puts "echo '*** BRING YOUR APPLICATION TO THE FOREGROUND NOW ***'"
    f.puts "wait 5000"
    f.puts ""

    # do some crazy work to get the output to line up properly
    max_width = get_max_num_chars(top_menus)
    widest = max_width + 1     # go a little wider than the widest
    top_menus.each do |m|
      w = m.length             # width of current menu name
      diff = widest - w        # diff compared to widest name
      diff.times {
        m = m + ' '
      }
      f.puts "click_#{m};    wait 75;  esc"
    end # end do

    f.puts ""
    f.puts "done"
    f.puts ""
  end # open and f.puts

end


# gets the "application name" from the naming convention of the
# input file.  legit filenames must follow these formats:
#    Firefox.dat
#    Firefox-menus.dat
#    Firefox.mnu
def get_appname_from_input_filename (input_filename)
  p1 = input_filename.split('.')  # Firefox-menus.dat => ["Firefox-menus", "dat"]
  p2 = p1[0]                      # "Firefox-menus"
  p3 = p2.split('-')              # "Firefox-menus" => ["Firefox", "menus"]
  p4 = p3[0]                      # "Firefox"
  return p4
end


### MAIN ###

unless ARGV.length == 1
  puts "Dude, not the right number of arguments."
  puts "Usage: ruby GenMenuMethods.rb InputFile.txt"
  puts ""
  exit
end

input_file = ARGV[0]

# determine the app name from the input filename
APPNAME = get_appname_from_input_filename(input_file)

# read all the input file records into an array
menu_items = Array.new
File.readlines(input_file).each do |line|
  line.chomp!
  
  # skip blank lines
  next if line.strip == ''
  
  fields = line.split('|')
  m_name = fields[0].tr_s('"', '').strip
  mi_name = ''
  if fields.length > 1
    mi_name = fields[1].tr_s('"', '').strip  
  end

  m = AGTMenu.new
  m.menu_name = m_name
  m.menu_item_name = mi_name

  menu_items.push(m)
end

# now have all the data

# write the "test menus" script (firefox-test-menus.rb).
# this lets the user test that the top-level x/y coordinates for 
# the menus (File, Edit, View ... Help) are in the correct locations.
write_test_menus_file(APPNAME, menu_items)


# now have all the data, build the menus
row = 0
x_left = x_middle = x_right = 0

# the initial y value for menus (File, Edit, etc.)
Y_MENU = 11
y = y_last = Y_MENU

# do some initial work for the first menu (typically the "File" menu)
last_menu = 'TheAppleMenu'
# with padding, the apple menu seems to end at 44
x_right = 44

just_handled_new_menu = false

# TODO clean up this code; this is where the "menu methods"
#      file is written

menu_methods_filename = "#{APPNAME}#{MENU_METHODS_POSTFIX}"
open(menu_methods_filename, 'w') do |f|

  f.puts "#"
  f.puts "# these are the auto-generated menu-click methods for "
  f.puts "# testing the #{APPNAME} application."
  f.puts "#"
  f.puts ""

  # start looping through all the menus and menu items
  menu_items.each do |m|
    # m1 is menu_name, m2 is an optional menu_item_name
    m1 = m.menu_name.downcase
    m2 = m.menu_item_name.downcase
    m2 = m2.tr_s('\.\.\.', ' ').rstrip.tr_s(' ', '_')

    if m1 == 'separator' || m1.match('---')
      # increment y, and go on to next menu item
      y = y_last + 12
      y_last = y
      just_handled_new_menu = false
      next
    elsif m1 == ''
      next
    elsif m1 == last_menu
      # still working on the current menu
      # x: no change
      y = y_last + 19
      just_handled_new_menu = false
    else
      # just starting to work on a new menu
      # x:
      width = get_menu_width_pixels(m1)
      x_left = x_right
      x_middle = x_left + width/2
      x_right = x_left + width

      # y: for a new menu, use Y_MENU
      y = y_last = Y_MENU
  
      just_handled_new_menu = true
    end

    # if ms is blank, you're working on a high-level menu item,
    # like a File, Edit, View menu, so write the code for it
    if m2 == ''
      f.puts "def click_#{m1}"
      f.puts "  click #{x_middle}, #{y}"
      f.puts "end"
      f.puts ""
    else
      # otherwise, we're working on the code for a menu item, so write
      # the code for it
      f.puts "def click_#{m1}_#{m2}"
      f.puts "  menu_item_click #{x_middle}, #{y}"
      f.puts "end"
      f.puts ""
    end

    last_menu = m1
    row = row + 1

    if just_handled_new_menu
      # fudge extra pixels for first menu item
      y_last = y + 3
    else
      y_last = y
    end
    
  end # end do
  
end # end file open/write

exit








