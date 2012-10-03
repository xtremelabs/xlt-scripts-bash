#!/usr/bin/env bash

source ../common/helper-functions.sh
source ../common/constants.sh

delconf=""
while [[ "$delconf" != 'y' && "$delconf" != 'n' ]]; do
  read -p "Would you like to delete your existing .bash_profile file? > (y/n) " delconf
  echo "You entered: $delconf"
done

if [[ "$delconf" == 'y' ]]; then
  rm -rf ~/.bash_profile
fi

#install rvm and ruby-build + anything else mgr specific
curl -L https://get.rvm.io | bash -s stable

if [[ $? -eq 0 || -e $HOME/.rvm/bin/rvm ]]
then
  #Include rvm scripts into bash profile
  echo "if [[ -s $HOME/.rvm/scripts/rvm ]] ; then source $HOME/.rvm/scripts/rvm ; fi" >> $HOME/.bash_profile
  if [[ -s $HOME/.rvm/scripts/rvm ]];
  then
    source $HOME/.rvm/scripts/rvm
  fi

  brew install ruby-build

  #install ruby as well as bundler and pry gems through manager
  echo ""
  echo "=========="
  echo "Installing Ruby $RUBY_VERSION..."
  if [[ ! -d "$HOME/.rbenv/versions/$RUBY_VERSION" ]]
  then
    rvm install "$RUBY_VERSION"
    rbenv global "$RUBY_VERSION"
    ruby -v
  else
    echo "Ruby version $RUBY_VERSION already installed locally."
    rvm 
  fi

  echo ""
  echo "=========="
  echo "Installing useful gems"
  gem install bundler pry
else
  echo "Rvm installation failed. Please retry later."
fi

echo ""
echo "=========="
echo "Installing common databases and tools"
brew install postgres mysql mongodb redis memcached


echo ""
echo "=========="

if [ -d /Applications/TotalTerminal.app/ ]
then
  echo "TotalTerminal is already installed."

  chmod u+x setup-rvm-resume.sh
  ./setup-rvm-resume.sh
else
  install_success="n"
  echo "Downloading TotalTerminal..."
  wget "http://downloads-1.binaryage.com/$TOTALTERMINAL"
  url_verify "TotalTerminal"
  echo "Installing TotalTerminal"
  hdiutil mount "$TOTALTERMINAL"
  open "/Volumes/TotalTerminal/TotalTerminal.pkg"

  chmod u+x setup-rvm-resume.sh

  echo "Go through the installation instructions."
  echo "When finished installing TotalTerminal, do: ./setup-rvm-resume.sh"
fi

exit

