###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.oclint
VERSION := 22.02

PKGNAME = OCLint

USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg

home:
	open https://github.com/oclint/oclint

clean:
	rm -rf stage

download: clean
	mkdir -p stage/oclint
	curl -o stage/oclint.tgz -J -L https://github.com/oclint/oclint/releases/download/v22.02/oclint-22.02-llvm-13.0.1-arm64-darwin-macos-12.2-xcode-13.2.tar.gz

extract:
	cd stage; tar -xvf oclint.tgz

dequarantine:
	-xattr -d com.apple.quarantine stage/oclint-${VERSION}/oclint/bin/oclint-${VERSION}

pkg: dequarantine
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/oclint-${VERSION}/uninstall.sh; chmod 755 stage/oclint-${VERSION}/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/oclint --root stage/oclint-${VERSION} stage/${PKGNAME}-${VERSION}.pkg

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
	/usr/local/oclint/uninstall.sh
