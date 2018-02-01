# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 flag-o-matic cmake-utils

DESCRIPTION="An effort to create a time class in C++"
HOMEPAGE="https://github.com/Petross404/Time"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Petross404/Time.git"
else
	SRC_URI=""
	KEYWORDS="~amd64 x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="doc html man qch"

RDEPEND="
	doc?	( app-doc/doxygen[dot] )
"
DEPEND="${RDEPEND}"
#CMAKE_IN_SOURCE_BUILD=ON
#CMAKE_BUILD_TYPE=Release

src_prepare() {
	sed -i 's/\^\[Rr\]elease/Gentoo/g' CMakeLists.txt || die "Sed failed"
	cmake-utils_src_prepare
}

src_configure() {
	test-flags-CXX -std=c++17 > /dev/null || die "${P} needs c++17 capable compiler"
	local mycmakeargs+=(
		-DENABLE_DOCUMENTATION=$(usex doc)
		-DGENERATE_HTML=$(usex html)
		-DGENERATE_QCH=$(usex qch)
		-DGENERATE_MAN=$(usex man)
	)
	cmake-utils_src_configure
}
