#!/bin/bash

# Turn off display
ddcutil setvcp d6 5

# Turn off internet
nmcli radio wifi off
