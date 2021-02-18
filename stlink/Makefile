###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.stlink
VERSION = 1.3.0

#
# build package
#
all: download extract package

home:
	open https://github.com/texane/stlink

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -L -o stage/stlink.zip https://github.com/texane/stlink/releases/download/${VERSION}/stlink-${VERSION}-macosx-amd64.zip

extract:
	unzip stage/stlink.zip -d stage
	mv stage/stlink-${VERSION}-macosx-amd64/* stage
	mv stage/usr/local/share stage
	rm stage/stlink.zip
	rmdir stage/usr/local stage/usr stage/stlink-${VERSION}-macosx-amd64
	chmod 755 stage/bin/*

package:
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --install-location /usr/local --root stage stage/stlink.pkg

install:
	open stage/stlink.pkg

uninstall:
	sudo rm -f /usr/local/bin/st-flash /usr/local/bin/st-info /usr/local/bin/st-util
	sudo rm -rf /usr/local/lib/include/stlink*
	sudo rm -f /usr/local/lib/libstlink
	sudo rm -f /usr/local/share/man/man1/st-*.1
	sudo pkgutil --forget ${IDENTIFIER}
