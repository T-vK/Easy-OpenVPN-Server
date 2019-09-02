# Easy OpenVPN Server

## About
The goal of this project is to make setting up your own VPN server as easy as possible.

## Instructions

### Prerequisites
- Install the OpenVPN Client software on your computer (For Windows, download the installer [here](https://openvpn.net/community-downloads/) . For Linux, install it by running `sudo apt-get install openvpn`. On Windows you also need to [install puTTY](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

### Install and configure OpenVPN on your Linux server
- Connect to your server via SSH (On Windows use Putty, on Linux use a terminal) using the root account and run the following command:

``` bash
curl -o- https://raw.githubusercontent.com/T-vK/Easy-OpenVPN-Server/master/easy-openvpn-server.sh | bash
```

- When the script is done, you will find all the files that you need in order to connect to your VPN in the folder `/vpn_files`.

### Connect to your VPN server
If you're on Linux, you just download the configuration files via scp: `scp -r root@PASTE_YOUR_SERVER_IP_HERE:/vpn_files ~/vpn_files` (enter the root password and press enter).
If you're on Windows, you download them by opening a Command Line as admin (open start menu, search cmd, rightclick Command Prompt and click Run as admin) and pasting the following: `pscp -r "root@185.233.104.39:/vpn_files" "c:\Program Files\openvpn\config\vpn_files"` (replace YOUR_SERVER_IP, enter the root password and press enter).
- If you're on Windows: Open your start menu, search OpenVPN and open it. You should now find the OpenVPN icon in the traybar with an option to Connect to your VPN.
- If you're on Linux: Run `sudo openvpn --config ~/vpn_files/*.ovpn`


## Limitations

- The script has not been tested yet.
- For now I will only test it on Debian 8 with kernel 4.9.
- The OpenVPN server might log your activity. (If you know how to ensure this doesn't happen, I'll gladly improve the script accordingly.)
- This script is supposed to be run on a server that is only being used as a VPN server. The script might only leave SSH and VPN ports open.
