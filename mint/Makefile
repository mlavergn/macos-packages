###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.mint
VERSION = 0.11.3

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://github.com/yonaskolb/Mint

clean:
	rm -rf stage

download: clean
	mkdir -p stage/mint
	curl -o stage/mint.zip -J -L https://github.com/yonaskolb/Mint/releases/download/${VERSION}/mint.zip

extract:
	unzip stage/mint.zip -d stage/bin
	chmod 755 stage/bin/mint

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --install-location /usr/local/bin --root stage/bin stage/Mint.pkg

install:
	open stage/Mint.pkg

uninstall:
	sudo rm -f /usr/local/bin/mint
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
