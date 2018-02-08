#!/bin/sh
. /etc/farmconfig


if [ "$OSTYPE" = "debian" ]; then
	apt-get update
else
	echo "repository refresh before upgrade not implemented on $OSTYPE system"
fi
