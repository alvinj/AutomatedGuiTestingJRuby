require 'java'
require 'AgileGuiTesting'

foreground 'Google Chrome'
wait 3000

c 'get the mouse out of the way'
move_mouse_animated 30, 200
wait 250

apple VK_L

type 'www.devdaily.com \n'
wait 2000

c 'new tab, then go to oma site'
apple 't'

c 'go to the OMA site; url field automatically gains focus'
type 'www.onemansalaska.com \n'


