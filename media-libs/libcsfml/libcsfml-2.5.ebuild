# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils eapi7-ver

MY_P="CSFML-${PV}"

DESCRIPTION="C bindings for Simple and Fast Multimedia Library (SFML)"
HOMEPAGE="https://www.sfml-dev.org/ https://github.com/SFML/CSFML"
SRC_URI="https://github.com/SFML/CSFML/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0/$(ver_cut 1-2)"
KEYWORDS="amd64 x86"
IUSE="debug doc examples"

RDEPEND="
	media-libs/flac
	media-libs/freetype:2
	media-libs/libpng:0=
	media-libs/libogg
	>=media-libs/libsfml-${PV}
	media-libs/libvorbis
	media-libs/openal
	sys-libs/zlib
	virtual/jpeg:0
	kernel_linux? ( virtual/libudev:0 )
	virtual/opengl
	!kernel_Winnt? (
		x11-libs/libX11
		x11-libs/libXrandr
		x11-libs/libxcb
		x11-libs/xcb-util-image
	)
"
DEPEND="
	${RDEPEND}
	doc? ( app-doc/doxygen )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	sed -i "s:DESTINATION .*:DESTINATION /usr/share/doc/${PF}:" \
		doc/CMakeLists.txt || die

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=( )

	if use kernel_Winnt; then
		mycmakeargs+=( -DSFML_USE_SYSTEM_DEPS=TRUE )
	fi
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	#insinto /usr/share/cmake/Modules
	#doins cmake/SFMLConfig.cmake.in
	#doins cmake/SFMLConfigDependencies.cmake.in

	if use examples ; then
		docompress -x /usr/share/doc/${PF}/examples
		dodoc -r examples
	fi
}
