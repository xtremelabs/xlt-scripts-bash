#!/usr/bin/env bash

source ../common/constants.sh

echo "This is resuming the setup of your development environment for Rails."

#Checking that Total Terminal is installed and clean-up
if [ ! -d /Applications/TotalTerminal.app/ ]
then
  echo "TotalTerminal installation FAILED."  
fi

rm -rf "$TOTALTERMINAL"
hdiutil unmount "/Volumes/TotalTerminal/"


#Installing Bash Prompt
brew install mercurial
brew install --HEAD vcprompt

#in Tanzeeb's tutorial but isn't working =(
#cat colours_bashprofile.sh >> ~/.bash_profile





#echo "NOTE the caveats from Homebrew. Make sure to read all of them and do what is necessary."
#echo "1. postgres"
#echo "2. mysql"
#echo "3. mongodb"
#echo "4. redis"
#echo "5. memcached"
#echo "6. done"
#brew info ___"

exit
