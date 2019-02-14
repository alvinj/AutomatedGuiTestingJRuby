require 'AgileGuiTesting'

def fg_chrome
  cmd = "osascript -e 'tell application \"Google Chrome\"' -e 'activate' -e 'end tell'"
  `#{cmd}`
end

#comment 'waiting five seconds'
fg_chrome
wait 3000

# click url field
click 466, 55

# click File
#click 136, 15, 100, false

# click Location
#click 158, 130, 100, false
move_mouse 700, 15
wait 1000

type 'www.devdaily.com \n'
wait 500



