# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils kde5-functions

DESCRIPTION="Configurable and efficient logging framework for C++"
HOMEPAGE="https://github.com/froglogic/tracetool"

LICENSE="GPL-3+"
IUSE="doc"
SLOT="0"
SRC_URI="https://github.com/froglogic/tracetool/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND="$(add_qt_dep qtcore)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	app-arch/bzip2
	dev-db/sqlite
	dev-libs/libpcre
	dev-libs/tinyxml
	doc? ( app-doc/doxygen )
	sys-libs/readline
	sys-libs/zlib
	${RDEPEND}"

src_prepare() {
	if ! use doc; then
		sed -i '62,69 d' CMakeLists.txt || die
		sed -i '/ADD_SUBDIRECTORY(examples/d' CMakeLists.txt || die
	fi
	eapply_user
}
