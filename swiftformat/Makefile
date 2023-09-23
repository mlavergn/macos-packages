###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.swiftformat
VERSION := 0.52.4

PKGNAME = SwiftFormat

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg

home:
	open https://github.com/nicklockwood/SwiftFormat

clean:
	rm -rf stage

download: clean
	mkdir -p stage/swiftformat
	curl -o stage/swiftformat.zip -L https://github.com/nicklockwood/SwiftFormat/releases/download/${VERSION}/swiftformat.zip

extract:
	unzip stage/swiftformat.zip -d stage/swiftformat

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/swiftformat/uninstall.sh; chmod 755 stage/swiftformat/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/swiftformat --root stage/swiftformat stage/${PKGNAME}-${VERSION}.pkg

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
	/usr/local/swiftformat/uninstall.sh
