#!/bin/bash

# compile a launcher
osacompile -o /Applications/AndroidSim.app -e 'do shell script "/usr/local/android/emulator/emulator -sysdir /usr/local/android/system-images/android-{VERSION}/google_apis_playstore/x86_64 -avd PixelXL -skin 1440x2560"'

# replace the generic launcher icon
WORK=/tmp/android.iconset
mkdir $WORK
curl -o $WORK/icon_512x512@2x.png https://i1.pngguru.com/path/792/29/287/dh6mmmvkbiv1kqo9qdl6k8i80k-6c4c639124bc02226d403ac993d2fbdb.png
sips -z 16 16 $WORK/icon_512x512@2x.png --out $WORK/icon_16x16.png
sips -z 32 32 $WORK/icon_512x512@2x.png --out $WORK/icon_16x16@2x.png
sips -z 32 32 $WORK/icon_512x512@2x.png --out $WORK/icon_32x32.png
sips -z 64 64 $WORK/icon_512x512@2x.png --out $WORK/icon_32x32@2x.png
sips -z 128 128 $WORK/icon_512x512@2x.png --out $WORK/icon_128x128.png
sips -z 256 256 $WORK/icon_512x512@2x.png --out $WORK/icon_128x128@2x.png
sips -z 256 256 $WORK/icon_512x512@2x.png --out $WORK/icon_256x256.png
sips -z 512 512 $WORK/icon_512x512@2x.png --out $WORK/icon_256x256@2x.png
sips -z 512 512 $WORK/icon_512x512@2x.png --out $WORK/icon_512x512.png
iconutil -c icns --output /Applications/AndroidSim.app/Contents/Resources/applet.icns $WORK
rm -r $WORK
