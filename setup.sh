#!/bin/bash
. /opt/farm/scripts/init
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.install


base=/opt/farm/ext/repos/templates/$OSVER

if [ -f $base/listchanges.tpl ]; then
	rm -f /etc/apt/listchanges.conf  # remove previous softlink
	cat $base/listchanges.tpl |sed s/%%domain%%/`external_domain`/g >/etc/apt/listchanges.conf
fi

if [ -f $base/sources.list ]; then
	dst="/etc/apt/sources.list"
	oldmd5=`md5sum $dst`

	if [ -h $dst ]; then
		rm -f $dst
	else
		save_original_config $dst
	fi

	install_copy $base/sources.list $dst
	newmd5=`md5sum $dst`

	if [ "$oldmd5" != "$newmd5" ]; then
		apt-get update
	fi
fi

