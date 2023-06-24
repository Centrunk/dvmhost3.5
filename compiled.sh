#! /usr/bin/bash
#Creaates appropriate directories, pulls compiled dvmhost
#Created by NineJuanJuan

mkdir /opt/centrunk
mkdir /var/log/centrunk
cd /opt/centrunk
rm -rf dvmhost
rm -rf dvmhost.tar.gz
wget http://10.147.17.100/dvmhost.tar.gz
tar -xzvf dvmhost.tar.gz
rm -rf dvmhost.tar.gz
