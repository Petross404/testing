# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Configurable and efficient logging framework for C++"
HOMEPAGE="https://github.com/froglogic/tracetool"

LICENSE="GPL-3+"
IUSE="doc"
SLOT="0"
SRC_URI="https://github.com/froglogic/tracetool/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

RDEPEND=""
DEPEND=">=dev-util/cmake-3
	>=dev-qt/qtcore-5.6.0
	>=dev-qt/qtgui-5.6.0
	>=dev-qt/qtwidgets-5.6.0
	>=dev-qt/qtnetwork-5.6.0
	doc? ( app-doc/doxygen )
	dev-libs/libpcre
	dev-libs/tinyxml
	dev-db/sqlite
	sys-libs/readline
	sys-libs/zlib
	app-arch/bzip2
	${RDEPEND}"

src_prepare(){
	if ! use doc; then
		sed -i '62,69 d' CMakeLists.txt || die
	fi

	eapply_user
}
