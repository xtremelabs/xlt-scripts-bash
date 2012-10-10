#!/usr/bin/env bash

curl https://raw.github.com/xtremelabs/xlt-scripts-bash/master/common/constants.sh 1>/dev/null 2>/dev/null -o constants.sh
source constants.sh
rm -rf constants.sh

echo "This script will help you set up your development environment for iOS."

#Java should be installed by default on MacOSX installations

#Install xCode
echo "Installing xCode"
# from http://adcdownload.apple.com/Developer_Tools/xcode_4.5.1/xcode4510417539a.dmg
if [ ! -d /Applications/Xcode ]
then
  #TODO: Better check for XCode version...
  curl -O $XCODE_LOC 1>/dev/null 2>/dev/null
  hdutil mount $XCODE_FILENAME
  sudo cp -R "/Volumes/Xcode" /Applications
fi

#Install AppleScript 
#echo "Installing AppleScript"
#Installed with xCode

#Install XCode Command Line Tools
#Installed by General Environment Setup script - please run that or install manually through DMG loc in constants script

#TODO: Install gitx

#TODO: Install Hardware IO Link Conditioner thru XCODE_LINK_COND_LOC

#TODO: Install script for resizing assets
#echo "Installing script for resizing assets"

#Copy bookmarks
#Bookmarks
# https://www.owasp.org/index.php/IOS_Developer_Cheat_Sheet
# https://docs.urbanairship.com/display/DOCS/Home
curl -O "https://raw.github.com/xtremelabs/xlt-scripts-bash/master/assets/Chrome iOS Bookmarks.html" 1>/dev/null 2>/dev/null
cp "Chrome iOS Bookmarks.html" $HOME/Desktop
rm -rf "Chrome iOS Bookmarks.html"

curl -O "https://raw.github.com/xtremelabs/xlt-scripts-bash/master/assets/Firefox iOS Bookmarks.html" 1>/dev/null 2>/dev/null
cp "Firefox iOS Bookmarks.html" $HOME/Desktop
rm -rf "Firefox iOS Bookmarks.html"

echo "Chrome and Firefox iOS bookmarks copied to your Desktop - please reimport into Bookmarks Toolbar if required."

echo "----"
echo "iOS setup all done."
#exit
