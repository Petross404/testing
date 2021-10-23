# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6,7,8,9} )

inherit qmake-utils xdg-utils python-single-r1 git-r3

DESCRIPTION="A Qt and C++ GUI for radare2 reverse engineering framework"
HOMEPAGE="https://cutter.re https://github.com/radareorg/cutter/"
EGIT_REPO_URI="https://github.com/radareorg/cutter.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	~dev-util/rizin-9999
"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-1.10.3-python3-config.patch"
)

src_configure() {
	local myqmakeargs=(
		CUTTER_ENABLE_PYTHON=true \
		CUTTER_USE_ADDITIONAL_RIZIN_PATH=true \
		CUTTER_USE_BUNDLED_RIZIN=true \
		CUTTER_INSTALL_DATADIR="share/RizinOrg/Cutter" \
		PREFIX=\'${EPREFIX}/usr\'
	)

	eqmake5 "${myqmakeargs[@]}" src
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
