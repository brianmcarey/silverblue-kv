#!/bin/bash
# Script to clean up environment

while getopts ":d" option;do
	case $option in
		d) #Delete the persistent podman volume
		    DELETE_VOLUME=true;;
		\?)
		    echo "Error: Invalid option - please review script for options"
		    exit 1;;
    esac
done

echo "Stopping and removing dev container"
sudo podman stop -t 1 silverblue-kv && sudo podman rm silverblue-kv

if [ $DELETE_VOLUME ];then
	echo "Deleting peristent volume 'podman-data'"
	sudo podman volume rm podman-data
fi
