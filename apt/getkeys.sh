#!/bin/bash

######
#
## Simple script to get required #
#  apt repository signing keys. ##
                                 #
                             #####

if [[ ${EUID} != 0 ]]; then
	echo "not root - exiting"
else
	if [[ $(which wget) == "" ]]; then
		apt-get install wget
	fi

	if [[ ! -d /etc/apt/keys/ ]]; then
		mkdir /etc/apt/keys/
	fi

	# Debian Multimedia signing key
	apt-get -y --force-yes install deb-multimedia-keyring

	# Liquorix signing key
	apt-get -y --force-yes install '^liquorix-([^-]+-)?keyring.?'

	# Nanolx signing key
	if [[ ! -f /etc/apt/keys/nanolx.key ]]; then
		wget -q http://www.nanolx.org/apt/photonic.asc \
			-O /etc/apt/keys/nanolx.key
	fi
	apt-key add /etc/apt/keys/nanolx.key

	# Samsung unified printer driver repo signing key
	if [[ ! -f /etc/apt/keys/samsung.key ]]; then
		wget -q http://www.bchemnet.com/suldr/suldr.gpg \
			-O /etc/apt/keys/samsung.key
	fi
	apt-key add /etc/apt/keys/samsung.key

	# Virtualbox signing key
	if [[ ! -f /etc/apt/keys/virtualbox.key ]]; then
		wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc \
			-O /etc/apt/keys/virtualbox.key
	fi
	apt-key add /etc/apt/keys/virtualbox.key

	# i2p signing key
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EB2CC88B

	# update apt index
	apt-get update

fi
