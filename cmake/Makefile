###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.cmake
VERSION := 3.27.7

PKGNAME = cmake

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
	mkdir -p stage/cmake
	curl -o stage/cmake.tgz -L https://github.com/Kitware/CMake/releases/download/v${VERSION}/cmake-${VERSION}-macos-universal.tar.gz

extract:
	cd stage; tar -xvf cmake.tgz
	mkdir -p stage/cmake
	mv stage/cmake-${VERSION}-macos-universal/CMake.app/Contents/bin stage/cmake
	mv stage/cmake-${VERSION}-macos-universal/CMake.app/Contents/doc stage/cmake
	mv stage/cmake-${VERSION}-macos-universal/CMake.app/Contents/man stage/cmake
	mv stage/cmake-${VERSION}-macos-universal/CMake.app/Contents/share stage/cmake

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/cmake/uninstall.sh; chmod 755 stage/cmake/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/cmake --root stage/cmake stage/${PKGNAME}-${VERSION}.pkg

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
	/usr/local/cmake/uninstall.sh
