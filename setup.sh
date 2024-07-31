#!/bin/bash

scriptpath="$(pwd)"/setup.sh

echo "Heyo!"
read -p "Where do you want to build? 
1. Current user home directory(~/)
2. Root directory(/)
" HOMEROOTCOOKDIR

case $HOMEROOTCOOKDIR in

    1) cd ~;;
    2) cd /;;
    *) 
	echo "Invalid response! exiting..."
	exit 1
	;;

esac

read -p "How would you like to name your work directory?
" NAMECOOKDIR
mkdir $NAMECOOKDIR
cd $NAMECOOKDIR

echo "Lemme just install git-repo for ya"
mkdir -p ~/.bin
PATH="${HOME}/.bin:${PATH}"
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/.bin/repo
chmod a+rx ~/.bin/repo

echo "Now time to init your ROM manifest"
read -p "Manifest link: " manifest
read -p "Branch: " branch
repo init --depth=1 -u $repoinit -b $branch
echo "Done initing manifest"
echo "Time to sync it!"
read -p "How much jobs to use while syncing? " jobs
repo sync -c -j$jobs --force-sync --no-clone-bundle --no-tags -v
echo "Synced! make sure it went without any problems"

echo "Now lets clone device sources!"
read -p "Device brand:" brand
read -p "Device codename:" device

read -p "Device tree link: " dtrepo
read -p "Device tree branch: " drbranch
git clone -b $dtbranch $dtrepo device/"$brand"/"$device"

read -p "Does your device tree have vendorsetup.sh?(y/n)" havevendorsetup
case $havevendorsetup in
    Yy)

	read -p "Kernel source link: " kernelrepo
	read -p "Kernel source branch: " kernelbranch
	git clone -b $kernelbranch $kernelrepo kernel/"$brand"/"$codename"
	echo "Kernel source clonned!"

	read -p "Vendor link: " vendorrepo
	read -p "Vendor branch: " vendorbranch
	git clone -b $vendorbranch $vendorrepo vendor/"$brand"/"$codename"
	echo "Done!"
	;;

    Nn)
	echo "ok, proceeding with envsetup!"
	. build/envsetup.sh
	;;

esac

echo "Done clonning device sources!"

read -p "Would you like to build right now? (y/n)" likebuild
case $likebuild in
    Yy)
	wget https://raw.githubusercontent.com/r0ddty/easy-android-script/main/build.sh
	bash build.sh
        ;;

    Nn)   
        echo "Ok, exiting!"
	echo "Enjoy!"
	exit 1
        ;;

esac

read -p "Remove the script? (y/n)" removescript
case $removescript in
    Yy)
	rm scriptpath
        ;;

    Nn)
        echo "Ok, exiting!"
        exit 1
        ;;

esac
