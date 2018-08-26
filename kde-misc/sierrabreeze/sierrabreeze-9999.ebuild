# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils kde5-functions

DESCRIPTION="Fork of Breeze Window decoration that mimics the OSX titlebar buttons"
HOMEPAGE="https://github.com/ishovkun/SierraBreeze"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ishovkun/SierraBreeze.git"
fi

LICENSE="GPL-3"
IUSE="doc test"
SLOT="5"

RDEPEND="
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kguiaddons)
	$(add_frameworks_dep kconfigwidgets)
	$(add_plasma_dep kdecoration)
	$(add_qt_dep qtcore)
	$(add_qt_dep qtdeclarative)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qt11extras)
"
DEPEND="
	${RDEPEND}
	$(add_frameworks_dep extra-cmake-modules)
"

src_configure() {
	local mycmakeargs=(
		#I am unsure of the next argument :
		-DKDE_INSTALL_LIBDIR=lib
		-DBUILD_TESTING=$(usex test)
		-DKDE_INSTALL_USE_QT_SYS_PATHS=ON
	)
	cmake-utils_src_configure
}
