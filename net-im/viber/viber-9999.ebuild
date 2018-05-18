# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils unpacker
DESCRIPTION="Free calls, text and picture sharing with anyone, anywhere!"
HOMEPAGE="http://www.viber.com"
SRC_URI="http://download.cdn.viber.com/cdn/desktop/Linux/viber.deb"

SLOT="0"
KEYWORDS=""
IUSE=""
RESTRICT="strip"
S="${WORKDIR}"

#TODO: ???
LICENSE="EULA"

src_prepare() {
    unpack_deb ${A}
    eapply_user
}

src_install(){
	doins -r opt usr
	fperms 755 /opt/viber/Viber
	fperms 755 /opt/viber/QtWebEngineProcess
}
