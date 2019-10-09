# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils git-r3

DESCRIPTION="Crossplatform IDE for NASM, MASM, GAS and FASM assembly languages."
HOMEPAGE="http://dman95.github.io/SASM/"
EGIT_REPO_URI="https://github.com/Dman95/SASM.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5[xcb]
	dev-qt/qtnetwork:5[ssl]
	dev-qt/qtopengl:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	dev-qt/qtwebkit:5
	dev-qt/qtxml:5
	sys-libs/zlib"

DEPEND="${RDEPEND}
	dev-lang/nasm
	sys-devel/gdb
	x11-libs/libxcb
"

src_configure() {
	eqmake5 -r PREFIX="/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
