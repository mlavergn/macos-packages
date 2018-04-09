###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.scala
VERSION = 1.1.1

#
# build package
#
# all: download extract analyze plist build
all: download extract package

home:
	open https://www.scala-sbt.org/download.html

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -L -o stage/scala.zip https://github.com/sbt/sbt/releases/download/v1.1.1/sbt-1.1.1.zip

extract:
	unzip stage/scala.zip -d stage

package:
	pkgbuild --version $(VERSION) --identifier $(IDENTIFIER) --scripts scripts --install-location /usr/local/sbt --root stage/sbt stage/Scala.pkg

install:
	open stage/Scala.pkg

uninstall:
	sudo rm -rf /usr/local/sbt
	sudo rm -rf /etc/paths.d/sbt
	sudo pkgutil --forget $(IDENTIFIER)
