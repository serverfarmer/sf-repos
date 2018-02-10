#!/bin/sh
. /etc/farmconfig


if [ "$OSTYPE" = "debian" ]; then
	apt-get update
elif [ "$OSTYPE" = "qnap" ]; then
	ipkg update
else
	echo "repository refresh before upgrade not implemented on $OSTYPE system"
fi
