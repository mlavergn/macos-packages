###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.dart
VERSION = 2.8.4

PKGNAME = Dart

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#

all: download extract package pkgsign
	echo "done"

home:
	open https://www.dartlang.org/install/archive

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/dartsdk.zip https://storage.googleapis.com/dart-archive/channels/stable/release/${VERSION}/sdk/dartsdk-macos-x64-release.zip

extract:
	unzip stage/dartsdk.zip -d stage
	chmod 755 stage/dart-sdk
	chmod 755 stage/dart-sdk/bin
	chmod 755 stage/dart-sdk/bin/snapshots

package:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/dart-sdk/uninstall.sh; chmod 755 stage/dart-sdk/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/dart --root stage/dart-sdk stage/${PKGNAME}-${VERSION}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/${PKGNAME}-${VERSION}.pkg stage/${PKGNAME}-${VERSION}-signed.pkg
	mv stage/${PKGNAME}-${VERSION}-signed.pkg stage/${PKGNAME}-${VERSION}.pkg

notarize:
	xcrun altool --notarize-app --type osx --primary-bundle-id ${IDENTIFIER} --username "${USERNAME}" --password "@keychain:ADP" --file stage/${PKGNAME}-${VERSION}.pkg

dist: download extract package pkgsign notarize
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
