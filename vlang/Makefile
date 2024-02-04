###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.vlang
VERSION := 0.4.4

PKGNAME = vlang

USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg

home:
	open https://github.com/vlang/v

clean:
	rm -rf stage

download: clean
	mkdir -p stage/vlang
	curl -o stage/vlang.zip -J -L https://github.com/vlang/v/releases/download/${VERSION}/v_macos_arm64.zip
 
extract:
	cd stage; unzip vlang.zip
	mv stage/v stage/vlang-${VERSION}

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/vlang-${VERSION}/uninstall.sh; chmod 755 stage/vlang-${VERSION}/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/vlang --root stage/vlang-${VERSION} stage/${PKGNAME}-${VERSION}.pkg

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
	/usr/local/vlang/uninstall.sh
