#!/usr/bin/env bash

source helper-functions.sh

#Assume wget is installed
#Install Chrome
if [ -d /Applications/Google\ Chrome.app/ ]
then
	echo "Google Chrome is already installed.";
else
	install_success="n"
	echo "Downloading Chrome..."
	wget https://dl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg --no-check-certificate
	url_verify "Chrome"
	echo "Installing Chrome..."
	#install chrome
	hdiutil mount googlechrome.dmg
	sudo cp -R "/Volumes/Google Chrome/Google Chrome.app" /Applications

	if [[ $? -eq 0 ]]
	then
		install_success="y"
	fi

	rm -rf "googlechrome.dmg"
	hdiutil unmount "/Volumes/Google Chrome/"

	if [ $install_success == "y" ]
	then
		echo "Google Chrome is installed"
	else
		echo "Google Chrome installation failed"
	fi
fi


#Update Chrome bookmarks

#Bookmarks - Wiki, Internal, etc
# http://mail.xtremelabs.com
# http://wiki.xtremelabs.com
# http://temperature.xtremelabs.com
# http://builds.xtremelabs.com

