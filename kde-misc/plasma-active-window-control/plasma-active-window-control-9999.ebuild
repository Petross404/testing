# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_HANDBOOK="forceoptional"
KFMIN=5.70.0
QTMIN=5.14.1
inherit ecm kde.org

DESCRIPTION="Plasma 5 applet for controlling currently active window"
HOMEPAGE="https://store.kde.org/p/998910/"

LICENSE="GPL-2"
SLOT="5"
KEYWORDS="~amd64 ~arm64 ~ppc64 ~x86"
IUSE=""

RDEPEND="
	kde-frameworks/kconfig
	kde-frameworks/kcoreaddons
	kde-frameworks/kwindowsystem
	kde-frameworks/plasma
	dev-qt/qtdbus
	dev-qt/qtdeclarative
	dev-qt/qtgui
	dev-qt/qtwidgets
	dev-qt/qtx11extras
"
DEPEND="${RDEPEND}"
