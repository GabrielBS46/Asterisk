#!/bin/bash

cd /opt/
sudo wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20-current.tar.gz
sudo tar -zvxf asterisk-20-current.tar.gz
sudo rm -f asterisk-20*.tar.gz
cd asterisk*
sudo ./contrib/scripts/install_prereq install
sudo ./configure && sudo make && sudo make install && sudo make config && sudo make install-logrotate
sudo systemctl start asterisk.service
sudo systemctl enabled asterisk.service
