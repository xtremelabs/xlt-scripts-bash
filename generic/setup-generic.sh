#!/usr/bin/env bash

source helper-functions.sh
source constants.sh

#Retrieve SSH keys
echo "Checking for SSH key, generating one if it doesn't exist ..."
if [ -f "$RSA_KEY_LOC" ]
then
   #Extract github identity in key given $1 (first line of grep output)
   GITHUB_USER=$( grep "$RSA_KEY_GITHUB_NAME_FIELD" "$RSA_KEY_LOC" |
             awk -v ghfield="$RSA_KEY_GITHUB_NAME_FIELD" '{ghf_len=length(ghfield); print substr($0,index($0,ghfield)+ghf_len)}' );

   #See if user wants to keep using this identity or generate new key
   reply=""
   while [[ $reply != 'y' && $reply != 'Y' && $reply != 'n' && $reply != 'N' ]]; do
      read -p "SSH key exists for identity: $GITHUB_USER. Do you want to keep using this key? (y/n) > " reply
      [[ $reply == 'n' || $reply == 'N' ]] && ssh-keygen -t rsa;
   done
   reply=""
else
   ssh-keygen -t rsa;
fi

#Copy key contents and open github config page
echo "Copying public key to clipboard. Paste it into your Github account ..."
[[ -f ~/.ssh/github_rsa.pub ]] && cat ~/.ssh/github_rsa.pub | pbcopy
open https://github.com/account/ssh

#Install Homebrew
echo "Installing Homebrew, a good OS X package manager ..."
ruby <(curl -fsS https://raw.github.com/mxcl/homebrew/go)
brew update

#Setup github user and email fields (install git if appropriate too)
command -v git >/dev/null 2>&1 || {
	echo "Installing git..."
	brew install git
}
chmod u+x gconfig.sh
./gconfig.sh


#Install wget using homebrew
brew install wget


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



#Update Safari bookmarks



#Bookmarks - Wiki, Internal, etc
# http://mail.xtremelabs.com
# http://wiki.xtremelabs.com
# http://temperature.xtremelabs.com
# http://builds.xtremelabs.com

