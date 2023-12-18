#!/bin/bash

#shebang or hashbang = "#!/bin/bash". It is a special syntax at the beginning of a script file that tells the operating system which interpreter should be used to execute the script

#In Terraform, the user_data argument in the aws_instance resource allows you to provide custom script or data that is run on the instance during its initialization. 
#This is often used to configure instances with software, perform tasks during bootstrapping, or set up the environment.
#setting up the environment for Docker on an Ubuntu system.

sudo apt-get update -y &&
sudo apt-get install -y \
apt-transport-https \
ca-certificates \
curl \
gnupg-agent \
software-properties-common &&
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add &&
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" &&
sudo apt-get update -y &&
sudo sudo apt-get install docker-ce docker-ce-cli containerd.io -y &&
sudo usermod -aG docker ubuntu 
1
2
3
4
5
6
7
8
9
10
11
12
13