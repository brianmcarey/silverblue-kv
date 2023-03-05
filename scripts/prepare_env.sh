#!/bin/bash

echo "Setting up environment"

# Podman in podman setup
mkdir -p /run/podman
podman system service -t 0 \
	unix:///run/podman/podman.sock \
	>/var/log/podman.log 2>&1 & \
	echo "${!}" > /var/run/podman.pid

ln -s /run/podman/podman.sock /var/run/docker.sock

sed -i 's/short-name-mode="enforcing"/short-name-mode="permissive"/g' /etc/containers/registries.conf

# Enable IPv6
sysctl net.ipv6.conf.all.disable_ipv6=0
sysctl net.ipv6.conf.all.forwarding=1

# Keep container alive unless stopped by user
sleep infinity
