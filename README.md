# This is the macbot.sh script. An easy script to interactively run macchanger 
# on debian distributions employing network-manager.
#
# Needs to be run as root.
# Thanks to Hai @ http://wuhrr.wordpress.com for the bit with select, and 
# http://chris.com/ascii/index.php?art=television/futurama for the ascii_art.
#
# If you think any part of it need improvement please let me know.
#
# Author: Manuel Weber (mmweber@gmx.net)
#
#
#
#       Changelog:
#
#  0.2 @ 2014/03/07:  -> fixed bug that put the 
#			 "cloned-mac-address=XX:XX:XX:XX:XX:XX" fixed at line 
#                        12, now its always after the line 
#                        "mac-address=XX:XX:XX:XX:XX:XX" , where it's supposed 
#			 to be. It also deletes possible old cloned addresses 
#		   	 and replaces it with new strings.
#
#                     -> cleaned up output string
#
#
# 
