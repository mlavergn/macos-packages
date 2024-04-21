#!/bin/bash

sudo rm /etc/paths.d/lld
sudo rm -rf /usr/local/lld
sudo pkgutil --forget {replace}
