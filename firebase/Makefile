###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.firebase
VERSION = 8.1.1

PKGNAME = Firebase

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract package # pkgsign notarize

home:
	open https://github.com/firebase/firebase-tools/releases/

download: clean
	mkdir -p stage/firebase/bin
	curl -o stage/firebase/bin/firebase -J -L https://firebase.tools/bin/macos/v${VERSION}

extract:
	chmod 755 stage/firebase/bin/*

package:
	sed 's/{IDENTIFIER}/${IDENTIFIER}/' scripts/uninstall.sh > stage/firebase/bin/uninstall.sh; chmod 755 stage/firebase/bin/uninstall.sh
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/firebase --root stage/firebase stage/${PKGNAME}-${VERSION}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/${PKGNAME}-${VERSION}.pkg stage/${PKGNAME}-${VERSION}-signed.pkg
	mv stage/${PKGNAME}-${VERSION}-signed.pkg stage/${PKGNAME}-${VERSION}.pkg

notarize:
	  xcrun altool --notarize-app --type osx --primary-bundle-id ${IDENTIFIER} --username "${USERNAME}" --password "@keychain:ADP" --file stage/${PKGNAME}-${VERSION}.pkg

staple:
	  xcrun stapler staple stage/${PKGNAME}-${VERSION}.pkg

release:
		hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
		open "https://github.com/mlavergn/macos-packages/releases"

clean:
	rm -rf stage

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	/usr/local/firebase/bin/uninstall.sh
