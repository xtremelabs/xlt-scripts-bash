#!/usr/bin/env bash

echo "This script will help you set up your development environment for Rails."
echo "Which would you like to install?"
echo "1. rbenv"
echo "2. RVM"

reply=""
while [[ "$reply" != '1' && "$reply" != '2' ]]; do
  read -p "Enter 1 or 2 to select which one to install > " reply
  echo "You entered: $reply"
done

delconf=""
while [[ "$delconf" != 'y' && "$delconf" != 'n' ]]; do
  read -p "Would you like to delete your existing .bash_profile file? > (y/n) " delconf
  echo "You entered: $delconf"
done

if [[ "$delconf" == 'y' ]]; then
  rm -rf ~/.bash_profile
fi

if [[ "$reply" == '1' ]]; then
  chmod u+x setup-rbenv.sh
  ./setup-rbenv.sh
elif [[ "$reply" == '2' ]]; then
  chmod u+x setup-rvm.sh
  ./setup-rvm.sh
else
  echo "ERROR: This should not happen"
  exit 1
fi
