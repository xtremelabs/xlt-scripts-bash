#!/usr/bin/env bash

curl https://raw.github.com/xtremelabs/xlt-scripts-bash/master/common/constants.sh 1>/dev/null 2>/dev/null -o constants.sh
source constants.sh
rm -rf constants.sh

echo "This script will help you set up your development environment for iOS."

#Java should be installed by default on MacOSX installations

#Install XCode
echo "Installing XCode"
# from http://adcdownload.apple.com/Developer_Tools/xcode_4.5.1/xcode4510417539a.dmg
if [ ! -d /Applications/Xcode ]
then
  echo "Installing XCode"
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
  echo "Installing gitx"
  curl -O "http://assets.xtremelabs.com/xlt-scripts-bash/GitX.zip" 1>/dev/null 2>/dev/null
  unzip -o GitX.zip
  sudo cp GitX.app /Applications
  rm -rf GitX.zip GitX.app
fi

# Install Hardware IO Link Conditioner through XCODE_LINK_COND_LOC
if [ ! -e "/Applications/Hardware IO Tools" ]
then
  echo "Installing Hardware IO Link Conditioner for XCode"
  curl -O $XCODE_LINK_COND_LOC 1>/dev/null
  hdiutil mount $XCODE_LINK_COND_FILENAME
  sudo mkdir -p "/Applications/Hardware IO Tools"
  sudo cp -R "/Volumes/Hardware IO Tools" "/Applications/Hardware IO Tools"
  hdiutil unmount "/Volumes/Hardware IO Tools" 2>/dev/null
  open "/Volumes/Hardware IO Tools/Network Link Conditioner.prefPane"
fi

#TODO: Install script for resizing assets if it's ever found...
#echo "Installing script for resizing assets"

#Install developer color picker
if [ ! -d $HOME/Library/ColorPickers ]
then
  sudo mkdir -p $HOME/Library/ColorPickers
fi

if [ ! -e $HOME/Library/ColorPickers/DeveloperColorPicker.colorPicker ]
then
  echo "Installing Developer Color Picker"
  curl -O "http://assets.xtremelabs.com/xlt-scripts-bash/developercolorpicker.zip" 1>/dev/null 2>/dev/null
  unzip -o developercolorpicker.zip
  sudo cp "Developer Color Picker/DeveloperColorPicker.colorPicker" $HOME/Library/ColorPickers
  rm -rf developercolorpicker.zip "Developer Color Picker"
fi

#Install jq for JSON parsing (see http://stedolan.github.com/jq/tutorial/ for tutorial)
if [ ! -e /usr/bin/jq ]
then
  echo "Installing jq for JSON parsing (see http://stedolan.github.com/jq/tutorial/ for tutorial)"
  curl -O "http://assets.xtremelabs.com/xlt-scripts-bash/jq" 1>/dev/null 2>/dev/null
  sudo cp jq /usr/bin
  rm -rf jq
fi

#Install Crashlytics client
if [ ! -e /Applications/Crashlytics.app ]
then
  echo "Installing crashlytics client"
  curl -O "http://assets.xtremelabs.com/xlt-scripts-bash/Crashlytics.zip" 1>/dev/null 2>/dev/null
  unzip -o Crashlytics.zip
  sudo cp Crashlytics.app /Applications
  rm -rf Crashlytics.app Crashlytics.zip
fi

#Copy bookmarks
#Bookmarks
# https://www.owasp.org/index.php/IOS_Developer_Cheat_Sheet
# https://docs.urbanairship.com/display/DOCS/Home
# https://developer.apple.com/library/ios
echo "Installing browser bookmarks"
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
