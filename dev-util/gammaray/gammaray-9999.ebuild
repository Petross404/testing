# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils kde5-functions git-r3

QT_MINIMAL="5.9"

DESCRIPTION="High-level runtime introspection tool for Qt applications"
HOMEPAGE="https://github.com/KDAB/GammaRay \
		https://www.kdab.com/?s=gammaray"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/KDAB/GammaRay.git"
else
	SRC_URI="https://github.com/KDAB/GammaRay/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-2+"
SLOT=0
IUSE="3d auto-detect backtrace backtrace-symbol bluetooth +client \
	concurrent designer -doc feedback +gpl-only-features \
	position printsupport scxml svg testing qml unwind \
	wayland webengine"

RDEPEND="
		3d?		( $(add_qt_dep qt3d) )
		bluetooth?	( $(add_qt_dep qtbluetooth) )
		concurrent?	( $(add_qt_dep qtconcurrent) )
		designer?	( $(add_qt_dep designer) )
		position?	( $(add_qt_dep qtpositioning) )
		printsupport?	( $(add_qt_dep qtprintsupport) )
		qml?		( $(add_qt_dep qtdeclarative) )
		scxml?		( $(add_qt_dep qtscxml) )
		svg?		( $(add_qt_dep qtsvg) )
		testing?	( $(add_qt_dep qttest) )
		webengine?	( $(add_qt_dep qtwebengine) )
		wayland?	( $(add_qt_dep qtwayland) )
		$(add_qt_dep qtcore)
		$(add_qt_dep qtgui)
		$(add_qt_dep qtnetwork)
		$(add_qt_dep qtwidgets)
		$(add_qt_dep qtxml)
		$(add_frameworks_dep kitemmodels)
"

DEPEND="${RDEPEND}"

src_configure(){
	#Upstream uses a *ton* of automagic deps
	local mycmakeargs+=(
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt53DAnimation=$(usex !3d)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt53DExtras=$(usex !3d)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt53DInput=$(usex !3d)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt53DLogic=$(usex !3d)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt53DRender=$(usex !3d)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt53DQuick=$(usex !3d)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Bluetooth=$(usex !bluetooth)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Concurrent=$(usex !concurrent)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Designer=$(usex !designer)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Positioning=$(usex !position)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5PrintSupport=$(usex !printsupport)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Qml=$(usex !qml)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Quick=$(usex !qml)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5QuickWidgets=$(usex !qml)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Script=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5ScriptTools=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Svg=$(usex !svg)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Scxml=$(usex !scxml)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Test=$(usex !testing)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5WebEngineWidgets=$(usex !webengine)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5Widgets=$(usex !webengine)
		-DCMAKE_DISABLE_FIND_PACKAGE_Qt5WaylandCompositor=$(usex !wayland)
		-DGAMMARAY_BUILD_DOCS=$(usex doc)
		-DGAMMARAY_BUILD_UI=$(usex client)
		-DGAMMARAY_ENABLE_GPL_ONLY_FEATURES=$(usex gpl-only-features)
		-DGAMMARAY_DISABLE_FEEDBACK=$(usex !feedback)
		-DSTACK_DETAILS_AUTO_DETECT=$(usex auto-detect)
		-DSTACK_DETAILS_BACKTRACE_SYMBOL=$(usex backtrace-symbol)
		-DSTACK_WALKING_BACKTRACE=$(usex backtrace)
		-DSTACK_WALKING_UNWIND=$(usex unwind)
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	ewarn
	ewarn "Install dev-util/kdstatemachineeditor as optional dependency"
	ewarn "for graphical state machine debugging support"
	ewarn
}
