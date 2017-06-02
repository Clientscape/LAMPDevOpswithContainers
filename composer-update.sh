#!/bin/bash
set -e

#===================================================================== 
# Clientscape Composer Update 
#========================================================================== 

#=== Install curl
sudo apt-get install -y curl

#=== Install PHP
sudo apt-get install -y php php-curl

#=== Install php-imap
sudo apt-get update
sudo apt-get install -y libc-client-dev libkrb5-dev
sudo rm -r /var/lib/apt/lists/*
sudo apt-get update
sudo apt-get install -y php-imap

#=== Install PHP Composer
sudo curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

sudo apt-get install -y software-properties-common

#=== Install PHP Phalcon #1
curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | sudo bash
sudo apt-get install -y php7.0-phalcon

#=== Prep SSH tunnel
mkdir -p ~/.ssh
sudo cp config/id_rsa ~/.ssh/id_rsa
sudo cp config/id_rsa.pub ~/.ssh/id_rsa.pub
sudo cp config/known_hosts ~/.ssh/known_hosts
sudo chmod 600 ~/.ssh/id_rsa

#=== Run Composer update
#cd src
#sudo composer update --verbose 

