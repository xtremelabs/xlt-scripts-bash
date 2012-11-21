This is a collection of scripts to quickly set up your environment on Mac OS X.

# Installation/TLDR Instructions:
--------------
Generic environment setup script: curl -Lo- https://raw.github.com/xtremelabs/xlt-scripts-bash/master/generic/setup-generic.sh | bash

Ruby script (note: some packages may require further setup for listed
Homebrew caveats): curl -Lo- https://raw.github.com/xtremelabs/xlt-scripts-bash/master/ruby/setup-ruby.sh | bash

Android script: curl -Lo- https://raw.github.com/xtremelabs/xlt-scripts-bash/master/android/setup-android.sh | bash

iOS script: curl -Lo- https://raw.github.com/xtremelabs/xlt-scripts-bash/master/ios/setup-ios.sh | bash

# Generic: What it does
--------------
It will do the following, if necessary:
* save and generate SSH keys
* install Command Line Tools for Xcode (for Homebrew)
* install Homebrew
* sets up git config with your name and email
* install wget
* install Chrome
* install Firefox


# Generic: How to use
------------

This script is designed to run on a fresh install of a Mac OS X. It was tested on Lion.

To run the script:
<pre>cd generic
chmod u+x setup-generic.sh
./setup-generic.sh</pre>


There requires some user interaction. You will need to:
* save and generate your SSH keys and paste into GitHub
* setup your git account information on GitHub
* configure git-config with your account information
* manually click through installation for Command Line Tools
* acknowledge installation of Homebrew
* enter the password to install Chrome/Firefox

Note: Do NOT run the script as sudo. Homebrew will refuse to install as root and subsequently, the script will not install everything.

# Ruby: What it does
-------------
Requires: XCode (or XCode tools) to be setup for brew (i.e. run generic script first)
-------------
Installs everything http://tech.xtremelabs.com/how-to-setup-your-mac-for-rails-development/ mentions either with RVM or RBENV (selected on startup)

For subsequent runs of the script, most applications detect if they are already installed, and user is prompted whether they want to delete and replace their bash_profile script since the script concatenates most entries programs require.

Users are encouraged to check application caveats through brew info <application name> to see if they need to perform any additional steps to configure the installation. 


# Android: What it does
-------------
Installs Eclipse 4.2 (Juno), Android SDK (r20) as well as ADT, Color Theme, PMD and FindBugs plugins. Copies some common Android bookmarks so user can import into major browsers too.


# iOS: What it does
-------------
Installs XCode, Hardware IO Link Conditioner, gitx, DeveloperColorPicker, jq (JSON parsing tool) and Crashlytics client. Copies some common Android bookmarks so user can import into major browsers too.
