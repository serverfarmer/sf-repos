#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install


if [ "$1" = "" ]; then
	echo "usage: $0 <list>"
	exit
fi

lists=/opt/farm/ext/repos/lists/$OSVER
list=$1


if [ -f $lists/$list ]; then
	for p in `cat $lists/$list`; do
		if [ "$OSTYPE" = "debian" ]; then
			install_deb $p
		elif [ "$OSTYPE" = "redhat" ]; then
			install_rpm $p
		elif [ "$OSTYPE" = "suse" ]; then
			install_suse $p
		elif [ "$OSTYPE" = "netbsd" ]; then
			install_pkgin $p
		elif [ "$OSTYPE" = "freebsd" ]; then
			install_pkg $p
		fi
	done
fi

if [ -f $lists/$list.purge ]; then
	for p in `cat $lists/$list.purge`; do
		if [ "$OSTYPE" = "debian" ]; then
			uninstall_deb $p
		elif [ "$OSTYPE" = "redhat" ] || [ "$OSTYPE" = "suse" ]; then
			uninstall_rpm $p
		elif [ "$OSTYPE" = "netbsd" ]; then
			uninstall_pkgin $p
		elif [ "$OSTYPE" = "freebsd" ]; then
			uninstall_pkg $p
		fi
	done
fi

if [ -f $lists/$list.cpan ]; then
	for p in `cat $lists/$list.cpan`; do
		install_cpan $p
	done
fi
