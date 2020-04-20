# Java package builder

NOTE: This script was created for a test, it may not be fully functional

## Current Version

The script is configured to build for Java JRE 1.8.

[Java Home](http://www.oracle.com/technetwork/java/javase/downloads/index.html)

## Usage

```bash
make download
# auto-download does not work for the JRE, the makefile will open a window to download
# the tarball from Oracle
make extract
make package
make pkgsign
make install

# configure the SDK post-installation
fluttercfg.sh
```

https://www.oracle.com/java/technologies/javase-jre8-downloads.html
