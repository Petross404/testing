# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="A fork of BreezeEnhanced to make it (arguably) more minimalistic and informative"
HOMEPAGE="https://github.com/kupiqu/SierraBreezeEnhanced"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kupiqu/SierraBreezeEnhanced.git"
fi

KEYWORDS="~amd64"
LICENSE="GPL-3"
IUSE="doc test"
SLOT="5"

DOCS=( "README.md" )

RDEPEND="
	kde-frameworks/kwidgetsaddons
	kde-frameworks/kcoreaddons
	kde-frameworks/kconfig
	kde-frameworks/kwindowsystem
	kde-frameworks/ki18n
	kde-frameworks/kguiaddons
	kde-frameworks/kconfigwidgets
	kde-plasma/kdecoration
	dev-qt/qtcore
	dev-qt/qtdeclarative
	dev-qt/qtdbus
	dev-qt/qtgui
	dev-qt/qtnetwork
	dev-qt/qtwidgets
	x11-libs/libxcb
"
DEPEND="
	${RDEPEND}
	kde-frameworks/extra-cmake-modules
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=$(usex test)
		-DKDE_INSTALL_USE_QT_SYS_PATHS=ON
	)
	cmake-utils_src_configure
}
