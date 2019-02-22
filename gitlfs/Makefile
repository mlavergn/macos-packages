###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.gitlfs
VERSION = 2.7.0

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://git-lfs.github.com

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/git-lfs-darwin-amd64.tar.gz -J -L https://github.com/git-lfs/git-lfs/releases/download/v${VERSION}/git-lfs-darwin-amd64-v${VERSION}.tar.gz

extract:
	tar xvf stage/git-lfs-darwin-amd64.tar.gz -C stage
	mkdir stage/bin
	mv stage/git-lfs stage/bin
	chmod +rxrxrx stage/bin/*

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/bin --root stage/bin stage/gitlfs.pkg

install:
	open stage/gitlfs.pkg

uninstall:
	sudo rm -f /usr/local/bin/git-lfs
	sudo pkgutil --forget $(IDENTIFIER)
