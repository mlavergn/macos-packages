###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.android

VERSION = 3.6.2
TOOLSVER = 6200805

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

all: extract package pkgsign
	echo "done"

download:
	mkdir -p stage
	curl -o stage/android_sdk.zip https://dl.google.com/android/repository/commandlinetools-mac-${TOOLSVER}_latest.zip

extract:
	mkdir -p stage/sdk
	unzip stage/android_sdk.zip -d stage/sdk
	chmod 755 stage/sdk/tools
	sdkmanager --sdk_root=stage/sdk "tools"
	sdkmanager --sdk_root=stage/sdk "platform-tools"
	sdkmanager --sdk_root=stage/sdk "platforms;android-28"
	sdkmanager --sdk_root=stage/sdk "build-tools;28.0.3"

package:
	sed 's/{IDENTIFIER}/${IDENTIFIER}/' scripts/uninstall.sh > stage/sdk/uninstall.sh; chmod 755 stage/sdk/uninstall.sh
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
	/usr/local/android/sdk/uninstall.sh
