###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.lld
VERSION := 17.0.2

PKGNAME = lld

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg

home:
	open https://lld.llvm.org

clean:
	rm -rf stage

download: clean
	mkdir -p stage/llvmorg
	curl -v -o stage/llvmorg.tgz -L https://github.com//llvm/llvm-project/tar.gz/refs/tags/llvmorg-${VERSION}.tar.gz

extract:
	cd stage; tar -xvf llvmorg.tgz
	mv stage/llvm-project-llvmorg-17.0.2 stage/llvmorg
	mkdir -p stage/llvmorg/build

build:
	cd stage/llvmorg/build; cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS=lld -DCMAKE_INSTALL_PREFIX=../../lld ../llvm
	cd stage/llvmorg/build; make install

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/lld/uninstall.sh; chmod 755 stage/lld/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/lld --root stage/lld stage/${PKGNAME}-${VERSION}.pkg

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
	/usr/local/lld/uninstall.sh
