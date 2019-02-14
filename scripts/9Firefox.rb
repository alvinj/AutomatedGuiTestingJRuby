#
# This is a test of my automated menu-generating code.
# NOTE: There is/was a problem moving the mouse cursor on 
#       Mac OS X 10.5; after clicking the menu, whenever I 
#       issued a move_mouse command, the menu would go away,
#       like I had just pressed the [Esc] key.
#       TODO - re-test this
#
require 'java'
require 'AgileGuiTesting'
require 'AGTMacOsX'

def click_firefox_about_mozilla_firefox
  move_mouse_animated 75, 33
end

def click_firefox_preferences
  move_mouse_animated 75, 64
end

def click_firefox_services
  move_mouse_animated 75, 95
end

def click_firefox_hide_firefox
  move_mouse_animated 75, 126
end

def click_firefox_hide_others
  move_mouse_animated 75, 145
end

def click_firefox_show_all
  move_mouse_animated 75, 164
end

def click_firefox_quit_firefox
  move_mouse_animated 75, 195
end

def click_file_new_window
  move_mouse_animated 131, 33
end

def click_file_new_tab
  move_mouse_animated 131, 52
end

def click_file_open_location
  move_mouse_animated 131, 71
end

def click_file_open_file
  move_mouse_animated 131, 90
end

def click_file_close_window
  move_mouse_animated 131, 109
end

def click_file_close_tab
  move_mouse_animated 131, 128
end

def click_file_save_page_as
  move_mouse_animated 131, 159
end

def click_file_send_link
  move_mouse_animated 131, 178
end

def click_file_page_setup
  move_mouse_animated 131, 209
end

def click_file_print
  move_mouse_animated 131, 228
end

def click_file_import
  move_mouse_animated 131, 259
end

def click_file_work_offline
  move_mouse_animated 131, 278
end

def click_edit_undo
  move_mouse_animated 179, 33
end

def click_edit_redo
  move_mouse_animated 179, 52
end

def click_edit_cut
  move_mouse_animated 179, 83
end

def click_edit_copy
  move_mouse_animated 179, 102
end

def click_edit_paste
  move_mouse_animated 179, 121
end

def click_edit_delete
  move_mouse_animated 179, 140
end

def click_edit_select_all
  move_mouse_animated 179, 171
end

def click_edit_find
  move_mouse_animated 179, 202
end

def click_edit_find_again
  move_mouse_animated 179, 221
end

def click_edit_special_characters
  move_mouse_animated 179, 252
end

def click_view_toolbars
  move_mouse_animated 229, 33
end

def click_view_firebug
  move_mouse_animated 229, 52
end

def click_view_status_bar
  move_mouse_animated 229, 71
end

def click_view_sidebar
  move_mouse_animated 229, 90
end

def click_view_stop
  move_mouse_animated 229, 121
end

def click_view_reload
  move_mouse_animated 229, 140
end

def click_view_zoom
  move_mouse_animated 229, 171
end

def click_view_page_style
  move_mouse_animated 229, 190
end

def click_view_character_encoding
  move_mouse_animated 229, 209
end

def click_view_page_source
  move_mouse_animated 229, 240
end

def click_view_full_screen
  move_mouse_animated 229, 259
end

def click_history_back
  move_mouse_animated 287, 33
end

def click_history_forward
  move_mouse_animated 287, 52
end

def click_history_home
  move_mouse_animated 287, 71
end

def click_delicious_save_new_bookmark
  move_mouse_animated 355, 33
end

def click_delicious_bookmarks_sidebar
  move_mouse_animated 355, 52
end

def click_delicious_bookmarks_on_delicious
  move_mouse_animated 355, 71
end

def click_window_minimize
  move_mouse_animated 553, 33
end

def click_window_zoom
  move_mouse_animated 553, 52
end

def click_firefox
  click 76, 11
end

def click_file
  click 133, 11
end

def click_edit
  click 181, 11
end

def click_view
  click 231, 11
end

def click_history
  click 290, 11
end

def click_delicious
  click 360, 11
end

def click_bookmarks
  click 438, 11
end

def click_tools
  click 507, 11
end

def click_window
  click 571, 11
end

def click_help
  click 630, 11
end


echo 'Bring Firefox to the foreground'
foreground 'Firefox'
wait 3000

click_firefox;    wait 75;   esc
click_file;       wait 75;   esc
click_edit;       wait 75;   esc
click_view;       wait 75;   esc
click_history;    wait 75;   esc
click_delicious;  wait 75;   esc
click_bookmarks;  wait 75;   esc
click_tools;      wait 75;   esc
click_window;     wait 75;   esc
click_help;       wait 75;   esc

done



click_firefox
wait 100
click_firefox_about_mozilla_firefox
wait 100
click_firefox_preferences
wait 100
click_firefox_services
wait 100
click_firefox_hide_firefox
wait 100
click_firefox_hide_others
wait 100
click_firefox_show_all
wait 100
click_firefox_quit_firefox
wait 100
esc

click_file
wait 100
click_file_new_window
wait 100
click_file_new_tab
wait 100
click_file_open_location
wait 100
click_file_open_file
wait 100
click_file_close_window
wait 100
click_file_close_tab
wait 100
click_file_save_page_as
wait 100
click_file_send_link
wait 100
click_file_page_setup
wait 100
click_file_print
wait 100
click_file_import
wait 100
click_file_work_offline
wait 100
esc

click_edit
wait 100
click_edit_undo
wait 100
click_edit_redo
wait 100
click_edit_cut
wait 100
click_edit_copy
wait 100
click_edit_paste
wait 100
click_edit_delete
wait 100
click_edit_select_all
wait 100
click_edit_find
wait 100
click_edit_find_again
wait 100
click_edit_special_characters
wait 100
esc

click_view
wait 100
click_view_toolbars
wait 100
click_view_firebug
wait 100
click_view_status_bar
wait 100
click_view_sidebar
wait 100
click_view_stop
wait 100
click_view_reload
wait 100
click_view_zoom
wait 100
click_view_page_style
wait 100
click_view_character_encoding
wait 100
click_view_page_source
wait 100
click_view_full_screen
wait 100
esc

click_history
wait 100
click_history_back
wait 100
click_history_forward
wait 100
click_history_home
wait 100
esc

click_delicious
wait 100
click_delicious_save_new_bookmark
wait 100
click_delicious_bookmarks_sidebar
wait 100
click_delicious_bookmarks_on_delicious
wait 100
esc

click_bookmarks
wait 100
esc

click_tools
wait 100
esc

click_window
wait 100
click_window_minimize
wait 100
click_window_zoom
wait 100
esc

click_help
wait 100
esc

done


