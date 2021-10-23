# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

AUTOTOOLS_AUTORECONF=true

inherit cmake-utils git-r3

ELMER_ROOT="elmerfem"
MY_PN=${PN/elmer-/}

DESCRIPTION="Finite element programs, libraries, and visualization tools - elmer I/O library"
HOMEPAGE="http://www.csc.fi/english/pages/elmer"
SRC_URI=""
EGIT_REPO_URI="https://github.com/ElmerCSC/elmerfem.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug static-libs"

#S="${WORKDIR}/eio"

#PATCHES=( "${FILESDIR}"/${PN}-6.0_p4651-shared.patch )

#src_configure(){
#	local mycmakeargs=(
#		-DCMAKE_MAKE_PROGRAM="make"
#	)
#	cmake-utils_src_configure
#}
