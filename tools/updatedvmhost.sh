#!/bin/bash

is_service_running() {
    local service_name=$1
    systemctl is-active --quiet "$service_name"
    return $?
}

restart_service() {
    local service_name=$1
    systemctl restart "$service_name"
}

services=$(ls /etc/systemd/system | grep centrunk)

for service in $services; do
    if is_service_running "$service"; then
        systemctl stop "$service"
        sleep 5
        while is_service_running "$service"; do
            sleep 1
        done
    fi
done

rm -rf /opt/centrunk/dvmhost/dvmhost
rm -rf /opt/centrunk/dvmhost/dvmcmd
rm -rf /opt/centrunk/util
git clone https://github.com/Centrunk/dvmhost3.5.git /opt/centrunk/util

architecture=$(uname -m)

source_path="/opt/centrunk/util/bin"
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
    echo "Contact Netops for Support"
    exit 1
fi

for service in $services; do
    if ! is_service_running "$service"; then
        restart_service "$service"
    fi
done
