#!/usr/bin/env bash

source ../common/helper-functions.sh
source ../common/constants.sh

#Assume wget is installed
#Install Firefox
if [ -d /Applications/Firefox.app/ ]
then
	echo "Firefox is already installed.";
else
	install_success="n"
	echo "Downloading Firefox..."
	wget http://download.cdn.mozilla.net/pub/mozilla.org/firefox/releases/latest/mac/en-US/"$FIREFOX_VERSION"
	url_verify "Firefox"
	echo "Installing Firefox..."
	#install firefox
	hdiutil mount "$FIREFOX_VERSION"
	sudo cp -R "/Volumes/Firefox/Firefox.app" /Applications

	if [[ $? -eq 0 ]]
	then
		echo "FIREFOX: Install SUCCESS"
		install_success="y"
	fi

	hdiutil unmount "/Volumes/Firefox/"
	rm -rf "$FIREFOX_VERSION"

	if [ $install_success == "y" ]
	then
		echo "Firefox is installed"
	else
		echo "Firefox installation FAILED"
	fi
fi


#Update Firefox bookmarks

#Bookmarks - Wiki, Internal, etc
# http://mail.xtremelabs.com
# http://wiki.xtremelabs.com
# http://temperature.xtremelabs.com
# http://builds.xtremelabs.com

