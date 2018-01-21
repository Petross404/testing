# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils kde5-functions

DESCRIPTION="QML port of qtermwidget"
HOMEPAGE="https://github.com/Swordfish90/qmltermwidget"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Swordfish90/qmltermwidget.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/Swordfish90/${PN}/archive/v${PV}tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
IUSE="doc"
SLOT="5"

RDEPEND="
	$(add_qt_dep qtcore)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
"
DEPEND="${RDEPEND}"

DOCS=( README.md AUTHORS )

src_configure(){
	eqmake5
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
