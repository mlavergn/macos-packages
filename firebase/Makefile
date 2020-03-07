###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.firebase
VERSION = 7.14.0

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://firebase.google.com

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/bin/firebase -J -L https://firebase.tools/bin/macos/latest
 
extract:
	-mkdir stage/bin
	mv stage/firebase stage/bin
	chmod +rxrxrx stage/bin/*

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --install-location /usr/local/bin --root stage/bin stage/firebase.pkg

install:
	open stage/firebase.pkg

uninstall:
	sudo rm -f /usr/local/bin/firebase
	sudo pkgutil --forget $(IDENTIFIER)
