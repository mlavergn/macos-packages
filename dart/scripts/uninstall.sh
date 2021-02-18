#!/bin/bash

sudo rm /etc/paths.d/dart
sudo rm -r /usr/local/dart
sudo pkgutil --forget {replace}
