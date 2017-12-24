# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

QT_MINIMAL=5.6.1

inherit cmake-utils kde5-functions flag-o-matic

DESCRIPTION="The Linux perf GUI for performance analysis"
HOMEPAGE="https://github.com/KDAB/hotspot"

if [[ ${PV} = 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/KDAB/hotspot.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/KDAB/${PN}/releases/download/v${PV}/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
IUSE="static-libs"
SLOT="0"

RDEPEND="
	$(add_frameworks_dep coreaddons)
	$(add_frameworks_dep i18n)
	$(add_frameworks_dep itemmodels)
	$(add_frameworks_dep itemviews)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep solid)
	$(add_frameworks_dep threadweaver)
	$(add_qt_dep qtcore)
	$(add_qt_dep qtdbus)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtnetwork)
	$(add_qt_dep qttest)
	$(add_qt_dep qtwidgets)
	$(add_qt_dep qtxml)
	dev-libs/elfutils"

DEPEND="
	${RDEPEND}
	$(add_frameworks_dep extra-cmake-modules)"

src_prepare() {
	test-flag-CXX -std=c++11 || die "At least C++11 is required to build ${PN}"
	cmake-utils_src_prepare
}

src_configure() {
	mycmakeargs+=(
		-DBUILD_SHARED_LIBS=$(usex static-libs)
	)
	cmake-utils_src_configure
}
