#!/bin/sh
. /etc/farmconfig


install_deb() {
	pkg=$1
	echo "checking for debian package $pkg"
	if [ "`dpkg -l $pkg 2>/dev/null |grep ^ii`" = "" ]; then
		echo "installing package $pkg"
		if [ "$SF_UNATTENDED" != "" ]; then
			apt-get install -y $pkg
		else
			apt-get install $pkg
		fi
	fi
}

install_rpm() {
	pkg=$1
	echo "checking for rpm package $pkg"
	if ! rpm --quiet -q $pkg; then
		echo "installing package $pkg"
		if [ "$SF_UNATTENDED" != "" ]; then
			yum install -y $pkg
		else
			yum install $pkg
		fi
	fi
}

install_suse() {
	pkg=$1
	echo "checking for suse package $pkg"
	if ! rpm --quiet -q $pkg; then
		echo "installing package $pkg"
		if [ "$SF_UNATTENDED" != "" ]; then
			aptitude install -y $pkg
		else
			aptitude install $pkg
		fi
	fi
}

install_pkg() {
	pkg=$1
	echo "checking for freebsd package $pkg"
	if [ "`pkg info |grep ^$pkg-`" = "" ]; then
		echo "installing package $pkg"
		if [ "$SF_UNATTENDED" != "" ]; then
			pkg install -y $pkg
		else
			pkg install $pkg
		fi
	fi
}

install_pkgin() {
	pkg=$1
	echo "checking for netbsd package $pkg"
	if [ "`pkgin list |grep ^$pkg-`" = "" ]; then
		echo "installing package $pkg"
		if [ "$SF_UNATTENDED" != "" ]; then
			pkgin -y install $pkg
		else
			pkgin install $pkg
		fi
	fi
}



if [ "$1" = "" ]; then
	echo "usage: $0 <package>"
	exit
fi

package=$1

if [ "$OSTYPE" = "debian" ]; then
	install_deb $package
elif [ "$OSTYPE" = "redhat" ]; then
	install_rpm $package
elif [ "$OSTYPE" = "suse" ]; then
	install_suse $package
elif [ "$OSTYPE" = "netbsd" ]; then
	install_pkgin $package
elif [ "$OSTYPE" = "freebsd" ]; then
	install_pkg $package
fi
