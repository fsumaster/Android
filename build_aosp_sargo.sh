#!/usr/bin/env bash

echo updating the system real quick...
sudo apt update && sudo apt upgrade

echo installing repo...

mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

echo installing build tools...
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk android-tools-adb android-tools-fastboot

sudo apt update && sudo apt upgrade

mkdir /media/i95swervin/build/AOSP_BUILD

echo grabbing packages for sargo
echo https://developers.google.com/android/drivers

echo grabbing qcom package for sargo
cd ~/Downloads
wget https://dl.google.com/dl/android/aosp/qcom-sargo-qp1a.190711.020-3dfe91e8.tgz
tar zxvf qcom-sargo-qp1a.190711.020-3dfe91e8.tgz -C /media/i95swervin/build/AOSP_BUILD

echo grabbing google package for sargo
wget https://dl.google.com/dl/android/aosp/google_devices-sargo-qp1a.190711.020-84e6fe8a.tgz
tar zxvf google_devices-sargo-qp1a.190711.020-84e6fe8a.tgz -C /media/i95swervin/build/AOSP_BUILD


cd /media/i95swervin/build/AOSP_BUILD


echo grabbing the manifest...
repo init -u https://android.googlesource.com/platform/manifest.git -b android-10.0.0_r9
repo sync -c

echo double checking the sync is good...
repo sync -c --force-sync

echo execute the 2 required scriptsin the root of the source...
echo extract-qcom-sargo.sh
echo extract-google_devices-sargo.sh

echo sleeping for 240 seconds while you run the scripts mentioned above... chop chop
sleep 240

echo setting up build env...
. /build/envsetup.sh

echo selecting lunch aosp_sargo-userdebug 
lunch aosp_sargo-userdebug

echo starting the build with M...
m |& tee /tmp/buildaosp.log
