#!/usr/bin/env bash

curl -O https://raw.github.com/xtremelabs/xlt-scripts-bash/master/common/constants.sh 1>/dev/null 2>/dev/null
source constants.sh
rm -rf constants.sh

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
  fi
fi
sudo mkdir -p $ECLIPSE_INSTALL_LOC
sudo cp -R eclipse/* $ECLIPSE_INSTALL_LOC

#Install and update Android SDK
echo "Installing Android SDK"
if [[ -d $ANDROID_SDK_INSTALL_LOC ]]
then
  reply=""
  while [[ "$reply" != 'y' && "$reply" != 'n' ]]; do
    read -p "Do you want to remove your current Android SDK installation? > (y/n): " reply
  done

  if [[ "$reply" == 'y' ]]; then
    sudo rm -rf $ANDROID_SDK_INSTALL_LOC
  fi
fi
mkdir -p $ANDROID_SDK_INSTALL_LOC
curl -O $ANDROID_SDK_ZIP_LOC 1>/dev/null
unzip -o $ANDROID_SDK_ZIP_FILENAME
sudo cp -R android-sdk-macosx/* $ANDROID_SDK_INSTALL_LOC

echo "Updating Android SDK"
#sudo $ANDROID_SDK_INSTALL_LOC/tools/android list sdk

#Install SDK platform
sudo $ANDROID_SDK_INSTALL_LOC/tools/android update sdk --no-ui --filter $ANDROID_UPDATE_FILTER_SDK

echo "Updating Android System images, docs, samples and source code"
#Install docs, samples, sources and system images
sudo $ANDROID_SDK_INSTALL_LOC/tools/android update sdk --no-ui --filter $ANDROID_UPDATE_FILTER_DOCS

echo "----"
echo "Installing plugins"

INSTALLED_ECLIPSE_PLUGINS=$($ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -listInstalledRoots);

if [[ "$INSTALLED_ECLIPSE_PLUGINS" != *com.android.ide.eclipse.base* ||
      "$INSTALLED_ECLIPSE_PLUGINS" != *com.android.ide.eclipse.ddms* ]]; then
#Install ADT and prereqs (ddms, sse and xml core and ui)
$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU com.android.ide.eclipse.base \
  -installIU com.android.ide.eclipse.ddms \
  -metadataRepository http://dl-ssl.google.com/android/eclipse/ \
  -artifactRepository http://dl-ssl.google.com/android/eclipse/
fi
#had https above for base, ddms

if [[ "$INSTALLED_ECLIPSE_PLUGINS" != *org.eclipse.wst.sse.core* ||
      "$INSTALLED_ECLIPSE_PLUGINS" != *org.eclipse.wst.sse.ui* ||
      "$INSTALLED_ECLIPSE_PLUGINS" != *org.eclipse.wst.xml.core* ||
      "$INSTALLED_ECLIPSE_PLUGINS" != *org.eclipse.wst.xml.ui* ]]; then
$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU org.eclipse.wst.sse.core \
  -installIU org.eclipse.wst.sse.ui \
  -installIU org.eclipse.wst.xml.core \
  -installIU org.eclipse.wst.xml.ui \
  -metadataRepository http://download.eclipse.org/releases/juno/ \
  -artifactRepository http://download.eclipse.org/releases/juno/
fi

if [[ "$INSTALLED_ECLIPSE_PLUGINS" != *com.android.ide.eclipse.adt* ]]; then
$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU com.android.ide.eclipse.adt \
  -metadataRepository http://dl-ssl.google.com/android/eclipse/ \
  -artifactRepository http://dl-ssl.google.com/android/eclipse/
fi
#had https above for adt
#END INSTALL ADT

#Install Eclipse Color Theme
if [[ "$INSTALLED_ECLIPSE_PLUGINS" != *com.github.fhd.eclipsecolortheme.feature.feature.group* ]]; then
$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU com.github.fhd.eclipsecolortheme.feature.feature.group \
  -metadataRepository http://eclipse-color-theme.github.com/update/ \
  -artifactRepository http://eclipse-color-theme.github.com/update/
fi
#END INSTALL ECLIPSE COLOR THEME

#Install Eclipse PMD
if [[ "$INSTALLED_ECLIPSE_PLUGINS" != *net.sourceforge.pmd.eclipse.feature.group* ]]; then
$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU net.sourceforge.pmd.eclipse.feature.group \
  -metadataRepository http://pmd.sourceforge.net/eclipse/ \
  -artifactRepository http://pmd.sourceforge.net/eclipse/
fi
#END INSTALL ECLIPSE PMD

#Install Eclipse FindBugs
if [[ "$INSTALLED_ECLIPSE_PLUGINS" != *edu.umd.cs.findbugs.plugin.eclipse.feature.group* ]]; then
$ECLIPSE_INSTALL_LOC/eclipse -nosplash -consolelog -clean \
  -application org.eclipse.equinox.p2.director \
  -installIU edu.umd.cs.findbugs.plugin.eclipse.feature.group \
  -metadataRepository http://findbugs.cs.umd.edu/eclipse/ \
  -artifactRepository http://findbugs.cs.umd.edu/eclipse/
fi
#END INSTALL ECLIPSE FINDBUGS

#Copy bookmarks
#Bookmarks
# http://www.androidpatterns.com/
# http://developer.android.com/reference/packages.html
curl "http://assets.xtremelabs.com/xlt-scripts-bash/Chrome%20Android%20Bookmarks.html" -o "Chrome Android Bookmarks.html"  1>/dev/null 2>/dev/null
cp "Chrome Android Bookmarks.html" $HOME/Desktop
rm -rf "Chrome Android Bookmarks.html"

curl "http://assets.xtremelabs.com/xlt-scripts-bash/Firefox%20Android%20Bookmarks.html" -o "Firefox Android Bookmarks.html" 1>/dev/null 2>/dev/null
cp "Firefox Android Bookmarks.html" $HOME/Desktop
rm -rf "Firefox Android Bookmarks.html"
echo "Chrome and Firefox Android bookmarks copied to your Desktop - please reimport into Bookmarks Toolbar if required."

echo "----"
echo "Android setup all done."
#exit
