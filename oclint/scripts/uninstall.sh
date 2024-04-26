#!/bin/bash

sudo rm /etc/paths.d/oclint
sudo rm -rf /usr/local/oclint
sudo pkgutil --forget {replace}
