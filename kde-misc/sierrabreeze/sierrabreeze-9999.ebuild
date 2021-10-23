# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

KFMIN=5.70.0
QTMIN=5.14.1

inherit ecm kde.org

DESCRIPTION="Fork of Breeze Window decoration that mimics the OSX titlebar buttons"
HOMEPAGE="https://github.com/ishovkun/SierraBreeze"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/kupiqu/SierraBreezeEnhanced.git"
fi

LICENSE="GPL-3"
SLOT="5"

RDEPEND="
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kcoreaddons-${KFMIN}:5
	>=kde-frameworks/kconfig-${KFMIN}:5
	>=kde-frameworks/kcrash-${KFMIN}:5
	>=kde-frameworks/kwindowsystem-${KFMIN}:5
	>=kde-frameworks/ki18n-${KFMIN}:5
	>=kde-frameworks/kconfigwidgets-${KFMIN}:5
	>=kde-frameworks/kwidgetsaddons-${KFMIN}:5
	>=kde-frameworks/kguiaddons-${KFMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtnetwork-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
        >=dev-qt/qtdeclarative-${QTMIN}:5
"
DEPEND="
	${RDEPEND}
	>=kde-frameworks/extra-cmake-modules-${KFMIN}:5
"

src_configure() {
	local mycmakeargs=(
		#I am unsure of the next argument :
		-DKDE_INSTALL_LIBDIR=lib
		-DBUILD_TESTING=$(usex test)
		-DKDE_INSTALL_USE_QT_SYS_PATHS=ON
	)
	cmake-utils_src_configure
}
