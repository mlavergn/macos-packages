###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.ag
VERSION = 2.2.0
PKGNAME = TheSilverSearcher

#
# build package
#
all: download extract build package

home:
	open https://github.com/ggreer/the_silver_searcher

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -L -J -o stage/${PKGNAME}.tar.gz https://github.com/ggreer/the_silver_searcher/archive/${VERSION}.tar.gz

extract:
	tar xJvf stage/${PKGNAME}.tar.gz -C stage

build:
	cd stage/the_silver_searcher-${VERSION}; touch src/config.h; make -f ../../Makefile.mac
	mkdir stage/bin
	cp stage/the_silver_searcher-${VERSION}/ag stage/bin

package:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/ag/uninstall.sh; chmod 755 stage/ag/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --install-location /usr/local/bin --root stage/bin stage/${PKGNAME}.pkg

install:
	open stage/${PKGNAME}.pkg

uninstall:
	sudo ./scripts/uninstall.sh
