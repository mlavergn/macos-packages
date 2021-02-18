###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.ffmpeg
VERSION = 4.2

#
# build package
#
all: download extract package

home:
	open https://evermeet.cx/ffmpeg

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/ffmpeg.zip -J -L https://evermeet.cx/ffmpeg/ffmpeg-${VERSION}.zip

extract:
	unzip stage/ffmpeg.zip -d stage
	mkdir stage/bin
	mv stage/ffmpeg stage/bin
	chmod 755 stage/bin/*

package:
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --install-location /usr/local/bin --root stage/bin stage/ffmpeg.pkg

install:
	open stage/ffmpeg.pkg

uninstall:
	sudo rm -f /usr/local/bin/ffmpeg
	sudo pkgutil --forget ${IDENTIFIER}
