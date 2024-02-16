#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y git vim nano wget rsync unzip curl

bash vimrc.sh
bash lamp.sh $1
bash asterisk.sh
