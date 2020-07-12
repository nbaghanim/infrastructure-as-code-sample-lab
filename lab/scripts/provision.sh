#!/bin/bash

cd /home/ubuntu
mkdir -p wibble
touch ./wibble/wobble.txt
sudo apt update && apt install -y curl jq vim
