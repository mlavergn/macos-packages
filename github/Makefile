###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.github
VERSION = 2.14.2

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://github.com/github/hub

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/hub-darwin-amd64.tgz -J -L https://github.com/github/hub/releases/download/v${VERSION}/hub-darwin-amd64-${VERSION}.tgz
 
extract:
	tar xvf stage/hub-darwin-amd64.tgz -C stage
	mkdir stage/hub
	mv stage/hub-darwin-amd64-${VERSION}/* stage/hub
	chmod 755 stage/hub/bin/*

package:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/hub/uninstall.sh; chmod 755 stage/hub/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/hub --root stage/hub stage/github-${VERSION}.pkg

dist: download extract package
	echo "Done"

install:
	open stage/github-${VERSION}.pkg

uninstall:
	-sudo /usr/local/bin/hub/uninstall.sh
