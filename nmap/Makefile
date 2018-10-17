###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.nmap
VERSION = 7.70

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://nmap.org

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/nmap.bz2 https://nmap.org/dist/nmap-7.70.tar.bz2

extract:
	bunzip2 stage/nmap.bz2 | tar xvf -
	@(cd stage/nmap-$(VERSION); \
	./configure; \
	make)
	mkdir stage/bin
	mv stage/nmap-$(VERSION)/nmap stage/bin
	chmod +rxrxrx stage/bin/*

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --install-location /usr/local/bin --root stage/bin stage/nmap.pkg

install:
	open stage/nmap.pkg

uninstall:
	sudo rm -f /usr/local/bin/nmap
	sudo pkgutil --forget $(IDENTIFIER)
