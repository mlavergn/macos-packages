# macOS Packages

## Introduction

A collection of Makefile to generate signed standard macOS packages (.pkg) for applications and developer tools.

This project exists because of a personal preference to avoid auto-installed dependencies by other packaging schemes such as Homebrew and MacPorts. The overarching goal is to prevent bit-rot (orphaned files and binaries). By registering with the package manager and providing an uninstaller, it should be possible to completely remove all traces of the installed software between upgrades and on deletion.

All App Store downloads follow a similar methodology to accounts for all files installed by a particular piece of software.

## Tips

To view a listing of all the currently installed packages on your system issue the following in a terminal window

```bash
pkgutil --packages

# output should be similar to
com.apple.pkg.Xcode
com.apple.pkg.XcodeSystemResources
com.apple.pkg.ConfigurationUtility
com.apple.pkg.TransporterApp
com.marclavergne.GitHub
com.marclavergne.GitLFS
...
```

To view files owned by a package issue the following in a terminal window

```bash
pkgutil --pkg-info com.marclavergne.firebase --files com.marclavergne.firebase

# output should be similar to
package-id: com.marclavergne.firebase
version: 8.1.1
volume: /
location: usr/local/firebase
install-time: 1587566967

bin
bin/firebase
bin/uninstall.sh
...
```

## Usage

All packages current use com.marclavergne.*Package Name* as an identifier. This is easily modified in the Makefile.

Every sub-project has a specific README, but have the following convention

```bash
# build the package
make all

# install the package
open Example.pkg

# uninstall the package
/usr/local/example/bin/uninstall.sh
```

## Current Packagers

- Android SDK (including emulator)
- AWS CLI
- Dart
- ffmpeg
- Firebase CLI
- FLutter SDK
- GitHub CLI
- GitLFS
- Haskell
- ImageMagick
- inetutils (telnet & ftp only)
- Java JRE
- jq
- Kotlin
- Mint
- nmap
- OpenOCD
- Pecker
- Scala
- STLink
- unar

## OEM Packages

- [Go](https://golang.org/dl/)
- [Node/npm](https://nodejs.org/en/)
- [C#](https://download.microsoft.com/download/D/C/F/DCFA73BE-93CE-4DA0-AB76-98972FD6E475/dotnet-sdk-2.1.101-osx-gs-x64.pkg)
