###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.github
VERSION = 2.8.4

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
	mkdir stage/bin
	mv stage/hub-darwin-amd64-$(VERSION)/bin/hub stage/bin
	chmod +rxrxrx stage/bin/*

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/bin --root stage/bin stage/github.pkg

install:
	open stage/github.pkg

uninstall:
	sudo rm -f /usr/local/bin/hub
	sudo pkgutil --forget $(IDENTIFIER)
