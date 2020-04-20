#!/bin/bash

if [ ! -d "/usr/local/android" ]; then
	echo "/usr/local/android not found, please install the Android SDK "
else
	flutter config --android-sdk /usr/local/android
	flutter doctor
fi
