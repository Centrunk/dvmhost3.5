#! /usr/bin/bash
#Creaates appropriate directories, pulls compiled dvmhost
#Created by NineJuanJuan

mkdir /opt/centrunk
mkdir /var/log/centrunk3.5
mkdir /opt/centrunk/configs
cd /opt/centrunk
rm -rf dvmhost
rm -rf dvmhost.tar.gz
wget http://10.147.17.100/dvmhost.tar.gz
tar -xzvf dvmhost.tar.gz
rm -rf dvmhost.tar.gz
