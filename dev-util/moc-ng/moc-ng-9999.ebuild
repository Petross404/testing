# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils flag-o-matic

DESCRIPTION="Replacement for Qt's moc that is using clang libraries"
HOMEPAGE="https://github.com/woboq/moc-ng"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/woboq/${PN}.git"
	KEYWORDS=""
fi

LICENSE=""
SLOT="0"
IUSE=""

PATCHES=( 
	"${FILESDIR}/fixClangHeadersDetection.patch"
	"${FILESDIR}/fixFileCollision.patch" 
)

RDEPEND="
	|| (
		sys-devel/clang:8
		sys-devel/clang:7
		sys-devel/clang:6
	)
"

src_configure(){
	filter-flags "-Wstrict-aliasing"
	append-cxxflags $(test-flags-CXX -Wno-strict-aliasing)
	cmake-utils_src_configure
}
