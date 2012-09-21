#!/usr/bin/env bash

source ../common/helper-functions.sh

RUBY_VERSION="1.9.3-p194"
TOTALTERMINAL="TotalTerminal-1.3.dmg"


echo "Starting installation with rbenv - implementing"

brew install rbenv ruby-build

echo "=========="
echo "Fulfilling Homebrew caveat for rbenv"
if [[ ! -f ~/.bash_profile ]]; then
  echo "need to create .bash_profile"
  touch ~/.bash_profile
else
  echo ".bash_profile found"
fi

echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> ~/.bash_profile
source ~/.bash_profile

echo ""
echo "=========="
echo "Installing Ruby $RUBY_VERSION..."
rbenv install "$RUBY_VERSION"
rbenv global "$RUBY_VERSION"
ruby -v

echo ""
echo "=========="
echo "Installing useful gems"
gem install bundler pry


echo ""
echo "=========="
echo "Installing common databases"
brew install postgres mysql mongodb redis memcached


echo ""
echo "=========="

if [ -d /Applications/TotalTerminal.app/ ]
then
  echo "TotalTerminal is already installed.";
else
  install_success="n"
  echo "Downloading TotalTerminal..."
  wget "http://downloads-1.binaryage.com/$TOTALTERMINAL"
  url_verify "TotalTerminal"
  echo "Installing TotalTerminal"
  hdiutil mount "$TOTALTERMINAL"
  open "/Volumes/TotalTerminal/TotalTerminal.pkg"

  chmod u+x setup-rbenv-resume.sh

  echo "Go through the installation instructions."
  echo "When finished installing TotalTerminal, do: ./setup-rbenv-resume.sh"
fi

exit
