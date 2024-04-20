#!/bin/bash
#Install Docker
sudo apt update -y

sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update -y

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

sudo service docker start
sudo usermod -a -G docker $USER
newgrp docker


# Clone Repo
cd ~
git clone https://github.com/igetit41/osteboys-docker-mcserver
sudo chmod +x ~/osteboys-docker-mcserver/minecraftserver/minecraftserver.sh

sudo cp ~/osteboys-docker-mcserver/minecraftserver/minecraftserver.service /etc/systemd/system/minecraftserver.service

sudo systemctl enable minecraftserver
sudo systemctl restart minecraftserver
