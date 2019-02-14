# jruby

require 'java'
require 'AGTImageRecognition'
require 'AgileGuiTesting'

# test - find the image of the moose on the OMA website

def fg_chrome
  cmd = "osascript -e 'tell application \"Google Chrome\"' -e 'activate' -e 'end tell'"
  `#{cmd}`
end

fg_chrome
wait 3000

# this works (looking for blue strip on oma web page)
#wait_for_xycolor(494, 142, 0, 52, 105, 10)

# find the picture of the moose on-screen
# this works when i use my screen-capture tool to make the image
(x,y) = find_image_click_coordinates 'moose-4.jpg'
p "x = #{x}"
p "y = #{y}"
move_mouse_animated(x,y) if x != -1


#small_image = open_image_file 'images/OKButton.png'
#small_image = open_image_file 'images/CancelButton.png'
#(x,y) = find_image_click_coordinates small_image
#p x
#p y
#click x, y if x != -1

