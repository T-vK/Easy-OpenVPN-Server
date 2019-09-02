#!/bin/bash
CONFIG_HOST="https://raw.githubusercontent.com/T-vK/Easy-OpenVPN-Server/config"
apt-get update && apt-get install -y openvpn easy-rsa ufw
gunzip -c /usr/share/doc/openvpn/examples/sample-config-files/server.conf.gz > /etc/openvpn/server.conf
curl "${CONFIG_HOST}/server.conf" > /etc/openvpn/server.conf
echo 1 > /proc/sys/net/ipv4/ip_forward
curl "${CONFIG_HOST}/sysctl.conf" > /etc/sysctl.conf
ufw allow ssh
ufw allow 1194/udp
curl "${CONFIG_HOST}/ufw" > /etc/default/ufw
curl "${CONFIG_HOST}/before.rules" > /etc/ufw/before.rules
echo -en "y\n" | ufw enable
ufw status
cp -r /usr/share/easy-rsa/ /etc/openvpn
mkdir /etc/openvpn/easy-rsa/keys
curl "${CONFIG_HOST}/vars" > /etc/openvpn/easy-rsa/vars
openssl dhparam -out /etc/openvpn/dh2048.pem 2048
cd /etc/openvpn/easy-rsa
. ./vars
./clean-all
(echo -en "\n\n\n\n\n\n\n\n"; sleep 1; echo -en "\n") | ./build-ca
(echo -en "\n\n\n\n\n\n\n\n\n\n"; sleep 1; echo -en "y\n"; sleep 1; echo -en "y\n") | ./build-key-server server
cp /etc/openvpn/easy-rsa/keys/{server.crt,server.key,ca.crt} /etc/openvpn
service openvpn start
service openvpn status
(echo -en "\n\n\n\n\n\n\n\n\n\n"; sleep 1; echo -en "y\n"; sleep 1; echo -en "y\n") | ./build-key $(dig +short myip.opendns.com @resolver1.opendns.com)
cp /usr/share/doc/openvpn/examples/sample-config-files/client.conf /etc/openvpn/easy-rsa/keys/$(dig +short myip.opendns.com @resolver1.opendns.com).ovpn
sed -i "s/my-server-1/$(dig +short myip.opendns.com @resolver1.opendns.com)/g" "/etc/openvpn/easy-rsa/keys/$(dig +short myip.opendns.com @resolver1.opendns.com).ovpn"
sed -i "s/ca ca\.crt/ca $(dig +short myip.opendns.com @resolver1.opendns.com).ca.crt/g" "/etc/openvpn/easy-rsa/keys/$(dig +short myip.opendns.com @resolver1.opendns.com).ovpn"
sed -i "s/cert client\.crt/cert $(dig +short myip.opendns.com @resolver1.opendns.com).crt/g" "/etc/openvpn/easy-rsa/keys/$(dig +short myip.opendns.com @resolver1.opendns.com).ovpn"
sed -i "s/key client\.key/key $(dig +short myip.opendns.com @resolver1.opendns.com).key/g" "/etc/openvpn/easy-rsa/keys/$(dig +short myip.opendns.com @resolver1.opendns.com).ovpn"
mkdir /vpn_files
cp /etc/openvpn/easy-rsa/keys/$(dig +short myip.opendns.com @resolver1.opendns.com).ovpn /vpn_files/
cp /etc/openvpn/easy-rsa/keys/$(dig +short myip.opendns.com @resolver1.opendns.com).crt /vpn_files/
cp /etc/openvpn/easy-rsa/keys/$(dig +short myip.opendns.com @resolver1.opendns.com).key /vpn_files/
cp /etc/openvpn/ca.crt /vpn_files/$(dig +short myip.opendns.com @resolver1.opendns.com).ca.crt
chmod 777 -R /vpn_files/
echo "Server will restart now."
reboot
