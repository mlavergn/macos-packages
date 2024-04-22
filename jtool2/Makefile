###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.jtool2
VERSION := 2.2

PKGNAME = jtool2

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg

home:
	open https://newosxbook.com/tools/jtool2.tgz

clean:
	rm -rf stage

download: clean
	mkdir -p stage/jtool2
	curl -o stage/jtool2.tgz -J -L https://newosxbook.com/tools/jtool2.tgz

extract:
	cd stage/jtool2; tar -xvf ../jtool2.tgz
	mv stage/jtool2 stage/jtool2-${VERSION}

codesign:
	codesign -f -o runtime --timestamp --sign "Developer ID Application: ${DEVNAME} (${DEVID})" stage/jtool2-${VERSION}/jtool2

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/jtool2-${VERSION}/uninstall.sh; chmod 755 stage/jtool2-${VERSION}/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/jtool2 --root stage/jtool2-${VERSION} stage/${PKGNAME}-${VERSION}.pkg

# notarize:
# 	xcrun altool --notarize-app --type osx --primary-bundle-id ${IDENTIFIER} --username "${USERNAME}" --password "@keychain:ADP" --file stage/${PKGNAME}-${VERSION}.pkg

# staple:
# 	xcrun stapler staple stage/${PKGNAME}-${VERSION}.pkg

dist: download extract pkg install
	@echo "Completed"

release:
	hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	/usr/local/jtool2/uninstall.sh
