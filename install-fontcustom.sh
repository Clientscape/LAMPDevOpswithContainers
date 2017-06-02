#!/bin/bash
set -e

#===================================================================== 
# Clientscape : Install FontCustom
#========================================================================== 

#=== Install curl & unzip
sudo apt-get install -y curl unzip

#=== Install fontForge
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:fontforge/fontforge
sudo apt-get update

sudo apt-get install -y fontforge ttfautohint woff-tools ruby-dev
wget https://people.mozilla.com/~jkew/woff/woff-code-latest.zip
unzip -o woff-code-latest.zip -d sfnt2woff
cd sfnt2woff
make
sudo mv sfnt2woff /usr/local/bin/

#=== Run GEM fontcustom
sudo gem update --system
sudo gem install fontcustom
