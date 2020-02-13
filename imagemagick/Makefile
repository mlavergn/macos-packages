###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.imagemagick
VERSION = 19.2.0
PRODUCT = imagemagick

DEVID ?= A1B2C3D4E5
APPID := "Developer ID Installer: : Marc Lavergne (${DEVID})"

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
	rm -r stage/local/lib/pkgconfig

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --install-location /usr/local --root stage/local stage/${PRODUCT}.pkg

install:
	open stage/${PRODUCT}.pkg

uninstall:
	sudo pkgutil --files ${IDENTIFIER} | xargs -I F rm -f /usr/local/local/"F"
	sudo pkgutil --forget $(IDENTIFIER)

#
# enhanced Package
#

icon:
	curl -o stage/background.ico https://www.imagemagick.org/download/images/ImageMagick.ico
	sips -s format png -s formatOptions 80 --resampleHeightWidthMax 180 -o stage/background.png stage/background.ico
	# sips --padToHeightWidth 418 620 background.png
	sips --padToHeightWidth 580 180 stage/background.png

edit:
	productbuild --synthesize --package stage/${PRODUCT}.pkg Distribution.xml

product: icon
	productbuild --distribution Distribution.xml --resources stage --package-path stage stage/${PRODUCT}.pkg

sign:
	pkgbuild --identifier $(IDENTIFIER) --sign ${DEVID} --root stage/local stage/${PRODUCT}.pkg
