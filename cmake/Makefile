###############################################
#
# Makefile
#
###############################################

PKGNAME = cmake
IDENTIFIER := com.marclavergne.${PKGNAME}
VERSION := 3.29.2

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg

home:
	open https://cmake.org/download/

clean:
	rm -rf stage

download: clean
	mkdir -p stage/${PKGNAME}
	curl -o stage/${PKGNAME}.tgz -L https://github.com/Kitware/CMake/releases/download/v${VERSION}/${PKGNAME}-${VERSION}-macos-universal.tar.gz

extract:
	cd stage; tar -xvf ${PKGNAME}.tgz
	mkdir -p stage/${PKGNAME}
	mv stage/${PKGNAME}-${VERSION}-macos-universal/CMake.app/Contents/bin stage/${PKGNAME}
	mv stage/${PKGNAME}-${VERSION}-macos-universal/CMake.app/Contents/doc stage/${PKGNAME}
	mv stage/${PKGNAME}-${VERSION}-macos-universal/CMake.app/Contents/man stage/${PKGNAME}
	mv stage/${PKGNAME}-${VERSION}-macos-universal/CMake.app/Contents/share stage/${PKGNAME}

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/${PKGNAME}/uninstall.sh; chmod 755 stage/${PKGNAME}/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/${PKGNAME} --root stage/${PKGNAME} stage/${PKGNAME}-${VERSION}.pkg

pkgfiles:
	pkgutil --payload-files stage/${PKGNAME}-${VERSION}.pkg

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
	/usr/local/${PKGNAME}/uninstall.sh
