#!/bin/bash
set -e

#===================================================================== 
# Clientscape DevOps Visual Studio Agent (Build/Release)
#========================================================================== 

#=== Install docker
sudo chmod 777 /usr/local/bin/

#=== Install Requirements

apt-get install -y npm

curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt-get update && sudo apt-get install yarn

curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install -y nodejs

wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit
phpunit --version

sudo apt-get install php-xdebug php-xml
 

#curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
#sudo apt-get install -y nodejs