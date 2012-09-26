#!/usr/bin/env bash

source ../common/constants.sh

echo "This is resuming the setup of your development environment for Rails."

#Checking that Total Terminal is installed and clean-up
if [ ! -d /Applications/TotalTerminal.app/ ]
then
  echo "TotalTerminal installation FAILED."  
fi

rm -rf "$TOTALTERMINAL"
hdiutil unmount "/Volumes/TotalTerminal/" 2>/dev/null

#Installing Bash Prompt
brew install mercurial
brew install --HEAD vcprompt

#in Tanzeeb's tutorial but isn't working =(
#cat colours_bashprofile.sh >> ~/.bash_profile

if [[ ! -f ~/.bash_profile ]]
then
  touch ~/.bash_profile
fi

#setup bash prompt
cat colours_bashprofile_rvm.sh >> ~/.bash_profile

#Setup Tomorrow Night theme (via https://github.com/chriskempson/tomorrow-theme/tree/master/OS%20X%20Terminal)
open "Tomorrow Night.terminal"

#add color to default commands like ls
echo "export CLICOLOR=1" >> ~/.bash_profile

#add color to git output
git config --global color.ui true

#install and setup autocompletion for bash
brew install bash-completion
echo "if [ -f `brew --prefix`/etc/bash_completion ]; then
. `brew --prefix`/etc/bash_completion
fi" >> ~/.bash_profile

#zsh setup omitted, but if you want to pursue, check Oh-my-zsh (https://github.com/robbyrussell/oh-my-zsh/)

#brew install macvim
#Install and setup MacVim (depending on mac osx version)
MAC_VERSION=$(defaults read loginwindow SystemVersionStampAsString);

mvim_image_location=""
echo ""
echo "=========="
if [[ "$MAC_VERSION" == 10.8.* ]]
then 
   mvim_image_location="../assets/MacVim macosx 107 snapshot 64.app"
elif [[ "$MAC_VERSION" == 10.7.* ]]
then
   mvim_image_location="../assets/MacVim macosx 107 snapshot 64.app"
else
   echo "Please install MacVim manually (e.g. visit https://github.com/b4winckler/macvim/downloads) as only Mountain Lion and Lion binaries are included as assets"
fi
sudo cp -R "$mvim_image_location" "/Applications/MacVim.app"

if [[ $? -eq 0 || -d /Applications/MacVim.app ]]
then
  #install Janus library of plugins
  curl -Lo- https://bit.ly/janus-bootstrap | bash

  #install few more plugins and configure colors
  mkdir ~/.janus && cd ~/.janus
  git clone https://github.com/bbommarito/vim-slim # Syntax highlighting for Slim templates
  git clone https://github.com/godlygeek/tabular   # Easy formatting for tables, useful for Cucumber features
  #go back to previous script dir and copy vim color assets from saved tomorrow-theme
  cd -
  cp -R ../assets/vim ~/.janus/tomorrow-theme
  echo "color tomorrow-night" > ~/.vimrc.after
else
  echo "Macvim installation failed. Please retry by rerunning script or through \"brew install macvim\""
fi

#try to link apps installed in non-standard locations to ~/Applications
brew linkapps

echo "NOTE the caveats from Homebrew (visible with \"brew info <application from below>\"). Make sure to read all of them and do what is necessary."
echo "1. postgres"
echo "2. mysql"
echo "3. mongodb"
echo "4. redis"
echo "5. memcached"
echo "6. done"
#brew info ___"

#exit
