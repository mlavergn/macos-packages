#!/bin/bash

sudo rm -f /usr/local/bin/sonar-scanner
sudo rm -rf /usr/local/sonar
sudo pkgutil --forget {replace}
