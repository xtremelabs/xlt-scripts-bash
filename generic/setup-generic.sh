#!/usr/bin/env bash

curl -O https://raw.github.com/xtremelabs/xlt-scripts-bash/master/common/helper-functions.sh 1>/dev/null 2>/dev/null
source helper-functions.sh
rm -rf helper-functions.sh

curl -O https://raw.github.com/xtremelabs/xlt-scripts-bash/master/common/constants.sh 1>/dev/null 2>/dev/null
source constants.sh
rm -rf constants.sh

###############################

#Retrieve SSH keys
echo "Checking for SSH key"
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
   echo "No SSH key found. Generating new key"
   ssh-keygen -t rsa;
fi

#Copy key contents and open github config page
echo "Copying public key to clipboard. Paste it into your Github account ..."
[[ -f $HOME/.ssh/github_rsa.pub ]] && cat $HOME/.ssh/github_rsa.pub | pbcopy
open https://github.com/account/ssh

# Delay for 5 seconds until github account page opens
sleep 5;

 
#Install Developer tools (depending on mac osx version)
MAC_VERSION=$(defaults read loginwindow SystemVersionStampAsString);

clt_image_location=""
echo ""
echo "=========="
if [[ "$MAC_VERSION" == 10.8.* ]]
then
   curl -O $XCODE_CLT_LOC_MLION 1>/dev/null
   clt_image_location=$XCODE_CLT_FILENAME_MLION
else
   curl -O $XCODE_CLT_LOC_LION 1>/dev/null
   clt_image_location=$XCODE_CLT_FILENAME_LION
fi

continueInst="n"
while [[ $continueInst == 'n' ]]; do
  open "$clt_image_location"
  # Delay prompt for 5 seconds until CLT image begins opening
  sleep 5;
  echo "Please install Command Line Tools for Xcode. It may take a moment to open the dmg."
  read -p "Do you have Command Line tools for Xcode installed now? (y/n) > " continueInst
  if [ $continueInst == "y" ]
  then
    echo "Continuing installation"
    hdiutil unmount "/Volumes/Command Line Tools (Lion)/"
  else
    #echo "Please install Command Line Tools from the mounted image"
    echo "Retrying to install Command Line Tools"
  fi
done


#Install Homebrew
command -v brew > /dev/null 2>&1 || {
  echo ""
  echo "=========="
  echo "Installing Homebrew, a good OS X package manager ..."
  ruby <(curl -fsS https://raw.github.com/mxcl/homebrew/go)
}

if [ $? -ne 0 ]
then
  echo "Homebrew install FAILED"
  exit 1
fi

#Needed before using Homebrew to install
echo "Brewing preparation"
brew update
brew doctor

echo ""
echo "=========="
#Setup github user and email fields (install git if appropriate too)
command -v git >/dev/null 2>&1 || {
	echo "Installing git..."
	brew install git
}
echo "git is installed"
curl -O "https://raw.github.com/xtremelabs/xlt-scripts-bash/master/generic/gconfig.sh" 1>/dev/null 2>/dev/null
chmod u+x gconfig.sh
./gconfig.sh


#Install wget using homebrew
echo ""
echo "=========="
echo "Installing wget from homebrew"
brew install wget


#Setup Chrome
echo ""
echo "=========="
curl -O "https://raw.github.com/xtremelabs/xlt-scripts-bash/master/generic/setup-chrome.sh" 1>/dev/null 2>/dev/null
chmod u+x setup-chrome.sh
./setup-chrome.sh


#Setup Firefox
echo ""
echo "=========="
curl -O "https://raw.github.com/xtremelabs/xlt-scripts-bash/master/generic/setup-firefox.sh" 1>/dev/null 2>/dev/null
chmod u+x setup-firefox.sh
./setup-firefox.sh

#Bookmarks - Wiki, Internal, etc
# http://mail.xtremelabs.com
# http://wiki.xtremelabs.com
# http://temperature.xtremelabs.com
# http://builds.xtremelabs.com
# http://www.pivotaltracker.com
# http://allocations.pivotallabs.com

curl -O "http://assets.xtremelabs.com/xlt-scripts-bash/Chrome Bookmarks.html" 1>/dev/null 2>/dev/null
cp "Chrome Bookmarks.html" $HOME/Desktop
rm -rf "Chrome Bookmarks.html"

curl -O "http://assets.xtremelabs.com/xlt-scripts-bash/Firefox Bookmarks.html" 1>/dev/null 2>/dev/null
cp "Firefox Bookmarks.html" $HOME/Desktop
rm -rf "Firefox Bookmarks.html"

echo "Chrome and Firefox bookmarks copied to your Desktop - please reimport into Bookmarks Toolbar if required."

#Update Safari bookmarks
#Currently not done as they are stored as separate files in <user>/Library/Caches/Metadata/Safari/Bookmarks and there's no safer way to export them than to backup those files

echo "All done!"
