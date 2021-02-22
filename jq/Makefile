###############################################
#
# Makefile
#
###############################################

PKGID := com.marclavergne.jq
PKGNAME := jq
PKGVER := 1.6
PKGFILE := stage/${PKGNAME}-${PKGVER}.pkg

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME = "mlavergn@gmail.com"

#
# build package
#
dist: download extract pkg pkgsign install
	@echo "done"

home:
	open https://github.com/stedolan/jq

clean:
	rm -rf stage

download: clean
	mkdir -p stage/${PKGNAME}
	mkdir -p stage/scripts
	curl -L -o stage/${PKGNAME}/jq https://github.com/stedolan/jq/releases/download/jq-${PKGVER}/jq-osx-amd64

extract:
	chmod 755 stage/${PKGNAME}/${PKGNAME}

pkg:
	sed 's/{pkgid}/${PKGID}/g' scripts/uninstall.sh > stage/${PKGNAME}/uninstall.sh; chmod 755 stage/${PKGNAME}/uninstall.sh
	sed -i '' 's/{pkgname}/${PKGNAME}/g' stage/${PKGNAME}/uninstall.sh
	sed 's/{pkgname}/${PKGNAME}/g' scripts/preflight > stage/scripts/preflight
	sed 's/{pkgname}/${PKGNAME}/g' scripts/postflight > stage/scripts/postflight
	pkgbuild --version ${PKGVER} --identifier ${PKGID} --scripts stage/scripts --install-location /usr/local/${PKGNAME} --root stage/${PKGNAME} ${PKGFILE}

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" ${PKGFILE} ${PKGFILE}.signed
	mv ${PKGFILE}.signed ${PKGFILE}

validate:
	# codesign -dvv build/${APP}
	pkgutil --check-signature ${PKGFILE}

debug:
	sudo installer -pkg ${PKGFILE} -target / -verbose

install:
	open ${PKGFILE}

uninstall:
	sudo /usr/local/${PKGNAME}/uninstall.sh
