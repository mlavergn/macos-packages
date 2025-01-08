###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.zig
VERSION := 0.14.0-dev
BUILD := ".2627+6a21d18ad"

PKGNAME = zig

USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg
	echo "Done"

home:
	open https://github.com/ziglang/zig

clean:
	rm -rf stage

download: clean
	mkdir -p stage/zig
	curl -o stage/zig.tar.xz -J -L https://ziglang.org/builds/zig-macos-aarch64-${VERSION}${BUILD}.tar.xz

extract:
	cd stage; tar -xvf zig.tar.xz
	mv stage/zig-macos-* stage/zig-${VERSION}

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/zig-${VERSION}/uninstall.sh; chmod 755 stage/zig-${VERSION}/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/zig --root stage/zig-${VERSION} stage/${PKGNAME}-${VERSION}.pkg

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
	/usr/local/zig/uninstall.sh
