###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.kotlin
VERSION = 1.3.61

#
# build package
#
all: download extract package

home:
	open https://github.com/JetBrains/kotlin

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -L -o stage/kotlin.zip https://github.com/JetBrains/kotlin/releases/download/v1.3.61/kotlin-compiler-1.3.61.zip

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
