#!/bin/bash
$user=whoami
clear
echo "        				Lineag OS 17.1 BUILD SCRIPT"
echo
echo "   				     i95swervin"
echo "  			        i95.swerve@gmail.com"
echo
echo
echo "Welcome,"; whoami; echo "Would you like to build clean or rebuild? c/r "; 
echo "your choices are: c - clean build | r - rebuild"
echo "" Enter c or r
read fsu
	if [ $fsu = "c" ]
	then
		#ubuntu 
echo CheckInstall required packages...
sudo apt install bc bison build-essential ccache curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5-dev libsdl1.2-dev libssl-dev libwxgtk3.0-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev libncurses5 git repo openjdk-8-jdk adb fastboot
#arch linux best xD
#echo installing aosp-devel
#yay aosp-devel
echo DONE...

#fetch platform-tools
#echo grabbing latest platform-tools...
#wget -c https://dl.google.com/android/repository/platform-tools-latest-linux.zip -O platform-tools-latest-linux.zip
#unzip platform-tools-latest-linux.zip -d ~
#sleep 2
#rm platform-tools-latest-linux.zip

#git config --global user.email
#git config --global user.name

cd ~/Desktop
rm -rf "los_build-$(date +"%m-%d-%Y")"
mkdir "los_build-$(date +"%m-%d-%Y")"

cd ~/
echo Creating build directory...
mkdir los

echo Grabbing repo...
mkdir -p ~/bin
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+x ~/bin/repo

cd ~/los
echo Cleaning shit first...
rm -rf frameworks/base
rm -rf packages/apps/Settings
rm -rf packages/apps/SettingsIntelligence
rm -rf packages/apps/ThemePicker
rm -rf vendor/extra
rm -rf device/google/bonito
rm -rf device/google/bonito-kernel
rm -rf device/google/sargo
rm -rf device/google/bonito-sepolicy
rm -rf hardware/qcom/sdm710
rm -rf kernel/google
rm -rf vendor/google
rm -rf vendor/gapps

repo init -u git://github.com/LineageOS/android.git -b lineage-17.1
echo LOS is now syncing, go fuck off xD
repo sync --current-branch --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune -j16

#remove bloat
rm -rf packages/apps/Jelly
rm -rf packages/apps/Camera2

echo Cloning extra repos now...
git clone https://github.com/stevn4127/Bonito -b lineage device/google/bonito
git clone https://github.com/BlissRoms-Devices/proprietary_android_vendor_google vendor/google
git clone https://github.com/BlissRoms-Devices/android_kernel_google_b4s4 -b q kernel/google/b4s4
git clone https://gitlab.com/stebomurkn420/gapps -b los vendor/gapps

echo Setting some shit...
cd ~/los
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_EXEC=/usr/bin/ccache
export TEMPORARY_DISABLE_PATH_RESTRICTIONS=true
source ~/.bashrc

#bonito 
#. build/envsetup.sh
#lunch bliss_bonito-userdebug
#make blissify |& tee /tmp/build.log

cd ~/los
#make device clean

. build/envsetup.sh
lunch lineage_sargo-user
echo Build Started!!
mka bacon |& tee /tmp/build.log

echo grabbing files!
cd ~/los/out/target/product/sargo
find . \( -name "lineage*.zip" -o -name "lineage*.md5" -o -name "Changelog*.txt" \) -exec cp -t "/home/i95swervin/Desktop/los_rebuild-$(date +"%m-%d-%Y")" {} +
cp boot.img dtbo.img "/home/i95swervin/Desktop/los_rebuild-$(date +"%m-%d-%Y")"
cp /tmp/build.log "/home/i95swervin/Desktop/los_rebuild-$(date +"%m-%d-%Y")" 
	else
		echo		
		echo "Rebuild is starting...?"
		cd ~/Desktop
mkdir "los_rebuild-$(date +"%m-%d-%Y")"

echo Setting some shit...
cd ~/los
export TEMPORARY_DISABLE_PATH_RESTRICTIONS=true
export USE_CCACHE=1
export CCACHE_COMPRESS=1
export CCACHE_EXEC=/usr/bin/ccache
source ~/.bashrc

#bonito 
#. build/envsetup.sh
#lunch bliss_bonito-userdebug
#make blissify |& tee /tmp/build.log

cd ~/bliss
#make device clean

. build/envsetup.sh
lunch lineage_sargo-user
echo Build Started!!
mka bacon |& tee /tmp/build.log

echo grabbing files!
cd ~/los/out/target/product/sargo
find . \( -name "lineage*.zip" -o -name "lineage*.md5" -o -name "Changelog*.txt" \) -exec cp -t "/home/i95swervin/Desktop/los_rebuild-$(date +"%m-%d-%Y")" {} +
cp boot.img dtbo.img "/home/i95swervin/Desktop/los_rebuild-$(date +"%m-%d-%Y")"
cp /tmp/build.log "/home/i95swervin/Desktop/los_rebuild-$(date +"%m-%d-%Y")" 
		exit 0;
	fi
echo