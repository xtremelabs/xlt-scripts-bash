#!/usr/bin/env bash
RSA_KEY_LOC=~/.ssh/github_rsa.pub
RSA_KEY_GITHUB_NAME_FIELD=" GitHub@"

echo "Checking for SSH key, generating one if it doesn't exist ..."
if [ -f "$RSA_KEY_LOC" ]
then
   #Extract github identity in key given $1 (first line of grep output)
   GITHUB_USER=$( grep "$RSA_KEY_GITHUB_NAME_FIELD" "$RSA_KEY_LOC" |
             awk -v ghfield="$RSA_KEY_GITHUB_NAME_FIELD" '{ghf_len=length(ghfield); print substr($0,index($0,ghfield)+ghf_len)}' );

   #See if user wants to keep using this identity or generate new key
   reply=""
   while [[ $reply != 'y' && $reply != 'Y' && $reply != 'n' && $reply != 'N' ]]; do
      read -p "SSH key exists for identity: $GITHUB_USER. Do you want to keep using this key? (y/n) > " reply
      [[ $reply == 'n' || $reply == 'N' ]] && ssh-keygen -t rsa;
   done
   reply=""
else
   ssh-keygen -t rsa;
fi

#Copy key contents and open github config page
echo "Copying public key to clipboard. Paste it into your Github account ..."
[[ -f ~/.ssh/github_rsa.pub ]] && cat ~/.ssh/github_rsa.pub | pbcopy
open https://github.com/account/ssh

#Setup github user and email fields (install git if appropriate too).. Or other scripts exist for this already (for config I know they do...)?
#command -v git >/dev/null 2>&1 || #install git here

#Assuming chrome is installed, update its bookmarks and extensions
command -v /Applications/Google\ Chrome.app >/dev/null 2>&1 || echo "need to install chrome..."#install chrome

#Update Safari bookmarks

#Update Firefox bookmarks

#Bookmarks - Wiki, Internal, etc
# http://mail.xtremelabs.com
# http://wiki.xtremelabs.com
# http://temperature.xtremelabs.com
# http://builds.xtremelabs.com
