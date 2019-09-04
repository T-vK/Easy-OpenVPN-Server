# Easy OpenVPN Server

## About
The goal of this project is to make setting up your own Linux-based VPN server as easy as possible.
Use at own risk

## Instructions

### If your PC (not server) runs Linux, open a terminal and run:
This will install and configure an OpenVPN server on your Linux server and download the configuration files required to conenct to the VPN:
```
export SERVER_IP="x.x.x.x"
ssh -t "root@$SERVER_IP" "curl -o- https://raw.githubusercontent.com/T-vK/Easy-OpenVPN-Server/master/easy-openvpn-server.sh | bash"
sudo apt-get install -y openvpn
sudo scp "root@$SERVER_IP:/vpn_files/*" /etc/openvpn/
ssh -t "root@$SERVER_IP" "sh -c 'nohup sh -c \"sleep 1 && reboot &\" > /dev/null 2>&1 && exit && exit'"
```

If you want to connect to the VPN now, you just run `sudo openvpn --config /etc/openvpn/*.ovpn`

If you want to auto connect whenever your PC starts, also run: `for f in /etc/openvpn/*.ovpn; do sudo mv -- "$f" "${f%.ovpn}.conf"; done` and restart your PC.

### If your PC (not server) runs Windows:
- Install the OpenVPN Client software on your computer. Download the installer [here](https://openvpn.net/community-downloads/)
- Install puTTY. Download the installer [here](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
- Open puTTY, enter the IP address of your server into the `Host Name (or IP address)`-field. Enter `22` into the `Port`-field. Sellect `SSH` as the `Connection Type`.
- Finally click the `Open`-button at the bottom.
- A black window should appear where you need to enter a user name (Enter `root` and press enter). Then it will ask for a password, but when you type no characters will show up (this is normal). Enter your server's root password and press enter.
- Enter the following line:
    ``` bash
    curl -o- https://raw.githubusercontent.com/T-vK/Easy-OpenVPN-Server/master/easy-openvpn-server.sh | bash
    ```
- When the script is done, all the files that you need in order to connect to your VPN in the folder `/vpn_files` on your Linux server.
- To download them, open a Command Line as admin (open start menu, search `cmd`, rightclick `Command Prompt` and click `Run as administrator`). Then paste the following: `pscp -r "root@185.233.104.39:/vpn_files" "c:\Program Files\openvpn\config\vpn_files"` (replace YOUR_SERVER_IP with your actual server IP, then press enter. It will probably ask you something, just enter `y` to accept and press enter. Then it will ask for the root password, so enter it and press enter).
- Open your start menu, search OpenVPN and open it. You should now find the OpenVPN icon in the traybar with an option to Connect to your VPN.


## Limitations

- The script has not been tested yet.
- For now I will only test it on Debian 8 with kernel 4.9.
- The OpenVPN server might log your activity. (If you know how to ensure this doesn't happen, I'll gladly improve the script accordingly.)
- This script is supposed to be run on a server that is only being used as a VPN server. The script might only leave SSH and VPN ports open.
