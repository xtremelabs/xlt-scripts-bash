#!/usr/bin/env bash

source helper-functions.sh

#Assume wget is installed
#Install Chrome
if [ -d /Applications/Google\ Chrome.app/ ]
then
	echo "Google Chrome is already installed.";
else
	echo "Downloading Chrome..."
	wget https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg --no-check-certificate
	url_verify "Chrome"
	echo "Installing Chrome..."
	#install chrome
	hdiutil mount googlechrome.dmg
	sudo cp -R "/Volumes/Google Chrome/Google Chrome.app" /Applications
	hdiutil unmount "/Volumes/Google Chrome/"
	echo "Google Chrome is installed"
fi


#Update Chrome bookmarks

#Bookmarks - Wiki, Internal, etc
# http://mail.xtremelabs.com
# http://wiki.xtremelabs.com
# http://temperature.xtremelabs.com
# http://builds.xtremelabs.com

