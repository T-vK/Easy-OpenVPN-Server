# Easy OpenVPN Server

## About
The goal of this project is to make setting up your own VPN server as easy as possible.

## Instructions
- Install the OpenVPN Client software on your computer (For Windows, download the installer [here](https://openvpn.net/community-downloads/) . For Linux, install it by running `apt-get install openvpn`.
- Connect to your server via SSH using the root account and run the following command:

``` bash
curl -o- https://raw.githubusercontent.com/T-vK/Easy-OpenVPN-Server/master/easy-openvpn-server.sh | bash
```

- When the script is done, you will find all the files that you need in order to connect to your VPN in the folder `/vpn_files`.  
    If you're on Linux, you just download them via scp: `scp root@PASTE_YOUR_SERVER_IP_HERE:/vpn_files ~/vpn_files` (enter the password and press enter).
    If you're on Windows, you can download them using `pscp root@PASTE_YOUR_SERVER_IP_HERE:/vpn_files c:\Program Files\openvpn\config\ -pw PASTE_YOUR_ROOT_PASSWORD_HERE -P 22`  
- If you're on Windows: Restart your PC and open OpenVPN. You should now find the OpenVPN icon in the traybar with an option to connect to your VPN.
- If you're on Linux: Run `sudo openvpn --config ~/vpn_files`


## Limitations

- The script has not been tested yet.
- For now I will only test it on Debian 8 with kernel 4.9.
- The OpenVPN server might log your activity. (If you know how to ensure this doesn't happen, I'll gladly improve the script accordingly.)
