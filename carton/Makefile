###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.carton
VERSION = 0.11.1

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://github.com/swiftwasm/carton

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/carton.tgz -J -L https://github.com/swiftwasm/carton/releases/download/${VERSION}/carton-${VERSION}.big_sur.bottle.tar.gz
 
extract:
	tar xvf stage/carton.tgz -C stage

package:
	# pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/carton --root stage/carton/${VERSION} stage/carton.pkg
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --install-location /usr/local/carton --root stage/carton/${VERSION} stage/carton.pkg

install:
	open stage/carton.pkg

uninstall:
	sudo rm -rf /usr/local/carton
	sudo pkgutil --forget ${IDENTIFIER}
