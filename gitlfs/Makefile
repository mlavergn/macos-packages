###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.gitlfs
VERSION = 3.4.1

DEVNAME = Marc Lavergne
DEVID = Q6H2FB9YW2
USERNAME = "mlavergn@gmail.com"

#
# build package
#
# all: download extract analyze plist build
all: download extract pkg

home:
	open https://git-lfs.github.com

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/git-lfs.zip -J -L https://github.com/git-lfs/git-lfs/releases/download/v${VERSION}/git-lfs-darwin-arm64-v${VERSION}.zip
	
extract:
	mkdir stage/git-lfs
	unzip stage/git-lfs.zip -d stage/git-lfs
	mkdir stage/bin
	mv stage/git-lfs/git-lfs-${VERSION}/git-lfs stage/bin

pkg:
	sed 's/{replace}/${IDENTIFIER}/' scripts/uninstall.sh > stage/git-lfs/uninstall.sh; chmod 755 stage/git-lfs/uninstall.sh
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --scripts scripts --install-location /usr/local/git-lfs --root stage/bin stage/git-lfs-${VERSION}.pkg

pkgsign:
	productsign --sign "Developer ID Installer: ${DEVNAME} (${DEVID})" stage/git-lfs-${VERSION}.pkg stage/git-lfs-${VERSION}-signed.pkg
	mv stage/git-lfs-${VERSION}-signed.pkg stage/git-lfs-${VERSION}.pkg

dist: download extract pkg install
	@echo "Completed"

install:
	open stage/git-lfs-${VERSION}.pkg

uninstall:
	sudo /usr/local/git-lfs/uninstall.sh

# notarize:
# 	xcrun altool --notarize-app --type osx --primary-bundle-id ${IDENTIFIER} --username "${USERNAME}" --password "@keychain:ADP" --file stage/git-lfs-${VERSION}.pkg

# staple:
# 	xcrun stapler staple stage/git-lfs-${VERSION}.pkg

release:
	hub release create -m "git-lfs ${VERSION}" -a stage/git-lfs-${VERSION}.pkg -t master "git-lfs-${VERSION}"
	open "https://github.com/mlavergn/macos-packages/releases"
