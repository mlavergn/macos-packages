###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.openocd
VERSION = 0.10.0

#
# build package
#
all: download extract package

home:
	open https://github.com/gnu-mcu-eclipse/openocd/releases

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/openocd.tgz -J -L https://github.com/gnu-mcu-eclipse/openocd/releases/download/v0.10.0-12-20190422/gnu-mcu-eclipse-openocd-0.10.0-12-20190422-2015-macos.tgz

extract:
	cd stage; tar -xvf openocd.tgz
	mkdir stage/openocd
	mv stage/gnu-mcu-eclipse/openocd/0.10.0-12-20190422-2015/bin stage/openocd
	chmod 755 stage/openocd/bin/*

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/openocd --root stage/openocd stage/openocd.pkg

install:
	open stage/openocd.pkg

uninstall:
	sudo rm -f /usr/local/bin/openocd
	sudo pkgutil --forget $(IDENTIFIER)
