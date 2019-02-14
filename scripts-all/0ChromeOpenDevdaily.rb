require 'java'
require 'AgileGuiTesting'
require 'Keys'

def fg_chrome
  cmd = "osascript -e 'tell application \"Google Chrome\"' -e 'activate' -e 'end tell'"
  `#{cmd}`
end

#echo 'this is a demo script to demonstrate XGT.'
#echo 'we\'ll just tell the chrome browser to go to devdaily.com'

#echo 'make sure chrome is aligned to the top of the screen.'
#echo 'also, make sure you\'re on some other website besides devdaily.'

#comment 'waiting five seconds'
fg_chrome
wait 3000

# click File, then Location
#click 136, 15, 100, false
#click 158, 130, 100, false
#move_mouse_animated 20, 80
#click 30, 100, 100, false
#wait 1000

include_class 'java.awt.Toolkit'
include_class 'javax.swing.KeyStroke'

wait 250

@robot.keyPress VK_META
wait 25
@robot.keyPress(76)
wait 500
@robot.keyRelease(76)
wait 25
@robot.keyRelease VK_META

#shortcut = Toolkit::getDefaultToolkit().getMenuShortcutKeyMask()
#command_l = KeyStroke::getKeyStroke(KeyEvent::VK_L, shortcut)
#wait 250
#@robot.keyPress(command_l.getKeyCode)
#wait 250
#@robot.keyRelease(command_l.getKeyCode)
#wait 250



#puts command_l

type 'www.devdaily.com \n'
wait 3000

# TODO fix this
#comment 'waiting for the devdaily blue colorbar to appear'
#fg_chrome
#wait_for_xycolor 914, 100, 255, 255, 255
# kludge
#wait 1000

#comment Click File, then Click New Tab
#click 136, 15, 25, false
#wait 250
#comment 'click New Tab'
#click 136, 36, 25, false

# go to the OMA site; url field automatically gains focus
#move_mouse_animated 10, 80
#wait 2000
#type 'www.onemansalaska.com \n'

#wait 2000





