#!/bin/bash

if [ -z "$1" ]
then
  echo Forneça a senha junto ao comando. 
  echo "./install.sh <password>"
  exit 2
fi

sudo apt update -y && sudo apt upgrade -y
sudo apt install -y git vim nano wget rsync unzip curl 
bash vimrc.sh
bash lamp.sh $1
bash asterisk.sh
