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
  curl -O $XCODE_LOC 1>/dev/null
  hdiutil mount $XCODE_FILENAME
  sudo cp -R "/Volumes/Xcode" /Applications
  hdiutil unmount "/Volumes/Xcode" 2>/dev/null
fi

#Install AppleScript 
#echo "Installing AppleScript"
#Installed with xCode

#Install XCode Command Line Tools
#Installed by General Environment Setup script - please run that or install manually through DMG loc in constants script (XCODE_CLT_LOC_<VERSION>)

# Install gitx
if [ ! -d /Applications/GitX.app ]
then
  curl -O "http://assets.xtremelabs.com/xlt-scripts-bash/GitX.app" 1>/dev/null 2>/dev/null
  sudo cp GitX.app /Applications
fi

# Install Hardware IO Link Conditioner thru XCODE_LINK_COND_LOC
if [ ! -e "/Applications/Hardware IO Tools" ]
then
  curl -O $XCODE_LINK_COND_LOC 1>/dev/null
  hdiutil mount $XCODE_LINK_COND_FILENAME
  sudo mkdir -p "/Applications/Hardware IO Tools"
  sudo cp -R "/Volumes/Hardware IO Tools" "/Applications/Hardware IO Tools"
  hdiutil unmount "/Volumes/Hardware IO Tools" 2>/dev/null
fi

#TODO: Install script for resizing assets
#echo "Installing script for resizing assets"

#Copy bookmarks
#Bookmarks
# https://www.owasp.org/index.php/IOS_Developer_Cheat_Sheet
# https://docs.urbanairship.com/display/DOCS/Home
# https://developer.apple.com/library/ios
curl "http://assets.xtremelabs.com/xlt-scripts-bash/Chrome%20iOS%20Bookmarks.html" -o "Chrome iOS Bookmarks.html" 1>/dev/null 2>/dev/null
cp "Chrome iOS Bookmarks.html" $HOME/Desktop
rm -rf "Chrome iOS Bookmarks.html"

curl "http://assets.xtremelabs.com/xlt-scripts-bash/Firefox%20iOS%20Bookmarks.html" -o "Firefox iOS Bookmarks.html" 1>/dev/null 2>/dev/null
cp "Firefox iOS Bookmarks.html" $HOME/Desktop
rm -rf "Firefox iOS Bookmarks.html"

echo "Chrome and Firefox iOS bookmarks copied to your Desktop - please reimport into Bookmarks Toolbar if required."

echo "----"
echo "iOS setup all done."
exit
