# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake-utils

DESCRIPTION="CMakeRC - A Standalone CMake-Based C++ Resource Compiler"
HOMEPAGE="https://github.com/vector-of-bool/cmrc"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/vector-of-bool/cmrc.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/vector-of-bool/cmrc/archive/${PV}.tar.gz -> ${P}.tar.gz"
#	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-cpp/gtkmm:2.4=
	dev-cpp/pangomm:1.4
	dev-libs/json-c:=
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/glew:0=
	media-libs/libpng:0=
	virtual/opengl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_install() {
	insinto /usr/lib64/cmake/${PN}
	newins CMakeRC.cmake CMakeRCConfig.cmake
}
