# Overview

These scripts set up [docker] and [nvidia-docker] for an Amazon AWS EC2 p2 instance.
In total, it takes about 15-20 minutes to go from a base Ubuntu 16.04 AMI to a fully setup deep learning instance.

The advantage of using these scripts to set up the p2 instance is that you can run your deep learning code inside docker (cpu) or nvidia-docker (gpu).
This means you don't have to spend time setting up Keras, Tensorflow, Python, Jupyter, etc., setting up that part is a simple `docker pull`.
It also means you can work with your code locally inside docker, then move to the cloud, and (almost) seamlessly transition to using GPU instances.

The one thing to watch out for is that sometimes docker images don't include the correct packages that are required to run the software on CPU or GPU (depending on the goal of the image), so you may need to install those manually on your own.

## Docker images

The two docker images I've been working with are

- [Deepo][ufoym-deepo]
    - All the things deep learning related in one ~7.5GB image. Doesn't have cpu-based `tensorflow` installed, but this can be done with `pip install tensorflow`.
- [jupyter-keras](https://github.com/gadenbuie/jupyter-keras)
    - Good for locally working with Keras and Jupyter, but doesn't have `tensorflow-gpu` installed.

## Usage

Launch an Amazon AWS EC2 p2 instance from an Ubuntu 16 AMI, like: `ami-da05a4a0`.
If you're using the [ufoym/deepo container][ufoym-deepo] above, you'll need at least 12GB of storage for the containers, etc.
Note this depends on the size of the Docker image you're using, you may need more or less for your instance.

SSH into the instance

```
ssh -i <your-pem-key>.pem ubuntu@<ec2-public-dns>
```

clone this repo

```
git clone https://github.com/gadenbuie/aws-p2-setup
```

and run the scripts. There are 3 scripts and 2 reboots (after each of the first two scripts).

```
cd aws-p2-setup
./0-init-update.sh

# after reboot, ssh back into instance
cd aws-p2-setup
./1-nvidia-docker.sh

# reboot manually, ssh back into instance
cd aws-p2-setup
./2-get-docker-things.sh

# All set!
```

From there, grab your deep learning code and run

```
sudo nvidia-docker run -it -v /home/ubuntu:/work ufoym/deepo bash
```

(Add `--rm` after `-it` to have the container restarted when you exit.)

You'll be dropped into another bash shell, this time inside the deep learning container. The home directory of the instance is mapped to `/work` inside the container. When you're done with everything

Quick tip: you can watch GPU performance as your code runs with

```
watch "nvidia-smi"
```

[docker]: https://docker.com
[nvidia-docker]: http://www.nvidia.com/
[ufoym-deepo]: https://hub.docker.com/r/ufoym/deepo/
