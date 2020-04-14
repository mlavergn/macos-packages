###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.android

VERSION = 29.0.3

PKGNAME = Android

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

#
# build package
#

home:
	open "https://developer.android.com/studio"

clean:
	rm -rf stage

# Downloading https://dl.google.com/android/repository/3534162-studio.sdk-patcher.zip
# Downloading https://dl.google.com/android/repository/build-tools_r29.0.3-macosx.zip
# Downloading https://dl.google.com/android/repository/emulator-darwin-6306047.zip
# Downloading https://dl.google.com/android/repository/extras/intel/haxm-macosx_v7_5_1.zip
# Downloading https://dl.google.com/android/repository/platform-29_r04.zip
# Downloading https://dl.google.com/android/repository/platform-tools_r29.0.6-darwin.zip
# Downloading https://dl.google.com/android/repository/sources-29_r01.zip

download:
	mkdir -p stage
	curl -o stage/android_src.zip https://dl.google.com/android/repository/sources-29_r01.zip
	curl -o stage/android_platform.zip https://dl.google.com/android/repository/platform-29_r04.zip
	curl -o stage/android_tools.zip https://dl.google.com/android/repository/build-tools_r29.0.3-macosx.zip
	curl -o stage/android_platform_tools.zip https://dl.google.com/android/repository/platform-tools_r29.0.6-darwin.zip

extract:
	mkdir -p stage/sdk
	unzip stage/android_platform_tools.zip -d stage/sdk
	chmod 755 stage/sdk/platform-tools

	mkdir -p stage/sdk/build-tools
	unzip stage/android_tools.zip -d stage/sdk/build-tools
	mv stage/sdk/build-tools/android-10 stage/sdk/build-tools/29.0.3
	chmod 755 stage/sdk/build-tools/29.0.3

	mkdir -p stage/sdk/platforms
	unzip stage/android_platform.zip -d stage/sdk/platforms
	mv stage/sdk/platforms/android-10 stage/sdk/platforms/android-29
	chmod 755 stage/sdk/platforms/android-29

	mkdir -p stage/sdk/sources
	unzip stage/android_src.zip -d stage/sdk/sources
	mv stage/sdk/sources/src stage/sdk/sources/android-29
	chmod 755 stage/sdk/sources/android-29

package:
	sed 's/{IDENTIFIER}/${IDENTIFIER}/' scripts/uninstall.sh > stage/sdk/uninstall.sh; chmod +x stage/sdk/uninstall.sh
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/android/sdk --root stage/sdk stage/${PKGNAME}-${VERSION}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/${PKGNAME}-${VERSION}.pkg stage/${PKGNAME}-${VERSION}-signed.pkg
	mv stage/${PKGNAME}-${VERSION}-signed.pkg stage/${PKGNAME}-${VERSION}.pkg

# notarize:
# 	xcrun altool --notarize-app --type osx --primary-bundle-id ${IDENTIFIER} --username "${USERNAME}" --password "@keychain:ADP" --file stage/${PKGNAME}-${VERSION}.pkg

# staple:
# 	xcrun stapler staple stage/${PKGNAME}-${VERSION}.pkg

release:
	hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	/usr/local/android/uninstall.sh
