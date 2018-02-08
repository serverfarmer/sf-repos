#!/bin/sh
. /etc/farmconfig


uninstall_deb() {
	pkg=$1
	if [ "`dpkg -l $pkg 2>/dev/null |egrep \"^(ii|rc)\"`" != "" ]; then
		echo "uninstalling package $pkg"
		if [ "$SF_UNATTENDED" != "" ]; then
			apt-get purge -y $pkg
		else
			apt-get purge $pkg
		fi
	fi
}

uninstall_rpm() {
	pkg=$1
	if rpm --quiet -q $pkg; then
		echo "uninstalling package $pkg"
		rpm -e $pkg
	fi
}

uninstall_pkg() {
	pkg=$1
	if [ "`pkg info |grep ^$pkg-`" != "" ]; then
		echo "uninstalling package $pkg"
		if [ "$SF_UNATTENDED" != "" ]; then
			pkg delete -y $pkg
		else
			pkg delete $pkg
		fi
	fi
}

uninstall_pkgin() {
	pkg=$1
	if [ "`pkgin list |grep ^$pkg-`" != "" ]; then
		echo "uninstalling package $pkg"
		if [ "$SF_UNATTENDED" != "" ]; then
			pkgin -y remove $pkg
		else
			pkgin remove $pkg
		fi
	fi
}


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
