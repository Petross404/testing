# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils kde5-functions

DESCRIPTION="Qt4/Qt5 widget style from the author of Bespin"
HOMEPAGE="https://github.com/luebking/virtuality"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/luebking/virtuality.git"
fi

LICENSE="GPL-3"
IUSE="qt5"
SLOT="0"

RDEPEND=""
DEPEND=""

src_configure() {
	local mycmakeargs=(
		-DWITH_QT5=$(usex qt5)
	)
	cmake-utils_src_configure
}
