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

if [[ "$reply" == '1' ]]; then
  curl -O "https://raw.github.com/xtremelabs/xlt-scripts-bash/master/ruby/setup-rbenv.sh" 1>/dev/null 2>/dev/null
  chmod u+x setup-rbenv.sh
  ./setup-rbenv.sh
elif [[ "$reply" == '2' ]]; then
  curl -O "https://raw.github.com/xtremelabs/xlt-scripts-bash/master/ruby/setup-rvm.sh" 1>/dev/null 2>/dev/null
  chmod u+x setup-rvm.sh
  ./setup-rvm.sh
else
  echo "ERROR: This should not happen"
  exit 1
fi
