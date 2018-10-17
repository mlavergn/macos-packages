###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.inetutils
VERSION = 1.9.4

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://ftp.gnu.org/gnu/inetutils/

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/inetutils.tgz https://ftp.gnu.org/gnu/inetutils/inetutils-${VERSION}.tar.gz

extract:
	tar xvf stage/inetutils.tgz -C stage
	@(cd stage/inetutils-$(VERSION); \
	./configure --disable-servers; \
	make)
	mkdir stage/bin
	mv stage/inetutils-$(VERSION)/telnet/telnet stage/bin
	mv stage/inetutils-$(VERSION)/ftp/ftp stage/bin
	chmod +rxrxrx stage/bin/*

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/bin --root stage/bin stage/inetutils.pkg

install:
	open stage/inetutils.pkg

uninstall:
	sudo rm -f /usr/local/bin/telnet
	sudo rm -f /usr/local/bin/ftp
	sudo pkgutil --forget $(IDENTIFIER)
