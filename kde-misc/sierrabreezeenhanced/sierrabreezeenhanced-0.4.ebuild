# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="A fork of BreezeEnhanced to make it (arguably) more minimalistic and informative"
HOMEPAGE="https://github.com/kupiqu/SierraBreezeEnhanced"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kupiqu/SierraBreezeEnhanced.git"
else
	SRC_URI="https://github.com/kupiqu/SierraBreezeEnhanced/archive/V${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
IUSE=""
SLOT="5"

DOCS=( "README.md" )
S="${WORKDIR}/SierraBreezeEnhanced-0.4"

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
	dev-qt/qtgui[xcb]
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
		-DKDE_INSTALL_USE_QT_SYS_PATHS=ON
	)
	cmake-utils_src_configure
}
