# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils kde5-functions

DESCRIPTION="This effect rounds the corners of your windows when you have no Borders in Plasma"
HOMEPAGE="https://github.com/alex47/KDE-Rounded-Corners"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/alex47/KDE-Rounded-Corners.git"
fi

LICENSE="GPL-3"
IUSE=""
SLOT="5"

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
	dev-qt/qtx11extras
"
DEPEND="
	${RDEPEND}
	kde-frameworks/extra-cmake-modules
"

src_configure() {
	local mycmakeargs=(
		-DQT5BUILD=ON
	)
	cmake-utils_src_configure
}
