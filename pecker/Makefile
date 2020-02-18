###############################################
#
# Makefile
#
###############################################

VERSION = 0.1.0
PRODUCT = pecker
IDENTIFIER = com.marclavergne.${pecker}

DEVID ?= Q6H2FB9YW2
APPID := "Developer ID Installer: : Marc Lavergne (${DEVID})"

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://github.com/woshiccm/Pecker

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -L -o stage/pecker.tar.gz https://github.com/woshiccm/Pecker/archive/${VERSION}.tar.gz

extract:
	tar -xvf stage/pecker.tar.gz -C stage

build:
	cd stage/Pecker-${VERSION}; make
	mkdir -p stage/bin
	cp stage/Pecker-${VERSION}/.build/x86_64-apple-macosx/release/pecker stage/bin

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --install-location /usr/local/bin --root stage/bin stage/${PRODUCT}.pkg

install:
	open stage/${PRODUCT}.pkg

uninstall:
	sudo pkgutil --files ${IDENTIFIER} | xargs -I F rm -f /usr/local/bin/"F"
	sudo pkgutil --forget $(IDENTIFIER)

sign:
	pkgbuild --identifier $(IDENTIFIER) --sign ${DEVID} --root stage/bin stage/${PRODUCT}.pkg

