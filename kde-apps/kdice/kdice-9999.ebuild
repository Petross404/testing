# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="KDice is a free game to roll the dice with Qt/KF5"
HOMEPAGE="https://github.com/Petross404/KDice"
EGIT_REPO_URI="https://github.com/Petross404/KDice.git"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS=""
IUSE="sound"

RDEPEND="
"

DEPEND="
"

src_configure() {
	local mycmakeargs=(
		-DENABLE_SOUND=$(usex sound)
	)
	cmake-utils_src_configure
}
