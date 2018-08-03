# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils kde5-functions git-r3

DESCRIPTION="Free EDA software to develop printed circuit boards"
HOMEPAGE="https://github.com/LibrePCB/LibrePCB"
EGIT_REPO_URI="https://github.com/LibrePCB/LibrePCB.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	$(add_qt_dep qtcore)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork 'ssl')
	$(add_qt_dep qtopengl)
	$(add_qt_dep qtprintsupport)
	$(add_qt_dep qtsql)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	sys-libs/zlib"

DEPEND="${RDEPEND}"

src_configure(){
	eqmake5 -r PREFIX="/usr"
}

src_install(){
	emake INSTALL_ROOT="${D}" install
}
