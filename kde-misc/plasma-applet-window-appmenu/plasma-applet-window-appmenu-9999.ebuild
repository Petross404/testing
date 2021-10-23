# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="forceoptional"
KFMIN=5.70.0
QTMIN=5.14.1
inherit inherit ecm kde.org

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
	dev-qt/qtwidgets
	kde-frameworks/extra-cmake-modules
	kde-frameworks/kwindowsystem
	kde-frameworks/plasma
	x11-libs/libXrandr
"

RDEPEND="${DEPEND}"
