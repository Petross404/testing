# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit kde5

DESCRIPTION="An attempt to port kdevqtdesigner-4 to KDevelop 5"
HOMEPAGE="https://github.com/Petross404/kdevqtdesigner"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_BRANCH="testing"
	EGIT_REPO_URI="https://github.com/Petross404/_kdevqtdesigner.git"
	KEYWORDS=""
fi

LICENSE="GPL-3"
IUSE=""
SLOT="5"

RDEPEND="
	kde-frameworks/ki18n
	kde-frameworks/kconfigwidgets
	kde-frameworks/kcoreaddons
	dev-qt/designer
	dev-qt/qtcore
	dev-qt/qtgui
	dev-qt/qttest
	dev-qt/qtwidgets
"

DEPEND="
	${RDEPEND}
	kde-frameworks/extra-cmake-modules"
