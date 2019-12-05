###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.android-tools
VERSION = 29.0.5

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://developer.android.com/studio/releases/platform-tools

clean:
	rm -rf stage

download: clean
	mkdir -p stage	
	curl -o stage/android.zip https://dl.google.com/android/repository/platform-tools_r29.0.5-darwin.zip

extract:
	unzip stage/android.zip -d stage

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/android --root stage/platform-tools stage/AndroidTools.pkg

install:
	open stage/AndroidTools.pkg

uninstall:
	sudo rm -rf /usr/local/android
	sudo rm -rf /etc/paths.d/android
	sudo pkgutil --forget $(IDENTIFIER)
