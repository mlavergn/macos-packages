#!/bin/bash

sudo rm /etc/paths.d/oclint
sudo rm -r /usr/local/oclint
sudo pkgutil --forget {replace}
