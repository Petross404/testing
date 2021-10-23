# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Static analyzer for C/C++ based on the theory of Abstract Interpretation"
HOMEPAGE="https://github.com/NASA-SW-VnV/ikos"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/NASA-SW-VnV/${PN}.git"
else
	SRC_URI="https://github.com/KDAB/${PN}/releases/download/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
IUSE="static-libs"
SLOT="0"

PATCHES=(
	"${FILESDIR}/handle-gentoo-case.patch"
)

RDEPEND=""

DEPEND=""

src_configure() {
	local mycmakeargs+=(
		-DCMAKE_BUILD_TYPE=Release
	)
	cmake-utils_src_configure
}
