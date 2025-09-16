#!/bin/bash

source ~/start_dashboard.sh

# Open browser
chromium-browser --kiosk --incognito ${YOUR_DAKBOARD_PRIVATE_LINK} &
