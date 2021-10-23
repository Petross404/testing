# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

AUTOTOOLS_AUTORECONF=true

inherit cmake-utils

ELMER_ROOT="elmerfem"
MY_PN=${PN/elmer-/}

DESCRIPTION="Finite element programs, libraries, and visualization tools - elmer I/O library"
HOMEPAGE="http://www.csc.fi/english/pages/elmer"
SRC_URI="https://codeload.github.com/ElmerCSC/elmerfem/tar.gz/release-${PV} -> elmer-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug static-libs"

S="${WORKDIR}/eio"

#PATCHES=( "${FILESDIR}"/${P}-shared.patch )
