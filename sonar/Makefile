###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.sonar
VERSION := 4.5.0.2216

PKGNAME = sonar

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME = "mlavergn@gmail.com"

.DEFAULT_GOAL := all

#
# build package
#
all: download extract package

home:
	open https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/

clean:
	rm -rf stage

download: clean
	mkdir -p stage/sonar
	curl -o stage/sonar.zip -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${VERSION}-macosx.zip

extract:
	unzip stage/sonar.zip -d stage
	mv stage/sonar-scanner-${VERSION}-macosx stage/sonar

pkg:
	sed 's/{IDENTIFIER}/${IDENTIFIER}/' scripts/uninstall.sh > stage/sonar/uninstall.sh; chmod 755 stage/sonar/uninstall.sh
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/sonar --root stage/sonar stage/${PKGNAME}-${VERSION}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/${PKGNAME}-${VERSION}.pkg stage/${PKGNAME}-${VERSION}-signed.pkg

# notarize:
# 	xcrun altool --notarize-app --type osx --primary-bundle-id ${IDENTIFIER} --username "${USERNAME}" --password "@keychain:ADP" --file stage/${PKGNAME}-${VERSION}.pkg

# NZID = 11570ec5-8c8d-4b93-870a-667ff6fc33ce
# status:
# 	xcrun altool --notarization-info "${NZID}" --username ${USERNAME} --password "@keychain:ADP"

# staple:
# 	xcrun stapler staple stage/${PKGNAME}-${VERSION}.pkg

release:
	hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	/usr/local/sonar/uninstall.sh
