# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

FORTRAN_STANDARD=90

inherit cmake-utils fortran-2 multilib

ELMER_ROOT="elmerfem"
MY_PN=${PN/elmer-/}

DESCRIPTION="Finite element programs, libraries, and visualization tools - main fem"
HOMEPAGE="http://www.csc.fi/english/pages/elmer"
SRC_URI="https://codeload.github.com/ElmerCSC/elmerfem/tar.gz/release-8.4 -> elmer-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mpi debug"

RDEPEND="
	virtual/blas
	virtual/lapack
	sci-libs/arpack
	sci-libs/matc
	sci-libs/elmer-hutiter
	sci-libs/elmer-eio
	mpi?     ( sys-cluster/mpich2 )"
DEPEND="${RDEPEND}"
# Note this seems to only configure correctly with the elmer version of umfpack
# But this doesn't stop it from compiling / working without it

S="${WORKDIR}/fem"

PATCHES=(
	"${FILESDIR}"/${P}-oos.patch
	"${FILESDIR}"/${P}-underlinking.patch
)
