###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.unar
VERSION = 4.1.0

#
# build package
#
all: download extract package

home:
	open https://theunarchiver.com/command-line

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/unar.zip -J -L https://cdn.theunarchiver.com/downloads/unarMac.zip

extract:
	unzip stage/unar.zip -d stage
	mkdir stage/bin
	mv stage/lsar stage/bin
	mv stage/unar stage/bin
	chmod 755 stage/bin/*

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --install-location /usr/local/bin --root stage/bin stage/unar.pkg

install:
	open stage/unar.pkg

uninstall:
	sudo rm -f /usr/local/bin/lsar /usr/local/bin/unar
	sudo pkgutil --forget $(IDENTIFIER)
