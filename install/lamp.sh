#!/bin/bash

sudo apt install -y apache2
sudo systemctl enable apache2
sudo apt install -y mariadb-server
sudo systemctl start mariadb
sudo systemctl enable mariadb
sudo mysql_secure_installation <<EOF
y
y
$1
$1
y
y
y
y
EOF
sudo apt install -y php libapache2-mod-php
