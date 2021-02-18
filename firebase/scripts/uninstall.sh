#!/bin/bash

sudo rm /etc/paths.d/firebase
sudo rm -r /usr/local/firebase
sudo pkgutil --forget {replace}
