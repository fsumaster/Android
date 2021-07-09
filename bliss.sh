#!/bin/bash


       echo "Compatible version packages for 18.04lts are being installed..."
       sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk adb fastboot

cd ~/
echo Creating build directory...
mkdir bliss

echo Grabbing repo...
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

#cd ~/hub/tg
#bash telegram-start
#echo build started!!

echo Setting some shit...
cd ~/bliss
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_EXEC=/usr/bin/ccache
export TEMPORARY_DISABLE_PATH_RESTRICTIONS=true
source ~/.bashrc

. build/envsetup.sh
lunch bliss_sargo-userdebug
echo Build Started!!
make blissify |& tee /tmp/build.log
