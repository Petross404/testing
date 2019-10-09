# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils gnome2-utils git-r3

DESCRIPTION="Parametric 2d/3d CAD"
HOMEPAGE="http://solvespace.com"

EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
EGIT_SUBMODULES=( extlib/libdxfrw extlib/flatbuffers extlib/q3d )
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"

RDEPEND="dev-cpp/gtkmm:2.4=
	dev-cpp/pangomm:1.4
	dev-libs/json-c:=
	media-libs/fontconfig
	media-libs/freetype:2
	media-libs/glew:0=
	media-libs/libpng:0=
	virtual/opengl"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

# NOTE: please keep commit hash actually when version up
GIT_COMMIT_HASH="4d1e1341d926ac356b295d5cc3d61c7a6cd7d07d"

src_prepare() {
	rm -r "extlib/libdxfrw" || die  "rm extlib/libdxfrw failed"
	mv "${WORKDIR}/libdxfrw-${DXFRW_COMMIT}" "extlib/libdxfrw" || die "move libdxfrw-${DXFRW_COMMIT} failed"
	sed -i '/include(GetGitCommitHash)/d' CMakeLists.txt || die 'remove GetGitCommitHash by sed failed'
	# fixed in master already
	sed -i -e 's/CHAR_WIDTH/CHAR_WIDTH_/' src/textwin.cpp src/toolbar.cpp src/win32/w32main.cpp src/ui.h || die 'sed failed'
	cmake-utils_src_prepare
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
