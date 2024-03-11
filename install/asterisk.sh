#!/bin/bash

cd /opt/
sudo wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz
sudo tar -zvxf asterisk-20-current.tar.gz
sudo rm -f asterisk-20*.tar.gz
cd asterisk*
sudo ./contrib/scripts/install_prereq install
sudo ./configure && sudo make && sudo make install && sudo make config && sudo make install-logrotate
sudo systemctl start asterisk.service
sudo systemctl enable asterisk.service
sudo useradd asterisk
sudo chown -R asterisk: {/etc,/var/lib,/var/spool,/var/log,/var/run}/asterisk
