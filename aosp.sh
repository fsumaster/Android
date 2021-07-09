#!/bin/bash
mkdir ~/Desktop/aosp_build-$(date +"%m-%d-%Y")
#mkdir ~/aosp_build
cd ~/aosp_build
#repo init -u https://android.googlesource.com/platform/manifest.git -b android-11.0.0_r3
#repo sync
#bash extract-qcom-sargo.sh 
#bash extract-google_devices-sargo.sh 
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_EXEC=/usr/bin/ccache
. build/envsetup.sh 
lunch aosp_sargo-userdebug
m signapk
time m 
echo Done building! Copying files and creating a update...
cd ~/aosp_build/out/target/product/sargo
cp boot.img dtbo.img vbmeta.img system.img system_ext.img product.img vendor.img android-info.txt "/home/i95swervin/Desktop/aosp_build-$(date +"%m-%d-%Y")"
cd ~/Desktop/aosp_build-$(date +"%m-%d-%Y") 
zip aosp_11_gapps$(date +"%m-%d-%Y").zip boot.img dtbo.img vbmeta.img system.img system_ext.img product.img vendor.img android-info.txt
