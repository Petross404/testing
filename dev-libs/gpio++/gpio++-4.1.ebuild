# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="C++ GPIO Library for Linux"
HOMEPAGE="https://github.com/dimitry-ishenko-cpp/gpio"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/dimitry-ishenko-cpp/gpio.git"
else
	SRC_URI="https://github.com/dimitry-ishenko-cpp/gpio/releases/download/v${PV}/gpio++-${PV}-Source.tar.bz2"
	S="${WORKDIR}/gpio++-${PV}-Source"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND="
	dev-cpp/asio
"

DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_PIGPIO=OFF
	)
	cmake-utils_src_configure
}
