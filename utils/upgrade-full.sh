#!/bin/sh
. /etc/farmconfig


if [ -x /etc/local/hooks/pre-upgrade.sh ]; then
	/etc/local/hooks/pre-upgrade.sh --full
fi

if [ "$OSTYPE" = "debian" ]; then
	apt-get dist-upgrade
elif [ "$OSTYPE" = "redhat" ]; then
	yum upgrade
elif [ "$OSTYPE" = "suse" ]; then
	aptitude dist-upgrade
elif [ "$OSTYPE" = "netbsd" ]; then
	pkgin full-upgrade
elif [ "$OSTYPE" = "freebsd" ]; then
	pkg upgrade
elif [ "$OSTYPE" = "qnap" ]; then
	ipkg upgrade
else
	echo "upgrade not implemented on $OSTYPE system"
fi

if [ -x /etc/local/hooks/post-upgrade.sh ]; then
	/etc/local/hooks/post-upgrade.sh --full
fi
