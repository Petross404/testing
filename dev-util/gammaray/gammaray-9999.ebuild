# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit kde5 git-r3

DESCRIPTION="Poke around in a Qt-application and manipulate the application to some extent"
HOMEPAGE="https://github.com/KDAB/GammaRay"

LICENSE="GPL-2+"
IUSE="+client -doc feedback wayland -3d"
SLOT="0"

EGIT_REPO_URI="https://github.com/KDAB/GammaRay.git"
KEYWORDS=""

RDEPEND="3d? ( $(add_qt_dep qt3d) )
		$(add_qt_dep qtcore)
		$(add_qt_dep qtgui)
		$(add_qt_dep qtnetwork)
		wayland? ( $(add_qt_dep qtwayland) )
		$(add_qt_dep qtwidgets)
		$(add_qt_dep qtxml)
		$(add_frameworks_dep kitemmodels)"

DEPEND="${RDEPEND}"

src_prepare(){
	if ! use wayland; then
		sed -i '/WaylandCompositor/d' CMakeLists.txt || die
	fi

	if ! use 3d; then
		sed -i -e 's/WITH_WIDGET3D TRUE/WITH_WIDGET3D FALSE/' CMakeLists.txt || die
	fi
	cmake-utils_src_prepare
}

src_configure(){
	mycmakeargs+=(
		-DGAMMARAY_BUILD_DOCS=$(usex doc)
		-DGAMMARAY_BUILD_UI=$(usex client)
		-DGAMMARAY_DISABLE_FEEDBACK=$(usex !feedback)
		-DQT_VERSION=Qt5
	)
	cmake-utils_src_configure
}
