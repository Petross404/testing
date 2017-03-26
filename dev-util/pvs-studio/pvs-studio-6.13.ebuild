# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils eutils

DESCRIPTION="Static code analysis/bug detection console application for C/C++."
HOMEPAGE="https://www.viva64.com/en/pvs-studio/"

SRC_URI="http://files.viva64.com/pvs-studio-6.13.20904.1-x86_64.tgz -> ${P}.tgz"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-2+"
SLOT="0"

S="${WORKDIR}/${P}.20904.1-x86_64/src/plog-converter/"

src_configure() {
	mycmakeargs=(
		-DCMAKE_INSTALL_PREFIX=/usr
		-DCMAKE_BUILD_TYPE=Release
	)
	cmake-utils_src_configure
}

src_install() {
	cd ../../bin/
	dobin pvs-studio 
	dobin pvs-studio-analyzer
	
	cmake-utils_src_install
}
