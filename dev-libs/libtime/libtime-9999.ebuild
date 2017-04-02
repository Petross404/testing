# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3 flag-o-matic cmake-utils

DESCRIPTION="An effort to create a time class in C++"
HOMEPAGE="https://github.com/Petross404/Time"
EGIT_REPO_URI="https://github.com/Petross404/Time.git"
KEYWORDS="**"

LICENSE="GPL-2"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}"

src_configure(){
	test-flags-CXX -std=c++17 > /dev/null || die "${P} needs c++17 capable compiler"
	strip-flags
	append-cppflags -e entry_lib
	filter-ldflags 
	#tc-ld-disable-gold
	#append-ldflags -Wl,-e,entry_lib
	cmake-utils_src_configure
}
