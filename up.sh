#!/bin/bash

help() {
	cat <<EOF
Script to quickly spin up an ephemeral Kubevirt development environment
that is targeted towards "immutable" distros like Fedora Silverblue.

Requires sudo privileges and podman installed.

Syntax: ./up.sh <path-to-working-directory>
Options:
	-h	Print this help message
	-p 	Create a volume to persist podman data
EOF
}

while getopts ":ph" option; do
	case $option in
	   p) # Create a volume to persist podman data
	      echo "Adding volume podman-data to persist container images etc."
	      sudo podman volume create podman-data
	      PODMAN_VOLUME="-v podman-data:/var/lib/containers";;
	   h) # print help
	      help
	      exit 0;;
	  \?)
	      echo "Error: Invalid option"
	      help
	      exit 1;;
	 esac
done

if [ $# -lt 1 ]; then
	help
	exit 1
fi

if [ ! -d ${@: -1} ]; then
	echo "Please specify the path to your local working directory"
	echo ""
	help
	exit 1
else
	WORKDIR_PATH="${@: -1}"
	DIR_NAME="$(basename $WORKDIR_PATH)"
fi

sudo podman run -t --privileged -d $PODMAN_VOLUME -v $WORKDIR_PATH:/workspace/$DIR_NAME --name silverblue-kv quay.io/bcarey1/silverblue-kv:latest

echo "silverblue-kv container created"

sudo podman ps -a

sudo podman exec -ti silverblue-kv /bin/bash
