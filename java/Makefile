###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.java
VERSION = 1.8.0_251

PKGNAME = Java

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
# all: download extract codesign package pkgsign install
all: extract package pkgsign install

download:
	mkdir -p stage
	open -a https://download.oracle.com/otn/java/jdk/8u251-b08/3d5a2bb8f8d4428bbe94aed7ec7ae784/jre-8u251-macosx-x64.tar.gz

extract:
	mv ~/Downloads/jre-8u251-macosx-x64.tar stage/java.tar
	tar xvf stage/java.tar -C stage

package:
	sed 's/{IDENTIFIER}/${IDENTIFIER}/' scripts/uninstall.sh > stage/jre${VERSION}.jre/Contents/Home/bin/uninstall.sh; chmod 755 stage/jre${VERSION}.jre/Contents/Home/bin/uninstall.sh
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/java --root stage/jre${VERSION}.jre/Contents/Home stage/${PKGNAME}-${VERSION}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/${PKGNAME}-${VERSION}.pkg stage/${PKGNAME}-${VERSION}-signed.pkg
	mv stage/${PKGNAME}-${VERSION}-signed.pkg stage/${PKGNAME}-${VERSION}.pkg

release: staple
	hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	/usr/local/flutter/uninstall.sh
