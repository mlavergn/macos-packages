###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.kotlin
VERSION = 1.2.30

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://github.com/JetBrains/kotlin/releases

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -L -o stage/kotlin.zip https://github.com/JetBrains/kotlin/releases/download/v1.2.30/kotlin-compiler-1.2.30.zip

extract:
	unzip stage/kotlin.zip -d stage
	chmod +rxrxrx stage/kotlinc
	chmod +rxrxrx stage/kotlinc/bin

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/kotlin --root stage/kotlinc stage/Kotlin.pkg

install:
	open stage/Kotlin.pkg

uninstall:
	sudo rm -rf /usr/local/kotlin
	sudo rm -rf /etc/paths.d/kotlin
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
