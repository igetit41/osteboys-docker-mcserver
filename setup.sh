export GITPATH=/home/d3f1l3/osteboys-docker-mcserver

sudo apt update -y
sudo apt install -y git-all

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

sudo groupadd docker
sudo usermod -a -G docker $USER
newgrp docker


git config --global --add safe.directory '*'

git clone https://github.com/igetit41/osteboys-docker-mcserver

#sudo git -C $GITPATH reset --hard
#sudo git -C $GITPATH pull origin main

mkdir $GITPATH/minecraftserver/modpacks

# ATM9 SB
#sudo curl -O https://mediafilez.forgecdn.net/files/5952/312/server-1.1.3.zip
#sudo mv ./server-1.1.3.zip $GITPATH/minecraftserver/modpacks/server-1.1.3.zip

# ATM9
sudo curl -O https://mediafilez.forgecdn.net/files/4752/160/Server-Files-0.1.0.zip
sudo mv ./Server-Files-0.1.0.zip $GITPATH/minecraftserver/modpacks/Server-Files-0.1.0.zip


# ATM10
#curl -O https://mediafilez.forgecdn.net/files/6028/982/Server-Files-2.13.zip
#mv ./Server-Files-2.13.zip $GITPATH/minecraftserver/modpacks/Server-Files-2.13.zip

sudo chmod +x $GITPATH/minecraftserver/minecraftserver.sh

sudo cp $GITPATH/minecraftserver/minecraftserver.service /etc/systemd/system/minecraftserver.service

sudo systemctl daemon-reload
sudo systemctl restart minecraftserver
