#!/bin/bash


if [ $# -ne 1 ];then
echo "USAGE: ./instalarDocker [USER]"
else
#fer update
apt update

#instalar paquets

apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y

#afegir clau asimetrica

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

#afegir repositori al fitxer sources.list

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

#tornar a fer el update amb els nous repositoris

apt-get update

#instalar el contingut

sudo apt-get install docker-ce docker-ce-cli containerd.io -y

#un cop instal·lat afegir l'usuari al grup

sudo usermod -aG docker $1

newgrp docker

fi
