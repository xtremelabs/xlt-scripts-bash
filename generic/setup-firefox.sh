#!/usr/bin/env bash

curl -O https://raw.github.com/xtremelabs/xlt-scripts-bash/master/common/helper-functions.sh 1>/dev/null 2>/dev/null
source helper-functions.sh
rm -rf helper-functions.sh

curl -O https://raw.github.com/xtremelabs/xlt-scripts-bash/master/common/constants.sh 1>/dev/null 2>/dev/null
source constants.sh
rm -rf constants.sh

#Assume wget is installed
#Install Firefox
if [ -d /Applications/Firefox.app/ ]
then
	echo "Firefox is already installed.";
else
	install_success="n"
	echo "Downloading Firefox..."
	wget "http://download.cdn.mozilla.net/pub/mozilla.org/firefox/releases/18.0.1/mac/en-US/Firefox 18.0.1.dmg"
	url_verify "Firefox"
	echo "Installing Firefox..."
	#install firefox
	hdiutil mount "Firefox 18.0.1.dmg"
	sudo cp -R "/Volumes/Firefox/Firefox.app" /Applications

	if [[ $? -eq 0 ]]
	then
		echo "FIREFOX: Install SUCCESS"
		install_success="y"
	fi

	hdiutil unmount "/Volumes/Firefox/"
	rm -rf "Firefox 18.0.1.dmg"

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

