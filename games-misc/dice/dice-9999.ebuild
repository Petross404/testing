# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib flag-o-matic

DESCRIPTION=""
HOMEPAGE="https://github.com/Petross404/dice_"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Petross404/${PN}_.git"
	KEYWORDS=""
fi

LICENSE="GPL-3"
IUSE=""
SLOT="0"

#src_configure(){
#	append-ldflags -Wl,-eabout
#	cmake-utils_src_configure
#}
