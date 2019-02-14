#
# gui regression tests for google chrome
#
require 'java'
require 'AgileGuiTesting'
require 'AGTMacOsX'

def play_slideshow
  @robot.keyPress(VK_ALT);
  @robot.keyPress(VK_META);
  @robot.keyPress(VK_P);
  wait 200
  @robot.keyRelease(VK_P);
  @robot.keyRelease(VK_ALT);
  @robot.keyRelease(VK_META);
end

def num_chrome_procs
  n = `ps auxwww | grep -i google | grep -v grep | wc -l`
  return n.chomp.strip
end

def test_file_open
  c 'test the File | Open process'
  c 'open a new tab'
  apple 't'

  c 'open a file'
  apple 'o'
  wait 1000
  type '/Users/Al/DevDaily/AgileGuiTesting/scripts/support/blue.html\n'
  wait 500
  type '\n'

  wait_for_xycolor 220, 280, 0, 0, 255
  wait 1000

  c 'close the tab we created'
  wait 250
  apple 'w'
end


### BEGIN ###

wait 2000

c 'go down to the keynote Space'
ctrl VK_DOWN
wait 500

c 'select the fourth keynote slide'
click 333, 360

c 'display keynote full screen'
play_slideshow

wait 500
speak "welcome to dev daily dot com", "vicki"
wait 500

type_keys VK_RIGHT
speak "this is a robot presentation of our agile gui testing software", "bruce"
wait 500

type_keys VK_RIGHT
speak "we will be performing gui regression tests on the google chrome browser"
wait 500

c 'leave keynote full screen mode'
type_keys VK_ESC

c 'back up to the chrome space'
wait 500
ctrl VK_UP
wait 1000


### CHROME TESTS ###

foreground 'Google Chrome'
wait 2000

num_procs_start = num_chrome_procs

echo 'test that file|open works'
speak 'about to test the file open process', 'ralph'
test_file_open
speak 'that went well', 'ralph'
wait 200

echo 'test opening up a url'
speak 'lets open a test URL'
apple 't'
wait 100
apple 'l'
wait 100
type 'www.devdaily.com \n'
wait_for_xycolor_to_go_away 500, 175, 255, 255, 255
wait 1000
speak 'say, thats a nice website', 'victoria'
wait 1000
apple 'w'

n = 20
speak "about to open and close #{n} chrome windows"
n.times { apple 'n' }
n.times { apple 'w' }

n = 20
speak "about to open and close #{n} chrome tabs"
n.times { apple 't' }
n.times { apple 'w' }

speak 'lets see what the memory looks like', 'ralph'
apple 't'
apple 'l'
type 'about:memory \n'
wait 2500
apple 'w'

speak 'i could do this all day. how about you?', 'ralph'
wait 1000

num_procs_end = num_chrome_procs
result = "There were #{num_procs_start} Chrome processes running when the test began, and there are #{num_procs_end} running now."
echo result
speak result
wait 2000

### KEYNOTE, PART 2 ###

c 'back to keynote space'
ctrl VK_DOWN
wait 500

c 'select the last keynote slide'
click 333, 510

c 'display keynote full screen'
play_slideshow

wait 500
speak "thank you for watching our agile gui testing video"
wait 500

type_keys VK_RIGHT
wait 500
speak "dev daily dot com", "cellos"







