#!/bin/bash

read -p "Tell me your device codename: " S_DEVICE

read -p "Now tell me your ROM number
1. RisingOS
2. BlissROMs
3. LineageOS(-based)
4. AOSP(-based)
" ROM_NUMBER

case $ROM_NUMBER in
    1)
        # RisingOS
        read -p "What build type do you want to do?
1. user
2. userdebug
3. eng
" BUILD_TYPE

        case $BUILD_TYPE in
            1) S_BUILD_TYPE="user";;
            2) S_BUILD_TYPE="userdebug";;
            3) S_BUILD_TYPE="eng";;
        esac

        . build/envsetup.sh
        riseup lineage_"$S_DEVICE"-"$S_BUILD_TYPE"
        rise b
        ;;

    2)
        # BlissROMs
        read -p "What build type do you want?
1. Vanilla
2. GAPPS 
3. FOSS
4. MicroG
" BLISS_BUILD_TYPE

        case $BLISS_BUILD_TYPE in
            1) S_BLISS_BUILD_TYPE="v";;
            2) S_BLISS_BUILD_TYPE="g";;
            3) S_BLISS_BUILD_TYPE="f";;
            4) S_BLISS_BUILD_TYPE="m";;
        esac

        . build/envsetup.sh
        blissify -"$S_BLISS_BUILD_TYPE" "$S_DEVICE"
        ;;

    3)
        # LineageOS
        read -p "What build type do you want to do?
1. user
2. userdebug
3. eng
" BUILD_TYPE

        case $BUILD_TYPE in
            1) S_BUILD_TYPE="user";;
            2) S_BUILD_TYPE="userdebug";;
            3) S_BUILD_TYPE="eng";;
        esac

        . build/envsetup.sh
        lunch lineage_"$S_DEVICE"-"$S_BUILD_TYPE"
        mka bacon
        ;;

    4)
        # AOSP
        read -p "What build type do you want to do?
1. user
2. userdebug
3. eng
" BUILD_TYPE

        case $BUILD_TYPE in
            1) S_BUILD_TYPE="user";;
            2) S_BUILD_TYPE="userdebug";;
            3) S_BUILD_TYPE="eng";;
        esac

        . build/envsetup.sh
        lunch aosp_"$S_DEVICE"-"$S_BUILD_TYPE"
        mka bacon
        ;;

    *)
        echo "Invalid ROM number"
        exit 1
        ;;
esac
