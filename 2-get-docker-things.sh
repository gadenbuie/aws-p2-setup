#!/bin/bash

sudo docker pull ufoym/deepo

echo
echo "All set, let's test that it's working..."
echo "Running: sudo nvidia-docker run --rm ufoym/deepo nvidia-smi"
sudo nvidia-docker run --rm ufoym/deepo nvidia-smi

echo
echo "To run:"
echo "sudo nvidia-docker run -it -v /home/ubuntu:/work ufoym/deepo bash"
