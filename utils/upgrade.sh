#!/bin/sh
. /etc/farmconfig


if [ -x /etc/local/hooks/pre-upgrade.sh ]; then
	/etc/local/hooks/pre-upgrade.sh
fi

if [ "$OSTYPE" = "debian" ]; then
	apt-get upgrade
elif [ "$OSTYPE" = "qnap" ]; then
	ipkg upgrade
else
	echo "upgrade not implemented on $OSTYPE system"
fi

if [ -x /etc/local/hooks/post-upgrade.sh ]; then
	/etc/local/hooks/post-upgrade.sh
fi
