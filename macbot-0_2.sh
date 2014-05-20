#!/bin/bash

# This is the macbot.sh script. An easy script to interactively run macchanger on debian distributions employing network-manager.
# Needs to be run as root.
# Thanks to Hai @ http://wuhrr.wordpress.com for the bit with select, and http://chris.com/ascii/index.php?art=television/futurama
# for the ascii_art.
# GNU General Public License applies.
# Author: Manuel Weber (mmweber@gmx.net)


#	This is the main screen.
#	It includes user input for network interface that mac has to be changed.
#	Sanitizing input has yet to be implemented.

#	Changelog:
#	0.2 @ 2014/03/07   -> fixed bug that put the "cloned-mac-address=XX:XX:XX:XX:XX:XX" fixed at line 12, now its always after the line
#			      "mac-address=XX:XX:XX:XX:XX:XX" , where it's supposed to be. It also deletes possible old cloned addresses 
#			      and replaces it with new strings.
#
#	    		   -> cleaned up output string

echo
echo
echo "		###	The MAC Bot 0.2		###"
echo
echo
echo
echo "			   T		"
echo '			 .-"-.		'
echo "			|  ___|		"
echo "			| (.\/.)	"
echo "			|  ,,,' 	"
echo "			| '###		"
echo "			 '----'		"


-

echo
echo
echo 'Enter the WLAN interface you want to change (eg. wlan0, wlan1,...) : '
echo


read int 
echo

ifconfig $int down
service network-manager stop
macchanger -A $int
echo
echo

mac=`ip link show $int | awk '/ether/ {print $2}'`


# This part asks the user which Network has to be configured.
# 
#

echo 'List of available, already used WLANs: '
echo
echo




# Changes to network directory
cd /etc/NetworkManager/system-connections/



# Change network names to be withouth space characters
rename "s/ /_/g" *



# Set the prompt for the select command
PS3="Type a number or 'q' to quit: "



# Create a list of files to display
fileList=$(find . -maxdepth 1 -type f)




# Show a menu and ask for input, then remove any old cloned MAC addresses
# and replace them with a fresh one.

select fileName in $fileList; do
	if [ -n "$fileName" ]; then
		sed -i  "/^cloned-mac-address=.*/d" ${fileName}
		sed -i  "/^mac-address=.*/a\cloned-mac-address=$mac" ${fileName}


		#sed -i "12s/.*/cloned-mac-address=$mac/" ${fileName}
	fi
	break
done



ifconfig wlan0 up
service network-manager start

echo
echo
echo
echo "Changed MAC address of interface $int to: $mac"
echo
echo
echo

# Functionality to add to script:
# 1. Display network interfaces to choose from
# 2. Display macchangermodes, a)Custom b) Another c)random
# 3. 
