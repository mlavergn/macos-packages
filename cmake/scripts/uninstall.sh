#!/bin/bash

sudo rm /etc/paths.d/cmake
sudo rm -rf /usr/local/cmake
sudo pkgutil --forget {replace}
