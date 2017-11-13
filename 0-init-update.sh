#!/bin/bash

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y tmux vim git
sudo apt-get upgrade -y linux-aws

# Update headers and install nvidia drivers
sudo apt-get install -y gcc linux-headers-$(uname -r)

wget http://us.download.nvidia.com/XFree86/Linux-x86_64/367.106/NVIDIA-Linux-x86_64-367.106.run
sudo /bin/bash ./NVIDIA-Linux-x86_64-367.106.run
sudo reboot
