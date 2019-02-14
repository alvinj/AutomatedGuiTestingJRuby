# this is a jruby script
# this script requires the Java class "FindSmallImageInLarge"

require 'java'

# image recognition code
require 'AGTPlayer.jar'

java_import 'java.awt.Robot'
java_import 'java.awt.Toolkit'
java_import 'java.awt.Dimension'
java_import 'java.awt.Rectangle'
java_import 'java.awt.image.BufferedImage'
java_import 'javax.imageio.ImageIO'
java_import 'com.devdaily.agtplayer.FindSmallImageInLarge'

# This needs to become a private method.
def create_screen_shot
  robot = Robot.new
  toolkit = Toolkit.getDefaultToolkit
  dim = toolkit.getScreenSize
  rectangle = Rectangle.new(0, 0, dim.getWidth, dim.getHeight)
  screen_capture = robot.createScreenCapture(rectangle)
end

# This needs to become a private method.
def open_image_file (filename)
  # it's best to keep this full path to the java file class
  image = ImageIO.read(java.io.File.new(filename))
end

#
# This method should be called when you want to find an image
# on screen.
#
# it returns [xClick, yClick] when an image is found.
# it returns [-1, -1] when an image is not found.
# it should be called like this:
#
#   (x,y) = find_image_click_coordinates(image_file_name)
#
def find_image_click_coordinates(image_file_name)
  image_file = open_image_file(image_file_name)
  screen_image = create_screen_shot
  if FindSmallImageInLarge.findImageOptimized(image_file, screen_image)
    return [FindSmallImageInLarge.getXClick, FindSmallImageInLarge.getYClick]
  else
    return [-1, -1]
  end
end

#===== main =====#

# this works
#small_image = open_image_file 'White2.png'
#large_image = open_image_file 'MostlyBlack3.png'

# this also works when acrobat is displayed
#small_image = open_image_file 'acro1.png'
#(x,y) = find_image_click_coordinates small_image
#p x
#p y


