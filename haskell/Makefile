###############################################
#
# Makefile
#
###############################################

IDENTIFIER := com.marclavergne.haskell
VERSION := 8.8.3

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://www.haskell.org/platform/mac.html

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/haskell.tar.gz -L https://downloads.haskell.org/ghc/${VERSION}/ghc-${VERSION}-x86_64-apple-darwin.tar.xz
	# curl -o stage/haskell.tar.gz -L "https://github.com/commercialhaskell/stack/releases/download/v${VERSION}/stack-${VERSION}-osx-x86_64.tar.gz"
 
extract:
	tar xJvf stage/haskell.tar.gz -C stage
	cd stage/ghc-${VERSION}; ./configure --prefix=${PWD}/stage/build; make install

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/haskell --root stage/build stage/haskell.pkg

install:
	open stage/haskell.pkg

uninstall:
	sudo rm -rf /etc/paths.d/haskell
	sudo rm -f /usr/local/haskell
	sudo rm -rf /etc/paths.d/haskell
	sudo pkgutil --forget $(IDENTIFIER)
