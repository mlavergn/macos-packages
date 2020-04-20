#!/bin/bash

if [ ! -d "$HOME/.android/avd/PixelXL.ini" ]; then
	avdmanager create avd --force -d pixel_xl -n PixelXL --abi google_apis_playstore/x86_64 -k 'system-images;android-{VERSION};google_apis_playstore;x86_64'
fi

emulator -sysdir /usr/local/android/system-images/android-{VERSION}/google_apis_playstore/x86_64 -avd PixelXL -skin 1440x2560
