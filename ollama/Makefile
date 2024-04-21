###############################################
#
# Makefile
#
###############################################

PKGNAME = ollama
IDENTIFIER := com.marclavergne.${ollama}
VERSION := 0.1.32

USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg

home:
	open https://github.com/ollama/ollama

clean:
	rm -rf stage

download: clean
	mkdir -p stage/${PKGNAME}
	curl -o stage/${PKGNAME}/ollama -J -L https://github.com/ollama/ollama/releases/download/v${VERSION}/ollama-darwin

extract:
# 	cd stage; tar -xvf ollama.tar.xz
# 	mv stage/ollama-macos-* stage/ollama-${VERSION}
	chmod +x stage/ollama

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/${PKGNAME}/uninstall.sh; chmod 755 stage/${PKGNAME}/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/${PKGNAME} --root stage/${PKGNAME} stage/${PKGNAME}-${VERSION}.pkg

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
	/usr/local/${PKGNAME}/uninstall.sh
