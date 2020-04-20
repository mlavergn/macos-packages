# Flutter package builder

## Current Version

The script is configured to build the Flutter 1.12.13 with the beta channel enabled.

The version can be changed by updating the following make variables:

- VERSION = 1.12.13
- HOTFIX = +hotfix.9

Versions can obtained from the [FLutter](https://flutter.dev/docs/development/tools/sdk/releases?tab=macos) site (or: make home)

NOTE: Flutter 1.12 requires Android SDK >= 28

## Important

There is a missing feature in the Android SDK whereby it is not possible to repoint sdkmanager to a new
Android home environmentally, the "fix" is either to apply the following patch to sdkmanager:

```text
diff android/tools/bin/sdkmanager
@@ -1,162 +1,162 @@
- APP_ARGS=$(save "$@")
+ APP_ARGS=$(save --sdk_root=/usr/local/android "$@")
```

or to install Android using this repos Android package builder

## Usage

NOTE: If Flutter install is intended to build Android apps, ensure the Android SDK is installed prior
to building the Flutter package.

```bash
# one-step
make all
make install

# step-wise
make download
make extract
make package
make pkgsign
make install

# configure the SDK post-installation
fluttercfg.sh

# uninstall
/usr/local/flutter/bin/uninstall.sh
```
