###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.apktool
VERSION := 2.4.1

PKGNAME = Apktool

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME = "mlavergn@gmail.com"

.DEFAULT_GOAL := all

#
# build package
#
all: download extract package

home:
	open https://ibotpeaches.github.io/Apktool/

clean:
	rm -rf stage

download: clean
	mkdir -p stage/apktool
	curl -o stage/apktool/apktool -L https://raw.githubusercontent.com/iBotPeaches/Apktool/master/scripts/osx/apktool
	curl -o stage/apktool/apktool.jar -L https://bitbucket.org/iBotPeaches/apktool/downloads/apktool_${VERSION}.jar
	chmod +xxx stage/apktool/apktool

pkg:
	sed 's/{IDENTIFIER}/${IDENTIFIER}/' scripts/uninstall.sh > stage/apktool/uninstall.sh; chmod 755 stage/apktool/uninstall.sh
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/apktool --root stage/apktool stage/${PKGNAME}-${VERSION}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/${PKGNAME}-${VERSION}.pkg stage/${PKGNAME}-${VERSION}-signed.pkg
	mv stage/${PKGNAME}-${VERSION}-signed.pkg stage/${PKGNAME}-${VERSION}.pkg

notarize:
	xcrun altool --notarize-app --type osx --primary-bundle-id ${IDENTIFIER} --username "${USERNAME}" --password "@keychain:ADP" --file stage/${PKGNAME}-${VERSION}.pkg

NZID = 3ac85cba-d706-4103-846b-294184df24a5
status:
	xcrun altool --notarization-info "${NZID}" --username ${USERNAME} --password "@keychain:ADP"

staple:
	xcrun stapler staple stage/${PKGNAME}-${VERSION}.pkg

release:
	hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	/usr/local/swiftlint/uninstall.sh
