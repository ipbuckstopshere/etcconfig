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
	apt-get -y --force-yes install liquorix-keyrings

	# Nanolx signing key
	wget -q http://www.nanolx.org/apt/photonic.asc \
		-O /etc/apt/keys/nanolx.key
	apt-key add /etc/apt/keys/nanolx.key

	# Samsung unified printer driver repo signing key
	wget -q http://www.bchemnet.com/suldr/suldr.gpg \
		-O /etc/apt/keys/samsung.key
	apt-key add /etc/apt/keys/samsung.key

	# Virtualbox signing key
	wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc \
		-O /etc/apt/keys/virtualbox.key
	apt-key add /etc/apt/keys/virtualbox.key

	# update apt index
	apt-get update

fi
