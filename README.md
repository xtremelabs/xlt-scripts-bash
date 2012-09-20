This is a script to quickly set up your typical environment on Mac OS X.

# What it does
--------------
It will do the following, if necessary:
* save and generate SSH keys
* install Command Line Tools for Xcode (for Homebrew)
* install Homebrew
* sets up git config with your name and email
* install wget
* install Chrome
* install Firefox


# How to use
------------

This script is designed to run on a fresh install of a Mac OS X. It was tested on Lion.

To run the script:
    chmod u+x setup-generic.sh
    ./setup-generic.sh


While this is an automated script, there requires some user interaction. 
You will need to:
* save and generate your SSH keys and paste into GitHub
* setup your git account information on GitHub
* configure git-config with your account information
* manually click through installation for Command Line Tools
* acknowledge installation of Homebrew
* enter the password to install Chrome/Firefox

Note: Do NOT run the script as sudo. Homebrew will refuse to install as root and subsequently, the script will not install everything. 
