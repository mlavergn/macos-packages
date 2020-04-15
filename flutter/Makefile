###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.flutter
VERSION = 1.12.13
HOTFIX = +hotfix.9

PKGNAME = Flutter

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

#
# build package
#
# all: download extract codesign package pkgsign install
all: extract package pkgsign install

android:
	open "https://developer.android.com/studio"

xcode:
	open "https://developer.apple.com/download/more/"

home:
	open https://flutter.dev/docs/development/tools/sdk/releases?tab=macos

clean:
	-rm -r stage

download: clean
	mkdir -p stage
	curl -o stage/flutter.zip https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v${VERSION}${HOTFIX}-stable.zip

doctor:
	ANDROID_HOME=/usr/local/android/sdk flutter doctor -v

extract:
	unzip stage/flutter.zip -d stage
	# must run flutter once to update the .git folder
	ANDROID_HOME=/usr/local/android/sdk stage/flutter/bin/flutter doctor
	ANDROID_HOME=/usr/local/android/sdk stage/flutter/bin/flutter doctor --android-licenses
    # move the .git folder since pkgbuild ignores it (move it back in scripts/postinstall)
	mv stage/flutter/.git stage/flutter/git
	# adjust permissions
	chmod a+w stage/flutter/version
	chmod -R a+rw stage/flutter/bin/cache
	chmod -R 777 stage/flutter/.pub-cache

codesign:
	codesign -f -o runtime --timestamp --sign "Developer ID Application: ${DEVNAME} (${DEVID})" stage/flutter/bin/cache/dart-sdk/bin/dart

package:
	sed 's/{IDENTIFIER}/${IDENTIFIER}/' scripts/uninstall.sh > stage/flutter/uninstall.sh; chmod 755 stage/flutter/uninstall.sh
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/flutter --root stage/flutter stage/${PKGNAME}-${VERSION}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/${PKGNAME}-${VERSION}.pkg stage/${PKGNAME}-${VERSION}-signed.pkg
	mv stage/${PKGNAME}-${VERSION}-signed.pkg stage/${PKGNAME}-${VERSION}.pkg

notarize:
	xcrun altool --notarize-app --type osx --primary-bundle-id ${IDENTIFIER} --username "${USERNAME}" --password "@keychain:ADP" --file stage/${PKGNAME}-${VERSION}.pkg

staple:
	xcrun stapler staple stage/${PKGNAME}-${VERSION}.pkg

release: staple
	hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	/usr/local/flutter/uninstall.sh
