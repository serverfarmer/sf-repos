#!/bin/sh
. /etc/farmconfig


if [ -x /etc/local/hooks/pre-upgrade.sh ]; then
	/etc/local/hooks/pre-upgrade.sh
fi

if [ "$OSTYPE" = "debian" ]; then
	apt-get upgrade
elif [ "$OSTYPE" = "redhat" ]; then
	yum update
elif [ "$OSTYPE" = "suse" ]; then
	aptitude upgrade
elif [ "$OSTYPE" = "netbsd" ]; then
	pkgin upgrade
elif [ "$OSTYPE" = "freebsd" ]; then
	pkg upgrade
elif [ "$OSTYPE" = "qnap" ]; then
	ipkg upgrade
else
	echo "upgrade not implemented on $OSTYPE system"
fi

if [ -x /etc/local/hooks/post-upgrade.sh ]; then
	/etc/local/hooks/post-upgrade.sh
fi
