#!/usr/bin/env bash

source helper-functions.sh
source constants.sh

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
[[ -f ~/.ssh/github_rsa.pub ]] && cat ~/.ssh/github_rsa.pub | pbcopy
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
   clt_image_location="../assets/command_line_tools_for_xcode_os_x_mountain_lion_aug_2012.dmg"
else
   clt_image_location="../assets/command_line_tools_for_xcode_os_x_lion_aug_2012.dmg"
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
chmod u+x setup-chrome.sh
./setup-chrome.sh


#Setup Firefox
echo ""
echo "=========="
chmod u+x setup-firefox.sh
./setup-firefox.sh

exit

#Update Safari bookmarks

#Bookmarks - Wiki, Internal, etc
# http://mail.xtremelabs.com
# http://wiki.xtremelabs.com
# http://temperature.xtremelabs.com
# http://builds.xtremelabs.com
# http://www.pivotaltracker.com
# http://allocations.pivotallabs.com
