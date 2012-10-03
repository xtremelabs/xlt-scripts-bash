#!/usr/bin/env bash

source ../common/helper-functions.sh
source ../common/constants.sh

echo "Starting installation with rbenv"

delconf=""
while [[ "$delconf" != 'y' && "$delconf" != 'n' ]]; do
  read -p "Would you like to delete your existing .bash_profile file? > (y/n) " delconf
  echo "You entered: $delconf"
done

if [[ "$delconf" == 'y' ]]; then
  rm -rf ~/.bash_profile
fi

brew install rbenv

if [[ $? -eq 0 || -e /usr/local/bin/rbenv ]]
then
  #To enable shims and autocompletion, add rbenv init to your profile
  echo "=========="
  echo "Fulfilling Homebrew caveat for rbenv"
  if [[ ! -f $HOME/.bash_profile ]]; then
    echo "need to create .bash_profile"
    touch $HOME/.bash_profile
  else
    echo ".bash_profile found"
  fi

  #echo 'if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi' >> $HOME/.bash_profile
  #bash_profile most likely empty at this point => no need to source
  #source $HOME/.bash_profile

  if [[ ! -e /usr/local/bin/ruby-build ]]
  then
    brew install ruby-build
  else
    echo "ruby-build already installed."
  fi
  
  echo ""
  echo "=========="
  echo "Installing Ruby $RUBY_VERSION..."
  if [[ ! -d "$HOME/.rbenv/versions/$RUBY_VERSION" ]]
  then
    rbenv install "$RUBY_VERSION"
    rbenv global "$RUBY_VERSION"
    ruby -v
  else
    echo "Ruby version $RUBY_VERSION already installed locally."
  fi

  echo ""
  echo "=========="
  echo "Installing useful gems"
  gem install bundler pry
else
  echo "Rbenv installation failed. Please retry later."
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

  chmod u+x setup-rbenv-resume.sh
  ./setup-rbenv-resume.sh
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
  echo "When finished installing TotalTerminal, run: ./setup-rbenv-resume.sh"
fi

exit
