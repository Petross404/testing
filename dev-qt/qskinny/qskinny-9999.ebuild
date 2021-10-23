# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils

DESCRIPTION="Framework built on top of the Qt scene graph and very few core classes from Qt/Quick"
HOMEPAGE="https://github.com/uwerat/qskinny"

if [[ "${PV}" == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/uwerat/qskinny.git"

else
	SRC_URI=""
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="QSkinny License"
SLOT="0"
IUSE=""

src_configure() {
	eqmake5 -r PREFIX="/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
