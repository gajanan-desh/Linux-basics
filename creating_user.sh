#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo " This script must be  run as sudo" 
	exit 1
fi

read -p "Enter the username:" username
if id  "$username" &>/dev/null; then
	echo " User '$username' already exist "
	exit 1
fi
read -s -p "Enter the password for $username: " password
echo ""

useradd -m -s /bin/bash "$username"
if [[ $? -eq 0 ]]; then 
	echo "User Created Successfully"
else
	echo "Failed to create"
	exit 1
fi

echo $username:$password | chpasswd
if [[ $? -eq 0 ]]; then
	 echo "Password set successfully" 
else
	echo " Failed to set Password" 
	exit 1
fi

read -p "Enter a group to assign (leave empty for one )" group
if [[ ! -z "$group" ]]; then
	usermod -aG "$group" "$username"
	if  [[$? -eq 0 ]] ; then
		echo " '$username' added to the group '$group'."
	else
		echo " Failed to add user to group '$group'."
	fi
fi

echo " User '$useranme' setup complete" 
