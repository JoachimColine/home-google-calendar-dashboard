#!/bin/bash

# Turn on internet 
nmcli radio wifi on

# Refresh browser after 30sec
sleep 30
xdotool key F5

# Turn on display
ddcutil setvcp d6 1
