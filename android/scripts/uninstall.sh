#!/bin/bash

sudo rm /etc/paths.d/android
sudo rm -r /usr/local/android
sudo pkgutil --forget {IDENTIFIER}
