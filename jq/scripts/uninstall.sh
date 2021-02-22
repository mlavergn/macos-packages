#!/bin/bash

sudo rm -f /usr/local/bin/{pkgname}
sudo rm -rf /usr/local/{pkgname}
sudo pkgutil --forget {pkgid}
