#!/bin/bash

wrong="\e[1;93m[\e[91m!\e[93m] You're not qualified!\e[0m"
error="\e[1;93m[\e[91m!\e[93m] Something's wrong!\e[0m"

clear
echo -ne "\e[1;97mIs this a factory Raspberry Pi 3? (\e[96my\e[97m/\e[96mn\e[97m): \e[0m"
read check1
echo ""

if [ $check1 != y ]; then
	echo -e "$wrong"
	exit
fi

echo -ne "\e[1:97mAre you sure you want to turn your Raspberry Pi into a WiFi hotspot? (\e[96my\e[97m/\e[96mn\e[97m): \e[0m"
read check2
echo ""

if [ $check2 != y ]; then
	echo -e "$wrong"
	exit
fi

echo -e "\e[1;97mWorking...\e[0m"
sudo apt-get -qq update

if [ $? != 0 ]; then
	echo -e "$error"
fi

sudo apt-get -qq wpasupplicant

if [ $? != 0 ]; then
	echo -e "$error"
fi

sudo cp /etc/wpa_supplicant/wpa_supplicant.conf /etc/wpa_supplicant/wpa_supplicant.conf.bak

if [ $? != 0 ]; then
	echo -e "$error"
fi

sudo cp /dev/null /etc/wpa_supplicant/wpa_supplicant.conf

if [ $? != 0 ]; then
	echo -e "$error"
fi

echo -e "\nctrl_interface=DIR=/var/run/wpa_supplicant\nGROUP=netdev\nupdate_config=1" > /etc/wpa_supplicant/wpa_supplicant.conf

if [ $? != 0 ]; then
	echo -e "$error"
fi

sudo apt-get -qq hostapd

if [ $? != 0 ]; then
	echo -e "$error"
fi

echo ""
echo -e "\e[1;97mAfter installation, type raspi-webgui\e[0m"
read pause

wget -q https://git.io/voEUQ -O /tmp/raspap && bash /tmp/raspap

exit
