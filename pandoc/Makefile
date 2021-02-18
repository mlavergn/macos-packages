###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.pandoc
VERSION = 2.9.2.1

PKGNAME = Pandoc

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract package # pkgsign notarize

home:
	open https://pandoc.org/index.html

download: clean
	mkdir -p stage/pandoc
	curl -L -o stage/pandoc.zip https://github.com/jgm/pandoc/releases/download/${VERSION}/pandoc-${VERSION}-macOS.zip

extract:
	unzip stage/pandoc.zip -d stage

package:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/pandoc-${VERSION}/bin/uninstall.sh; chmod 755 stage/pandoc-${VERSION}/bin/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/pandoc --root stage/pandoc-${VERSION} stage/${PKGNAME}-${VERSION}.pkg

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
	/usr/local/pandoc/bin/uninstall.sh
