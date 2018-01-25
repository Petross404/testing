# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit kde5

DESCRIPTION="Poke around in a Qt-application and manipulate the application to some extent"
HOMEPAGE="https://github.com/KDAB/GammaRay"

LICENSE="GPL-2+"
IUSE="+client -doc -extras feedback wayland"
SLOT="0"

SRC_URI="https://github.com/KDAB/GammaRay/releases/download/v${PV}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

RDEPEND="extras? (
			$(add_qt_dep designer)
			$(add_qt_dep qt3d)
			$(add_qt_dep qtbluetooth)
			$(add_qt_dep qtconcurrent)
			$(add_qt_dep qtpositioning)
			$(add_qt_dep qtprintsupport)
			$(add_qt_dep qtquickcontrols2)
			$(add_qt_dep qtscript)
			$(add_qt_dep qtsvg)
			$(add_qt_dep qttest)
			$(add_qt_dep qtwebkit)
		)
		$(add_qt_dep qtcore)
		$(add_qt_dep qtgui)
		$(add_qt_dep qtnetwork)
		$(add_qt_dep qtwidgets)
		$(add_qt_dep qtxml)
		wayland? ( $(add_qt_dep qtwayland) )
		$(add_frameworks_dep kitemmodels)"

DEPEND="${RDEPEND}"

# A *lot* of automagic deps in CMakeLists.txt
src_prepare(){
	if ! use extras; then
		eapply	"${FILESDIR}/disable-qtextras-gammaray-all.patch"
		#sed -i '/Bluetooth/d' CMakeLists.txt || die
		#sed -i '/Concurrent/d' CMakeLists.txt || die
		#sed -i '/OPTIONAL_COMPONENTS Designer/d' CMakeLists.txt || die
		#sed -i '/Positioning/d' CMakeLists.txt || die
		#sed -i '/PrintSupport/d' CMakeLists.txt || die
		#sed -i '/Qml/d' CMakeLists.txt || die
		#sed -i '/Quick/d' CMakeLists.txt || die
		#sed -i '/Svg/d' CMakeLists.txt || die
		#sed -i '/Script/d' CMakeLists.txt || die
		#sed -i '/Test/d' CMakeLists.txt || die
		#sed -i '/Webkit/d' CMakeLists.txt || die
		#sed -i '/3D/d' CMakeLists.txt || die
	fi

	if ! use wayland; then
		sed -i '/WaylandCompositor/d' CMakeLists.txt || die
	fi
	cmake-utils_src_prepare
}

src_configure(){
	mycmakeargs+=(
		-DGAMMARAY_BUILD_DOCS=$(usex doc)
		-DGAMMARAY_BUILD_UI=$(usex client)
		-DGAMMARAY_DISABLE_FEEDBACK=$(usex !feedback)
	)
	cmake-utils_src_configure
}
