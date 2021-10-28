# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="GPIO handling in C++"
HOMEPAGE="https://github.com/perimeno/LIO"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/perimeno/LIO.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/perimeno/LIO/archive/refs/tags/release-${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

IUSE="examples"
LICENSE=""
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eapply_user

	if use !examples; then
		sed -i -e '/add_subdirectory(example)/d' CMakeLists.txt || die "Sed failed!".
	fi

	cmake_src_prepare
}
