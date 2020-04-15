###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.jq
VERSION = 1.6

#
# build package
#
all: download extract package

home:
	open https://github.com/stedolan/jq

clean:
	rm -rf stage

download: clean
	mkdir -p stage/bin
	curl -L -o stage/bin/jq https://github.com/stedolan/jq/releases/download/jq-${VERSION}/jq-osx-amd64

extract:
	chmod 755 stage/bin/*

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --install-location /usr/local/bin --root stage/bin stage/jq.pkg

install:
	open stage/jq.pkg

uninstall:
	sudo rm -f /usr/local/bin/jq
	sudo pkgutil --forget $(IDENTIFIER)
