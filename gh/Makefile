###############################################
#
# Makefile
#
###############################################

.DEFAULT_GOAL := all

IDENTIFIER = com.marclavergne.gh
VERSION = 2.14.2

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME = "mlavergn@gmail.com"

#
# build package
#
# all: download extract analyze plist build
all: download extract pkg

home:
	open https://github.com/github/hub

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/gh-cli.tgz -J -L https://github.com/cli/cli/releases/download/v${VERSION}/gh_${VERSION}_macOS_amd64.tar.gz
 
extract:
	tar xvf stage/gh-cli.tgz -C stage
	mkdir stage/gh
	mv stage/gh_${VERSION}_macOS_amd64/* stage/gh
	chmod 755 stage/gh/bin/*

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/gh/uninstall.sh; chmod 755 stage/gh/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local --root stage/gh stage/gh-${VERSION}.pkg

dist: clean download extract pkg install
	echo "Done"

install:
	open stage/gh-${VERSION}.pkg

uninstall:
	-sudo /usr/local/bin/gh/uninstall.sh
