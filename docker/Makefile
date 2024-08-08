###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.docker
VERSION := 27.1.1

PKGNAME = docker

USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg

home:
	open https://download.docker.com/mac/static/stable/aarch64/

clean:
	rm -rf stage

download: clean
	curl -o stage/docker.tgz -J -L https://download.docker.com/mac/static/stable/aarch64/docker-${VERSION}.tgz

extract:
	cd stage; tar -xvf docker.tgz
	mkdir -p stage/docker/bin
	mv stage/docker/docker stage/docker/bin

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
