###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.dart2
VERSION = 2.1.0

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://www.dartlang.org/install/archive

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/dartsdk.zip https://storage.googleapis.com/dart-archive/channels/stable/release/${VERSION}/sdk/dartsdk-macos-x64-release.zip

extract:
	unzip stage/dartsdk.zip -d stage
	chmod +rxrxrx stage/dart-sdk
	chmod +rxrxrx stage/dart-sdk/bin

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/dart --root stage/dart-sdk stage/Dart2.pkg

install:
	open stage/Dart2.pkg

uninstall:
	sudo rm -rf /usr/local/dart
	sudo rm -rf /etc/paths.d/dart
	sudo pkgutil --forget $(IDENTIFIER)

# not currently used

# analyze:
# 	rm -f stage/Dart2.plist
# 	pkgbuild --analyze --root stage/dart-sdk stage/Dart2.plist

# plist:
# 	/usr/libexec/PlistBuddy -c "Add :CFBundleDocumentTypes:BundleHasStrictIdentifier bool YES" stage/Dart2.plist 
# 	plutil -replace BundleIsRelocatable -bool NO stage/Dart2.plist
# 	plutil -replace RootRelativeBundlePath -string 'stage/dart-sdk' stage/Dart2.plist
# 	plutil -replace RootRelativeBundlePath -string 'dart-sdk' stage/Dart2.plist
# 	plutil -replace BundlePostInstallScriptPath -string 'sudo echo "/usr/local/dart/bin" >> /etc/paths.d/dart' stage/Dart2.plist

# sign:
# 	productsign --sign "Developer ID Installer: ${DEVELOPER}" "stage/Dart2.pkg" "stage/Dart2-signed.pkg"
# 	productBuild --synthesize --package stage/Dart2.pkg ./Distribution.xml
# 	productBuild --distribution ./Distribution.xml --resources ./Resources --sign "Developer ID Installer: ${DEVELOPER}" --package-path . stage/Dart2.pkg
