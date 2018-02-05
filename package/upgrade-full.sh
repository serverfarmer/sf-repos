#!/bin/bash
. /opt/farm/scripts/init


if [ -x /etc/local/hooks/pre-upgrade.sh ]; then
	/etc/local/hooks/pre-upgrade.sh --full
fi

if [ "$OSTYPE" = "debian" ]; then
	apt-get dist-upgrade
else
	echo "upgrade not implemented on $OSTYPE system"
fi

if [ -x /etc/local/hooks/post-upgrade.sh ]; then
	/etc/local/hooks/post-upgrade.sh --full
fi
