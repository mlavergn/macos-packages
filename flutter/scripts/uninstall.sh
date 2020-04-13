#!/bin/bash

sudo rm /etc/paths.d/flutter
sudo rm -r /usr/local/flutter
sudo pkgutil --forget {IDENTIFIER}
