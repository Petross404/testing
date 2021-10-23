# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake

DESCRIPTION="A simple C++ library for terminal based user interface."
HOMEPAGE="https://github.com/ArthurSonzogni/FTXUI"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ArthurSonzogni/${PN}.git"
else
    SRC_URI="https://github.com/ArthurSonzogni/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/FTXUI-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
IUSE="doc examples"
SLOT="0"

RDEPEND=""

DEPEND="
	${RDEPEND}
	"

src_prepare() {
	test-flag-CXX -std=c++11 || die "A c++11 capable compiler is required to build ${PN}"
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs+=(
		-DFTXUI_BUILD_DOCS=$(usex doc)
		-DFTXUI_BUILD_EXAMPLES=$(usex examples)
	)
	cmake-utils_src_configure
}
