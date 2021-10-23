# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

QT_MINIMAL=5.6.1

inherit cmake-utils flag-o-matic

DESCRIPTION="...s"
HOMEPAGE="https://github.com/Petross404/kdevqtdesigner"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Petross404/kdevqtdesigner.git"
	EGIT_BRANCH="testing"
	KEYWORDS=""
else
	#SRC_URI="https://github.com/KDAB/${PN}/releases/download/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	#S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
IUSE=""
SLOT="0"

RDEPEND="
	kde-frameworks/ki18n
	kde-frameworks/kio
	kde-frameworks/kitemmodels
	kde-frameworks/kitemviews
	kde-frameworks/kconfigwidgets
	kde-frameworks/kcoreaddons
	kde-frameworks/solid
	kde-frameworks/threadweaver
	dev-qt/qtcore
	dev-qt/qtdbus
	dev-qt/qtgui
	dev-qt/qtnetwork
	dev-qt/qttest
	dev-qt/qtwidgets
	dev-qt/qtxml
	dev-libs/elfutils
	sys-devel/gettext"

DEPEND="
	${RDEPEND}
	kde-frameworks/extra-cmake-modules"

src_prepare() {
	test-flag-CXX -std=c++11 || die "A c++11 capable compiler is required to build ${PN}"
	cmake-utils_src_prepare
}

