#
# This is a small, auto-generated jruby script that can be used
# to help make sure the x/y menu coordinates have been
# calulated correctly.
#
# this script specifically only tests the top-level
# menus, not the menu items, so ...
# RUN THIS TEST first. Run it like this:
#
# jruby Test-Firefox-menus.rb
#
require 'java'
require 'AgileGuiTesting'
require 'AGTMacOsX'
require 'FirefoxMenuMethods.rb'

# this tells the agt system we want to test the menu system
MENU_TEST_MODE = true


echo '*** BRING YOUR APPLICATION TO THE FOREGROUND NOW ***'
wait 5000

click_firefox   ;    wait 75;  esc
click_file      ;    wait 75;  esc
click_edit      ;    wait 75;  esc
click_view      ;    wait 75;  esc
click_history   ;    wait 75;  esc
click_delicious ;    wait 75;  esc
click_bookmarks ;    wait 75;  esc
click_tools     ;    wait 75;  esc
click_window    ;    wait 75;  esc
click_help      ;    wait 75;  esc

done

