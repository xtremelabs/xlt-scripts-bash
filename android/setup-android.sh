#!/usr/bin/env bash

source ../common/constants.sh

echo "This script will help you set up your development environment for Android."

#Java should be installed by default on MacOSX installations

#Grab Eclipse archive
if [[ ! -e $ECLIPSE_ARCHIVE_FILENAME ]]
then
  #wget $ECLIPSE_ARCHIVE_LOC 
  curl -O $ECLIPSE_ARCHIVE_LOC
  echo "Finished downloading Eclipse archive"
fi

echo "Untarring Eclipse archive"
if [[ ! -d eclipse ]]
then
  tar xzf $ECLIPSE_ARCHIVE_FILENAME
fi

#Install Eclipse
echo "Installing Eclipse"
if [[ -d $ECLIPSE_INSTALL_LOC ]]
then
  reply=""
  while [[ "$reply" != 'y' && "$reply" != 'n' ]]; do
    read -p "Do you want to remove your current eclipse installation? > (y/n): " reply
  done

  if [[ "$reply" == 'y' ]]; then
    sudo rm -rf $ECLIPSE_INSTALL_LOC
    sudo cp -R eclipse $ECLIPSE_INSTALL_LOC
  fi
else
 sudo cp -R eclipse $ECLIPSE_INSTALL_LOC
fi

#Install and update Android SDK
echo "Installing Android SDK"
if [[ ! -d $ANDROID_SDK_INSTALL_LOC ]]
then
  unzip -o ../assets/android-sdk_r20.0.3-macosx.zip -d ../assets
  sudo cp -R ../assets/android-sdk-macosx $ANDROID_SDK_INSTALL_LOC
fi

echo "Updating Android SDK with API16-13 (4.1 to 3.0)"
sudo $ANDROID_SDK_INSTALL_LOC/tools/android --clear-cache list sdk

sudo $ANDROID_SDK_INSTALL_LOC/tools/android --clear-cache update sdk --no-ui --filter platform-tools,android-16,extra-android-support

# --filter platform-tools,doc,android-16,android-15,android-14,android-13,android-12,android-11,extra-android-support


echo "Installing plugins"
#java -jar $ECLIPSE_INSTALL_LOC/plugins/org.eclipse.equinox.launcher_$ECLIPSE_EQUINOX_LAUNCHER_VERSION.jar \
#    -application  org.eclipse.update.core.standaloneUpdate \
#    -command search \
#    -from "https://dl-ssl.google.com/android/eclipse/"

#Install ADT and prereqs
$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU com.android.ide.eclipse.base \
  -metadataRepository http://dl-ssl.google.com/android/eclipse/ \
  -artifactRepository http://dl-ssl.google.com/android/eclipse/
#had https above for base

$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU com.android.ide.eclipse.ddms \
  -metadataRepository http://dl-ssl.google.com/android/eclipse/ \
  -artifactRepository http://dl-ssl.google.com/android/eclipse/
#had https above for ddms

$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU org.eclipse.wst.sse.core \
  -metadataRepository http://download.eclipse.org/releases/juno/ \
  -artifactRepository http://download.eclipse.org/releases/juno/

$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU org.eclipse.wst.sse.ui \
  -metadataRepository http://download.eclipse.org/releases/juno/ \
  -artifactRepository http://download.eclipse.org/releases/juno/

$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU org.eclipse.wst.xml.core \
  -metadataRepository http://download.eclipse.org/releases/juno/ \
  -artifactRepository http://download.eclipse.org/releases/juno/

$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU org.eclipse.wst.xml.ui \
  -metadataRepository http://download.eclipse.org/releases/juno/ \
  -artifactRepository http://download.eclipse.org/releases/juno/

$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU com.android.ide.eclipse.adt \
  -metadataRepository http://dl-ssl.google.com/android/eclipse/ \
  -artifactRepository http://dl-ssl.google.com/android/eclipse/
#had https above for adt
#END INSTALL ADT

#Install Eclipse Color Theme
$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU com.github.fhd.eclipsecolortheme.feature.feature.group \
  -metadataRepository http://eclipse-color-theme.github.com/update/ \
  -artifactRepository http://eclipse-color-theme.github.com/update/
#END INSTALL ECLIPSE COLOR THEME

#Install Eclipse PMD
$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU net.sourceforge.pmd.eclipse.feature.group \
  -metadataRepository http://pmd.sourceforge.net/eclipse/ \
  -artifactRepository http://pmd.sourceforge.net/eclipse/
#END INSTALL ECLIPSE PMD

#Install Eclipse FindBugs
$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU edu.umd.cs.findbugs.plugin.eclipse.feature.group \
  -metadataRepository http://findbugs.cs.umd.edu/eclipse/ \
  -artifactRepository http://findbugs.cs.umd.edu/eclipse/
#END INSTALL ECLIPSE FINDBUGS

#Copy bookmarks

echo "Android setup all done."
#exit

#reply=""
#while [[ "$reply" != '1' && "$reply" != '2' ]]; do
#  read -p "Enter 1 or 2 to select which one to install > " reply
#  echo "You entered: $reply"
#done

#if [[ "$reply" == '1' ]]; then
#  chmod u+x setup-rbenv.sh
#  ./setup-rbenv.sh
#elif [[ "$reply" == '2' ]]; then
#  chmod u+x setup-rvm.sh
#  ./setup-rvm.sh
#else
#  echo "ERROR: This should not happen"
#  exit 1
#fi
