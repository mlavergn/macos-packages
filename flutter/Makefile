###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.flutter
VERSION = 1.9.1

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://flutter.dev/docs/development/tools/sdk/releases?tab=macos

clean:
	-rm -rf stage

download: clean
	mkdir -p stage	
	curl -o stage/flutter.zip https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_v1.9.1+hotfix.6-stable.zip

extract:
	unzip stage/flutter.zip -d stage
	# must run flutter once to update the .git folder
	stage/flutter/bin/flutter doctor
	# move the .git folder since pkgbuild ignores it (move it back in scripts/postinstall)
	mv stage/flutter/.git stage/flutter/git
	# adjust permissions
	chmod a+w stage/flutter/version
	chmod -R a+rw stage/flutter/bin/cache
	chmod -R 777 stage/flutter/.pub-cache

package:
	-rm -f stage/Flutter.pkg
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/flutter --root stage/flutter stage/Flutter.pkg

install:
	open stage/Flutter.pkg

uninstall:
	sudo rm -rf /usr/local/flutter
	sudo rm -rf /etc/paths.d/flutter
	sudo pkgutil --forget $(IDENTIFIER)
