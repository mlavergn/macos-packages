#!/bin/bash

sudo rm /etc/paths.d/java
sudo rm -r /usr/local/java
sudo pkgutil --forget {replace}
