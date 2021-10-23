# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION=" Minimalistic GUI library for OpenGL"
HOMEPAGE="https://github.com/wjakob/nanogui"

if [[ ${PV} == 9999 ]] ; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/wjakob/nanogui.git"
        KEYWORDS=""
else
        SRC_URI="https://github.com/eliasdaler/imgui-sfml/archive/v${PV}.tar.gz -> ${P}.tar.gz"
        KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="examples"

PATCHES=( "${FILESDIR}/remove_stuff.patch" )

RDEPEND="media-libs/glew:0"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs+=(
		-DNANOGUI_BUILD_EXAMPLE=$(usex examples)
		-DNANOGUI_BUILD_SHARED=ON
		-DNANOGUI_BUILD_PYTHON=OFF
	)
	cmake-utils_src_configure
}
