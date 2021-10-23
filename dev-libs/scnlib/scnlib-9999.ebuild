# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

CMAKE_ECLASS=cmake
inherit cmake-multilib

DESCRIPTION="Modern C++ library for replacing scanf and std::istream."
HOMEPAGE="https://scnlib.readthedocs.io/en/latest/"

LICENSE="Apache License 2.0"
IUSE="doc examples test"
SLOT="0/$(ver_cut 1)"

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/eliaskosunen/scnlib.git"
	inherit git-r3
else
	SRC_URI="https://github.com/eliaskosunen/scnlib/archive/v${PV}.tar.gz-> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
	#S="${WORKDIR}/fmt-${PV}"
fi

DEPEND=" doc? ( app-doc/doxygen )"
RDEPEND=""
RESTRICT="!test? ( test )"

multilib_src_configure() {
	local mycmakeargs=(
		#-DFMT_CMAKE_DIR="$(get_libdir)/cmake/fmt"
		#-DFMT_LIB_DIR="$(get_libdir)"
		-DSCN_TESTS=$(usex test)
		-DSCN_DOCS=$(usex doc)
		-DSCN_EXAMPLES=$(usex examples)
		-DSCN_USE_RTTI=ON
	)
	cmake_src_configure
}
