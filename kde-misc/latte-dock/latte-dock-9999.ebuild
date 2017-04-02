# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Elegant dock, based on KDE Frameworks"
HOMEPAGE="https://store.kde.org/p/1169519/
https://github.com/psifidotos/Latte-Dock"

if [[ ${PV} = 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/psifidotos/Latte-Dock.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/psifidotos/Latte-Dock/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/Latte-Dock-${PV}"
fi

LICENSE="GPL-2+"
SLOT="0"

BUILD_DIR="${S}/build"

RDEPEND=">=dev-qt/qtcore-5.6.0 
	>=dev-qt/qtdbus-5.6.0 
	>=dev-qt/qtdeclarative-5.6.0 
	>=dev-qt/qtgui-5.6.0 
	>=dev-qt/qtwidgets-5.6.0 
	>=dev-qt/qtx11extras-5.6.0 
	kde-frameworks/kactivities 
	kde-frameworks/karchive 
	kde-frameworks/kconfigwidgets
	kde-frameworks/kdbusaddons 
	kde-frameworks/kdeclarative 
	kde-frameworks/ki18n 
	kde-frameworks/kpackage 
	kde-frameworks/kwayland 
	kde-frameworks/kwindowsystem 
	kde-frameworks/kxmlgui 
	kde-frameworks/plasma 
	x11-libs/libX11 
	x11-libs/libxcb"

DEPEND="${RDEPEND}
	kde-frameworks/extra-cmake-modules"

pkg_postinst(){
	if has_version ">=dev-qt/qtcore-5.8"; then
		ewarn "Qt5.8 is known to cause build and runtime problems. If you"
		ewarn "experience problems while running Latte Dock,please check this"
		ewarn "out: https://github.com/psifidotos/Latte-Dock/issues/183"
	fi
}
