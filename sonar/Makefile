###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.sonar
VERSION := 4.8.0.2856

PKGNAME = sonar

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME = "mlavergn@gmail.com"

.DEFAULT_GOAL := all

#
# build package
#
all: download extract pkg

home:
	open https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/

clean:
	rm -rf stage

download: clean
	mkdir -p stage/sonar
	curl -o stage/sonar.zip -L https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-${VERSION}.zip

extract:
	unzip stage/sonar.zip -d stage
	mkdir -p stage/sonar
	mv stage/sonar-scanner-${VERSION}/* stage/sonar

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/sonar/uninstall.sh; chmod 755 stage/sonar/uninstall.sh stage/sonar
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/sonar --root stage/sonar stage/${PKGNAME}-${VERSION}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/${PKGNAME}-${VERSION}.pkg stage/${PKGNAME}-${VERSION}-signed.pkg

release:
	hub release create -m "${PKGNAME} ${VERSION}" -a stage/${PKGNAME}-${VERSION}.pkg -t master "${PKGNAME}-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"

install:
	open stage/${PKGNAME}-${VERSION}.pkg

uninstall:
	-/usr/local/sonar/uninstall.sh

update: uninstall install
	echo "done"
