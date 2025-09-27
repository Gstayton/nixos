#!/usr/bin/env bash

cd "$(dirname "$0")"

link_files() {
	src=$1
	dst=$2

	if [ ! -h $dst ]; then
		if [ -f $dst ]; then
			echo "Creating backup of existing ${dst} at ${dst}.bak"
			mv $dst "${dst}.bak"
		fi
		echo "Linking ${PWD}/${src} to ${dst}"
		ln -s ${PWD}/${src} ${dst}
	else
		if [[ $(readlink -f ${dst}) == ${PWD}/${src} ]];  then
			echo "${src} already linked"
		else
			echo "Linking ${PWD}/${src} to ${dst}"
			ln -s ${PWD}/${src} ${dst}
		fi
	fi
}

## files that may need root
if [ "$EUID" -ne 0 ]; then
	echo "Not running as priviledge - unable to copy certain files."
	echo "Re-run script with sudo -E"
else
	link_files configuration.nix /etc/nixos/configuration.nix
	link_files network-storage.nix /etc/nixos/network-storage.nix
	link_files flake.nix /etc/nixos/flake.nix
fi
