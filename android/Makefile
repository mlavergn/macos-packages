###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.android

VERSION = 28
BLDTOOLSVER = 28.0.3
TOOLSVER = 6200805

PKGNAME = Android

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME ?= ""

.DEFAULT_GOAL := all

#
# build package
#

home:
	open "https://developer.android.com/studio"

clean:
	rm -rf stage

all: download extract package pkgsign
	echo "done"

download:
	mkdir -p stage
	curl -o stage/android.zip https://dl.google.com/android/repository/commandlinetools-mac-${TOOLSVER}_latest.zip

SDKMANAGER_OPTS="--add-modules java.se.ee"
extract:
	mkdir -p stage/android
	unzip stage/android.zip -d stage/android
	chmod 755 stage/android/tools
	stage/android/tools/bin/sdkmanager --channel=1 --sdk_root=stage/android "emulator"
	stage/android/tools/bin/sdkmanager --channel=1 --sdk_root=stage/android "platforms;android-${VERSION}"
	stage/android/tools/bin/sdkmanager --channel=1 --sdk_root=stage/android "platform-tools"
	stage/android/tools/bin/sdkmanager --channel=1 --sdk_root=stage/android "build-tools;${BLDTOOLSVER}"
	stage/android/tools/bin/sdkmanager --channel=1 --sdk_root=stage/android "system-images;android-${VERSION};google_apis_playstore;x86_64"
	stage/android/tools/bin/sdkmanager --channel=1 --sdk_root=stage/android "extras;intel;Hardware_Accelerated_Execution_Manager"
	stage/android/tools/bin/sdkmanager sdkmanager --sdk_root=stage/android --licenses

# patch the sdkmanager
patch:
	sed -i '' 's/APP_ARGS=$$(save "/APP_ARGS=$$(save --sdk_root=\/usr\/local\/android "/' stage/android/tools/bin/sdkmanager

scripts:
	cp scripts/androidcfg.sh stage/android/tools/bin; chmod 755 stage/android/tools/bin/androidcfg.sh
	sed 's/{VERSION}/${VERSION}/g' scripts/androidsim.sh > stage/android/tools/bin/androidsim.sh; chmod 755 stage/android/tools/bin/androidsim.sh
	sed 's/{VERSION}/${VERSION}/g' scripts/makeandroidsimapp.sh > stage/android/tools/bin/makeandroidsimapp.sh; chmod 755 stage/android/tools/bin/makeandroidsimapp.sh
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/android/tools/bin/uninstall.sh; chmod 755 stage/android/tools/bin/uninstall.sh

package: patch scripts
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/android --root stage/android stage/${PKGNAME}-${VERSION}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/${PKGNAME}-${VERSION}.pkg stage/${PKGNAME}-${VERSION}-signed.pkg
	mv stage/${PKGNAME}-${VERSION}-signed.pkg stage/${PKGNAME}-${VERSION}.pkg

# notarize:
# 	xcrun altool --notarize-app --type osx --primary-bundle-id ${IDENTIFIER} --username "${USERNAME}" --password "@keychain:ADP" --file stage/${PKGNAME}-${VERSION}.pkg

# staple:
# 	xcrun stapler staple stage/${PKGNAME}-${VERSION}.pkg

release:
	hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	/usr/local/android/tools/bin/uninstall.sh

#
# Simlator
#

avdlist:
	avdmanager list

avd:
	avdmanager create avd --force -d pixel_xl -n PixelXL --abi google_apis_playstore/x86_64 -k 'system-images;android-${VERSION};google_apis_playstore;x86_64'

sim:
	emulator -sysdir /usr/local/android/system-images/android-${VERSION}/google_apis_playstore/x86_64 -avd PixelXL -skin 1440x2560
