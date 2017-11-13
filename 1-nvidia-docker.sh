#!/bin/bash

# Install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce libltdl7
sudo usermod -aG docker ${USER}

# Install official NVIDIA driver package
sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
sudo sh -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo apt-get update && sudo apt-get install -y --no-install-recommends linux-headers-generic dkms cuda-drivers

# Install nvidia-docker and nvidia-docker-plugin
wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.1/nvidia-docker_1.0.1-1_amd64.deb
sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb

# Optimize GPU settings
sudo nvidia-persistenced
sudo nvidia-smi --auto-boost-default=0
sudo nvidia-smi -ac 2505,875

echo
echo "All done! Reporting drive space FYI"
df -h
echo
echo "Reboot with 'sudo reboot' and then run"
echo "> sudo nvidia-docker run --rm nvidia/cuda:8.0-cudnn6-devel nvcc --version"
echo "to test that everything worked."
