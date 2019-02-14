require 'java'

java_import 'java.awt.Color'
java_import 'java.awt.Robot'
java_import 'java.awt.event.InputEvent'

def almost_equal(a, b)
  return true if a == b 
  diff = a - b
  return true if diff.abs <= 5
  return false
end

def color_is_seen (pixel_color, r, g, b)
  if (almost_equal(r, pixel_color.getRed)    && 
      almost_equal(g, pixel_color.getGreen)  &&
      almost_equal(b, pixel_color.getBlue) )
    return true
  else
    return false
  end
end

# Wait for a color to appear at an x/y/z location.
# User can specify a time to wait (in seconds) or use the default time
# (10 seconds). 
# x, y, r, g, b are all int's.
def wait_for_color (x,y,r,g,b,wait_for=10)
  pause_between_looks = 0.25
  time_waited = 0
  t_start = Time.new
  #puts "DEBUG: looking at pixel #{x}, #{y}"
  while true
    # leave this method when the color is found
    c = @robot.getPixelColor(x,y)
    #
    # KLUDGE: Have a "tolerance" here because colors aren't matching for
    #         some reason.
    #
    #puts "DEBUG: color: #{c.getRed}, #{c.getGreen}, #{c.getBlue}"
    #return true if (r==c.getRed && g==c.getGreen && b==c.getBlue)
    return true if color_is_seen(c,r,g,b)

    # slight pause before looking for color again
    sleep pause_between_looks
    time_waited = Time.new - t_start

    # leave this method when we've waited as long as specified
    return false if time_waited > wait_for
  end
end

# TODO: refactor this method and the previous method. their functionality
#       is almost identical.
# return true when the color at the specific point is not there.
def wait_for_color_to_go_away (x,y,r,g,b,wait_for=10)
  pause_between_looks = 0.25
  time_waited = 0
  t_start = Time.new
  while true
    # leave this method when the color is found
    c = @robot.getPixelColor(x,y)
    return true if ! color_is_seen(c,r,g,b)

    # slight pause before looking for color again
    sleep pause_between_looks
    time_waited = Time.new - t_start

    # leave this method when we've waited as long as specified
    return false if time_waited > wait_for
  end
end


#@robot = Robot.new
#if wait_for_color(894, 175, 255, 255, 255)
#  puts "found the color"
#else
#  puts "did not find the color"
#end




