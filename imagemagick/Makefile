###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.imagemagick
VERSION = 19.2.0

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://imagemagick.org/

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/imagemagick.tar.gz https://imagemagick.org/download/binaries/ImageMagick-x86_64-apple-darwin${VERSION}.tar.gz

extract:
	tar xzvf stage/imagemagick.tar.gz -C stage
	mkdir stage/local
	mv stage/ImageMagick-*/bin stage/local
	mv stage/ImageMagick-*/lib stage/local
	rm stage/local/lib/pkgconfig

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --install-location /usr/local --root stage/local stage/imagemagick.pkg

install:
	open stage/imagemagick.pkg

uninstall:
	sudo pkgutil --files ${IDENTIFIER} | xargs -I F rm -f /usr/local/local/"F"
	sudo pkgutil --forget $(IDENTIFIER)
