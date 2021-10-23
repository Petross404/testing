# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils

DESCRIPTION="Multiarchitecture disassembler written in modern C++11 and Qt5"
HOMEPAGE="https://redasm.io/"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/radareorg/r2ghidra.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/radareorg/r2ghidra/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	#S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
IUSE=""
SLOT="0"
