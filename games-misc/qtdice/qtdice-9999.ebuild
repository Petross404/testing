# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils kde5-functions

DESCRIPTION="Qt5 game that rolls the dice"
HOMEPAGE="https://github.com/Petross404/QtDice"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Petross404/QtDice.git"
else
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="+sound"

RDEPEND="
		$(add_qt_dep qtcore)
		$(add_qt_dep qtwidgets)
		sound? ( $(add_qt_dep qtmultimedia) )
"

DEPEND="
		${RDEPEND}
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_SOUND=$(usex sound)
	)
	cmake-utils_src_configure
}
