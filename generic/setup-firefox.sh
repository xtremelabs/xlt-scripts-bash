#!/usr/bin/env bash

source helper-functions.sh

#Assume wget is installed
#Install Firefox
if [ -d /Applications/Firefox.app/ ]
then
	echo "Firefox is already installed.";
else
	echo "Downloading Firefox..."
	wget http://download.cdn.mozilla.net/pub/mozilla.org/firefox/releases/latest/mac/en-US/"$FIREFOX_VERSION"
	url_verify "Firefox"
	echo "Installing Firefox..."
	#install firefox
	hdiutil mount "$FIREFOX_VERSION"
	sudo cp -R "/Volumes/Firefox/Firefox.app" /Applications
	hdiutil unmount "/Volumes/Firefox/"
	echo "Firefox is installed"
fi


#Update Firefox bookmarks

#Bookmarks - Wiki, Internal, etc
# http://mail.xtremelabs.com
# http://wiki.xtremelabs.com
# http://temperature.xtremelabs.com
# http://builds.xtremelabs.com

