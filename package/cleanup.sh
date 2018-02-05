#!/bin/bash
. /opt/farm/scripts/init


if [ -x /etc/local/hooks/pre-upgrade.sh ]; then
	/etc/local/hooks/pre-upgrade.sh --cleanup
fi

if [ "$OSTYPE" = "debian" ]; then
	apt-get autoremove && apt-get autoremove
else
	echo "cleanup after upgrade not implemented on $OSTYPE system"
fi

if [ -x /etc/local/hooks/post-upgrade.sh ]; then
	/etc/local/hooks/post-upgrade.sh --cleanup
fi
