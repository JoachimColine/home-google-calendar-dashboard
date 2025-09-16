<p align="center">
  <h3 align="center">Home Google Calendar Dashboard</h3>
  <p align="center">
	Build your own Google calendar-synced dashboard using simple parts.
  </p>
  <p align="center">
    <a href="https://github.com/JoachimColine/home-google-calendar-dashboard">
	<img src="images/dashboard.webp" width="700">
	</a>
  </p>
</p>

```mermaid
flowchart LR
    A[Raspberry Pi] e1@-->|display and power control| B[HDMI monitor mounted in 3D-printed frame]
	e1@{ animation: fast }
```



## Hardware requirements
- A [Raspberry Pi 3B+](https://www.raspberrypi.com/products/raspberry-pi-3-model-b-plus/) (not tested on other models).
- A small HDMI monitor (e.g. 10.5inch).  
- 90° angle connectors for HDMI monitor cables. This helps cables going through the wall.
- Access to a 3D printer to print the frame.

## Software requirements
- A Google account.
- A [DAKboard](https://dakboard.com/site) account.
- [Raspberry Pi imager](https://www.raspberrypi.com/software) software.
- 3D-modelling software if you need to adapt the frame geometry to your own monitor.

## Step-by-step guide

### 1. Configure the Raspberry Pi 
- Run the [Raspberry Pi imager](https://www.raspberrypi.com/software) to install the Raspberry Pi OS on your SD card.
- Plug your SD card in the Raspberry Pi and power it. When your device is up and running, connect to the internet.

- You are now ready to setup the dashboard. There are two main tasks to automate:
	- Display the dashboard in full screen mode;
	- Turn off/on the monitor during certain periods of the day.
  
  These tasks will be executed by automatically running the [following scripts](/src):
	- [`init_dashboard.sh`](/src/init_dashboard.sh) will display the dashboard in full screen mode,
	- [`start_dashboard.sh`](/src/start_dashboard.sh) will turn on the monitor and refresh the dashboard,
	- [`stop_dashboard.sh`](/src/stop_dashboard.sh) will turn off the monitor.
  
  All you have to do is 
    - Edit the `init_dashboard.sh` script by replacing `${YOUR_DAKBOARD_PRIVATE_LINK}` with your DAKboard private link,
	- copy the 3 scripts to your Raspberry Pi home directory (`~`),
    - decide what time of the day you want your dashboard to be displayed. 
  
  Once decided, define the `start_dashboard.sh` and `stop_dashboard.sh` as [cron jobs](https://docs.passwork.pro/crontab-basics) by
  adding them to the `crontab` file. This can be helped by running the command
  ```bash  
  crontab -e
  ```
  in the terminal. For example append the following lines
  
  ```bash  
  30 6  * * * ~/start_dashboard.sh  # Turn on  everyday at 6:30am
  30 9  * * * ~/stop_dashboard.sh   # Turn off everyday at 9:30am
  30 17 * * * ~/start_dashboard.sh  # Turn on  everyday at 5:30pm
  30 22 * * * ~/stop_dashboard.sh   # Turn off everyday at 10:30pm
  ```
  to display the dashboard between 6:30am and 9:30am and between 5:30pm and 10:30pm.
  
  Note that the `init_dashboard.sh` is not mentioned there. Indeed it should be called only once. This is done by adding the line 
  ```bash 
  ~/init_dashboard.sh
  ```
  in the `~/.profile` file.
  
  ⚠️ You will need to install packages for the scripts to work. To do so, run the following commands in the terminal:
  ```bash 
  sudo apt update             # update the package manager
  sudo apt install ddcutil    # for monitor communication
  sudo apt install xdotool    # for refresh page shortcut
  # TODO: check other required packages
  ```
  
  You're all set! To test the dashboard, reboot the Raspberry Pi, and let it run all day. 🌈

### 2. Assemble the monitor in a 3D-printed frame
TODO

## Pro tips
- To quit full screen mode, press Ctrl+Alt+T to show a terminal, then run command
  ```bash 
  pkill chromium
  ```
- Your device should only know about one network for the internet.
- If you want to display emojis in your dashboard, open a terminal and run command
  ```bash 
  sudo apt-get install fonts-noto-color-emoji
  ```
  
## Contributing
Contributions are welcome. I am particularly interested in 
- getting the project to work on other Raspberry Pi models;
- improving the scripts, for example not relying on a `sleep` command to wait for the device to be connected to the internet.

## License
This project is licensed under the MIT license.