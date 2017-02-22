# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils cmake-utils gnome2-utils flag-o-matic toolchain-funcs

UNIFIED_PV=21
UNIFIED_P=${PN}_${UNIFIED_PV}_unified
ENGINE_PV=21
ENGINE_P=${PN}_${ENGINE_PV}_sdk

DESCRIPTION="Multiplayer FPS based on the QFusion engine (evolved from Quake 2)"
HOMEPAGE="http://www.warsow.net/"
SRC_URI="https://hangy.warsow.net/"${ENGINE_P}".tar.gz
	https://hangy.warsow.net/${UNIFIED_P}.tar.gz
	mirror://gentoo/warsow.png"
	#mirror://gentoo/${P}-build.patch.gz

# ZLIB: bundled angelscript
LICENSE="GPL-2 ZLIB warsow"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug dedicated irc openal server"

RDEPEND=">=dev-libs/libRocket-1.2.1_p20130110
	media-libs/freetype
	net-misc/curl
	sys-libs/zlib
	!dedicated? (
		media-libs/libpng:0
		media-libs/libsdl
		media-libs/libtheora
		media-libs/libvorbis
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXinerama
		x11-libs/libXrandr
		x11-libs/libXxf86dga
		x11-libs/libXxf86vm
		virtual/jpeg:0
		virtual/opengl
		openal? ( media-libs/openal )
	)"
DEPEND="${RDEPEND}
	app-arch/unzip
	x11-misc/makedepend
	!dedicated? (
		x11-proto/xineramaproto
		x11-proto/xf86dgaproto
		x11-proto/xf86vidmodeproto
	)
	openal? ( virtual/pkgconfig )"

CHECKREQS_DISK_BUILD="1G"
CHECKREQS_DISK_USR="500M"

S=${WORKDIR}/source/source
DATA_S=${WORKDIR}/${PN}_${UNIFIED_PV:0:2}

src_prepare() {
	if [[ $(tc-getCC) =~ clang ]]; then
		einfo "disabling -ffast-math due to clang bug"
		einfo "http://llvm.org/bugs/show_bug.cgi?id=13745"
		append-cflags -fno-fast-math
		append-cxxflags -fno-fast-math
	fi

	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DQFUSION_GAME="Warsow"
        )

	cmake-utils_src_configure
}

src_install() {
	dobin_wrapper() {
		local f

		for f in $@ ; do
			cat <<-EOF > "${T}/${f}" || die
			#!/bin/sh

			basepath="/usr/share/${PN}"

			cd "\${basepath}"

			exec "/usr/libexec/${PN}/${f}" \
				+set fs_basepath \${basepath} \
				+set fs_usehomedir 1 "\$@"
			EOF

			dobin "${T}/${f}"
		done
	}
	insinto /usr/share/${PN}
	doins -r "${DATA_S}"/basewsw

	cd build || die

	exeinto /usr/libexec/${PN}/
	doexe */*.so
	newexe ${PN}.* ${PN}
	newexe wsw_server.* ${PN}-ded
	newexe wswtv_server.* ${PN}-tv
	dobin_wrapper ${PN} ${PN}-ded ${PN}-tv

	local so
	dodir /usr/share/${PN}/libs
	for so in basewsw/*.so libs/*.so ; do
		dosym /usr/libexec/${PN}/${so##*/} \
			/usr/share/${PN}/${so}
	done

	doicon -s 48 "${DISTDIR}"/${PN}.png
	make_desktop_entry ${PN} Warsow
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
