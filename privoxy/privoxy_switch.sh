#!/bin/bash

function reinit ()
{
	for init in privoxy tor i2p; do
		/etc/init.d/${init} restart
	done
}

if [[ ${EUID} != 0 ]]; then
	echo "Not running as root"
else
	CURRCONF=$(basename  $(ls -l /etc/privoxy/config | gawk '{print $11}'))

	case $1 in
		-l | --list)
			echo "current privoxy config: ${CURRCONF}"
		;;
		-t | --tor)
			echo "changing privoxy config from ${CURRCONF} to config.tor_all"
			ln -sf /etc/privoxy/config.tor_all /etc/privoxy/config
			reinit
		;;
		-d | --default)
			echo "changing privoxy config from ${CURRCONF} to config.default"
			ln -sf /etc/privoxy/config.default /etc/privoxy/config
			reinit
		;;
		-s | --special)
			echo "changing privoxy config from ${CURRCONF} to config.onion_i2p"
			ln -sf /etc/privoxy/config.onion_i2p /etc/privoxy/config
			reinit
		;;
		-h | --help)
			echo -e "simple script to switch between predefined privoxy configs\
				\n\
				\n-l, --list	show current config\
				\n-d, --default	switch to default config (no forwarding)\
				\n-s, --special	switch to special config (forward .onion and .i2p)\
				\n-t, --tor	switch to tor config	 (forward all to tor and .i2p)\
				\n-h, --help	this help message"
		;;
		*)
			echo "Try privoxy_switch.sh --help"
		;;
	esac
fi
