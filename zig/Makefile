###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.zig
VERSION := 0.11.0

PKGNAME = zig

USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg

https://ziglang.org/builds/zig-macos-aarch64-${VERSION}.tar.xz

home:
	open https://github.com/ziglang/zig

clean:
	rm -rf stage

download: clean
	mkdir -p stage/zig
	curl -o stage/zig.tar.xz -J -L https://ziglang.org/builds/zig-macos-aarch64-${VERSION}.tar.xz

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

release:
	hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	/usr/local/zig/uninstall.sh
