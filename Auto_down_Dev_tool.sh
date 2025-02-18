#!/bin/bash
echo "Starting the setup"
if [[ -f /etc/debian_version ]]; then     # -F check if this particular etc file exist if hyes then it is a  debian based system 
	os="debian"
	PKG_MANAGER="apt-get"
	UPDATE_CMD="apt-get update && apt-get upgrade -y" 
elif [[ -f /etc/redhat-release ]]; then         #  here it check if this etc file exist 
	os="rhel"
	PKG_MANAGER="yum"
	UPDATE_CMD="yum update -y"
else
	echo "Unsupported version"
	exit 1
fi
echo " Updating to latest version"
sudo $UPDATE_CMD
echo "Installing GIT,VIM,CURL and WGET"
sudo $PKG_MANAGER install -y git vim curl wget 

echo "Installed version"
git --version
vim --version | head -n 1
curl --version | head -n 1
wget --version | head -n 1

echo " System Update and Pacakages installed succesfully"
