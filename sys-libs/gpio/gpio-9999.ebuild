# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="C++14 GPIO library for embedded systems on Linux"
HOMEPAGE="https://github.com/JoachimSchurig/CppGPIO"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dimitry-ishenko-cpp/gpio.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/dimitry-ishenko-cpp/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE=""
SLOT="0"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	test-flag-CXX -std=c++14 || die "A c++14 capable compiler is required to build ${PN}"
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_CXX_FLAGS=_GLIBCXX_USE_NANOSLEEP
	)
	cmake_src_configure
}
