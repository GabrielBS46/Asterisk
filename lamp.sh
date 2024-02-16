#!/bin/bash

sudo apt install -y apache2
sudo systemctl enable --now apache2

sudo apt install mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb

mysql_secure_installation <<EOF

y
aSSASSIN-10
aSSASSIN-10
y
y
y
y
EOF

sudo apt install php libapache2-mod-php
