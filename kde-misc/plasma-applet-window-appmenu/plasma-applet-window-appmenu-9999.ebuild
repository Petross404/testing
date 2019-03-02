# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/psifidotos/applet-window-appmenu.git"
else
	SRC_URI="https://codeload.github.com/psifidotos/plasma-${PN}/tar.gz/v${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Plasma 5 applet in order to show the window appmenu"
HOMEPAGE="https://github.com/psifidotos/applet-window-appmenu"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtdbus
	dev-qt/qtgui
	dev-qt/qtquickcontrols2
	dev-qt/qtwidgets[xcb]
	kde-frameworks/extra-cmake-modules
	kde-frameworks/kwindowsystem
	kde-frameworks/plasma
	x11-libs/libXrandr
"

RDEPEND="${DEPEND}"

DOCS=( CHANGELOG.md README.md )
