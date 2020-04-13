###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.dart
VERSION = 2.7.2

PKGNAME = Dart

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://www.dartlang.org/install/archive

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/dartsdk.zip https://storage.googleapis.com/dart-archive/channels/stable/release/${VERSION}/sdk/dartsdk-macos-x64-release.zip

extract:
	unzip stage/dartsdk.zip -d stage
	chmod +rxrxrx stage/dart-sdk
	chmod +rxrxrx stage/dart-sdk/bin

codesign:
	codesign -f -o runtime --timestamp --sign "Developer ID Application: ${DEVNAME} (${DEVID})" stage/dart-sdk/bin/*

package:
	sed 's/{IDENTIFIER}/${IDENTIFIER}/' scripts/uninstall.sh > stage/dart-sdk/uninstall.sh
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/dart --root stage/dart-sdk stage/${PKGNAME}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/${PKGNAME}.pkg stage/${PKGNAME}-signed.pkg
	mv ${PKGNAME}-${VERSION}-signed.pkg ${PKGNAME}-${VERSION}.pkg

notarize:
	xcrun altool --notarize-app --type osx --primary-bundle-id ${IDENTIFIER} --username "${USERNAME}" --password "@keychain:ADP" --file stage/${PKGNAME}-${VERSION}.pkg

dist: download extract codesign package pkgsign notarize
	echo "dist done"

staple:
	xcrun stapler staple stage/${PKGNAME}-${VERSION}.pkg

release: staple
	hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	/usr/local/dart/uninstall.sh
