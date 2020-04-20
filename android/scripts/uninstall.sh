#!/bin/bash

sudo rm /etc/paths.d/android
sudo rm -r /usr/local/android
sudo rm -rf /Applications/AndroidSim.app
sudo pkgutil --forget {IDENTIFIER}
