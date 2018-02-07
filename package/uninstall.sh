#!/bin/sh
. /etc/farmconfig
. /opt/farm/scripts/functions.install


if [ "$1" = "" ]; then
	echo "usage: $0 <package>"
	exit
fi

package=$1

if [ -x /etc/local/hooks/pre-upgrade.sh ]; then
	/etc/local/hooks/pre-upgrade.sh --uninstall
fi

if [ "$OSTYPE" = "debian" ]; then
	uninstall_deb $package
elif [ "$OSTYPE" = "redhat" ] || [ "$OSTYPE" = "suse" ]; then
	uninstall_rpm $package
elif [ "$OSTYPE" = "netbsd" ]; then
	uninstall_pkgin $package
elif [ "$OSTYPE" = "freebsd" ]; then
	uninstall_pkg $package
fi

if [ -x /etc/local/hooks/post-upgrade.sh ]; then
	/etc/local/hooks/post-upgrade.sh --uninstall
fi
