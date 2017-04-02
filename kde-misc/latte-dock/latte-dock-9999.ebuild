# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Latte is a dock (plasma applet) that provides an elegant experience for your tasks."
HOMEPAGE="https://store.kde.org/p/1169519/
https://github.com/psifidotos/Latte-Dock"

if [[ ${PV} = 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/psifidotos/Latte-Dock.git"
	KEYWORDS="**"
	BUILD_DIR="${WORKDIR}/${P}/build"
else
	SRC_URI="https://codeload.github.com/psifidotos/${PN}/tar.gz/v${PV} -> ${P}.tar.gz "
	KEYWORDS="~amd64 ~x86"
	"${S}"="${WORKDIR}/Latte-Dock-0.6"
	BUILD_DIR="${WORKDIR}/Latte-Dock-${PV}/build"
fi

LICENSE="GPL-2+"
SLOT="5"

RDEPEND=">=dev-qt/qtcore-5.6.0
		>=dev-qt/qtgui-5.6.0
		>=dev-qt/qtdbus-5.6.0
		>=kde-frameworks/plasma-5.26
		>=kde-frameworks/kpackage-5.26
		>=kde-frameworks/kwayland-5.26
		>=kde-frameworks/kactivities-5.26
		>=kde-frameworks/kxmlgui-5.26
		>=kde-frameworks/ki18n-5.26
		>=kde-frameworks/karchive-5.26
		>=kde-frameworks/knotifications-5.26
		>=kde-frameworks/kdeclarative-5.26
		>=kde-frameworks/kdbusaddons-5.26
		>=kde-frameworks/kwindowsystem-5.26
		x11-libs/libxcb"

DEPEND="${RDEPEND}
		dev-util/cmake"


