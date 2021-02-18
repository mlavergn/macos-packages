###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.pcre
VERSION = 8.44
PKGNAME = pcre

#
# build package
#
all: clean download extract build prepare package

home:
	open http://www.pcre.org

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -L -J -o stage/${PKGNAME}.tar.gz https://ftp.pcre.org/pub/pcre/pcre-8.44.zip

extract:
	tar xJvf stage/${PKGNAME}.tar.gz -C stage

build:
	cd stage/pcre-${VERSION}; ./configure; make

prepare:
	rm -rf stage/pcre
	mkdir -p stage/pcre/lib
	cp -R stage/pcre-${VERSION}/.libs/* stage/pcre/lib
	mkdir -p stage/pcre/include
	cp -R stage/pcre-${VERSION}/pcre*.h stage/pcre/include
	cp scripts/uninstall.sh stage/pcre

package: prepare
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --install-location /usr/local/pcre --root stage/pcre stage/${PKGNAME}.pkg

install:
	open stage/${PKGNAME}.pkg

uninstall:
	sudo scripts/uninstall.sh
	sudo pkgutil --forget ${IDENTIFIER}
