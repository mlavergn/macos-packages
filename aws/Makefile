###############################################
#
# Makefile
#
###############################################

IDENTIFIER = com.marclavergne.awscli
VERSION = 1.16.243

#
# build package
#
all: download extract package

home:
	open https://docs.aws.amazon.com/cli/latest/userguide/install-macos.html

clean:
	rm -rf stage

download: clean
	mkdir -p stage
	curl -o stage/awscli.zip -J -L https://s3.amazonaws.com/aws-cli/awscli-bundle.zip

extract:
	unzip stage/awscli.zip -d stage

package:
	pkgbuild --version ${VERSION} --identifier ${IDENTIFIER} --install-location /usr/local/aws --root stage/awscli-bundle stage/awscli.pkg

install:
	open stage/awscli.pkg

uninstall:
	sudo rm -rf /usr/local/aws /usr/local/bin/aws
	sudo pkgutil --forget ${IDENTIFIER}
