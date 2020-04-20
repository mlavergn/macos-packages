# Android package

## Current Version

The script is configured to build the Android API 28 SDK.

The version can be changed by updating the following make variables:

- VERSION = 28
- BLDTOOLSVER = 28.0.3
- TOOLSVER = 6200805

The versions have to be obtained from the [Android Studio](https://developer.android.com/studio) site (or make home)

## Patches

Android SDK 28 has a bug (lower case) in the sdkmanager whereby the there is no environment based way
to repoint the sdkmanager to a different Android SDK home. We patch the sdkmanager to have a baked in --sdk_root
parameter on every invocation to work around this.

This doesn't entirely meet the bug bar, rather it's more akin to a missing feature. If the issue persists, it may be
worth filing an enhancement request:

```text
diff android/tools/bin/sdkmanager
@@ -1,162 +1,162 @@
- APP_ARGS=$(save "$@")
+ APP_ARGS=$(save --sdk_root=/usr/local/android "$@")
```

## Usage

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
androidcfg.sh

# launch the simulator
androidsim.sh

# (optional) create an Android simulator launcher app for the dock
makeandroidsimapp.sh

# uninstall
/usr/local/android/tools/bin/uninstall.sh
```
