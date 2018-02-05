#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.install


if [ "$1" = "" ]; then
	echo "usage: $0 <package>"
	exit
fi

package=$1

if [ "$OSTYPE" = "debian" ]; then
	install_deb $package
elif [ "$OSTYPE" = "redhat" ]; then
	install_rpm $package
elif [ "$OSTYPE" = "suse" ]; then
	install_suse $package
elif [ "$OSTYPE" = "netbsd" ]; then
	install_pkgin $package
elif [ "$OSTYPE" = "freebsd" ]; then
	install_pkg $package
fi
