#!/bin/bash

rm -rf /opt/centrunk/dvmhost/dvmhost
rm -rf /opt/centrunk/dvmhost/dvmcmd
rm -rf /opt/centrunk/utils
git clone https://github.com/Centrunk/dvmhost3.5.git /opt/centrunk/utils

architecture=$(uname -m)

source_path="/opt/centrunk/utils/bin"
destination_path="/opt/centrunk/dvmhost/"


if [[ $architecture == "x86_64" ]]; then
    cp -r "$source_path/x86_64/." "$destination_path"
    chmod +x /opt/centrunk/dvmhost/dvmhost
    chmod +x /opt/centrunk/dvmhost/dvmcmd
    echo "File copied for x86_64 architecture."

elif [[ $architecture == "arm64" ]]; then
    cp -r "$source_path/arm64/." "$destination_path"
    chmod +x /opt/centrunk/dvmhost/dvmhost
    chmod +x /opt/centrunk/dvmhost/dvmcmd
    echo "File copied for arm64 architecture."

elif [[ $architecture == "aarch64" ]]; then
    cp -r "$source_path/arm64/." "$destination_path"
    chmod +x /opt/centrunk/dvmhost/dvmhost
    chmod +x /opt/centrunk/dvmhost/dvmcmd
    echo "File copied for arm64 architecture."

elif [[ $architecture == "armhf" ]]; then
    cp -r "$source_path/armhf/." "$destination_path"
    chmod +x /opt/centrunk/dvmhost/dvmhost
    chmod +x /opt/centrunk/dvmhost/dvmcmd
    echo "File copied for arm64 architecture."

elif [[ $architecture == "armv7l" ]]; then
    cp -r "$source_path/armhf/." "$destination_path"
    chmod +x /opt/centrunk/dvmhost/dvmhost
    chmod +x /opt/centrunk/dvmhost/dvmcmd
    echo "File copied for armv7l architecture."

else
    echo "Unsupported architecture: $architecture"
    echo "Contact Netops for Suppport"
    exit 1
fi

echo "Your host is restarting"
sleep 10
reboot