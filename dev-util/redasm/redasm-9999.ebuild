# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

QT_MINIMAL=5.9

inherit cmake-utils flag-o-matic

DESCRIPTION="Multiarchitecture disassembler written in modern C++11 and Qt5"
HOMEPAGE="https://redasm.io/"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/REDasmOrg/REDasm.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/REDasmOrg/REDasm/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
IUSE=""
SLOT="0"
