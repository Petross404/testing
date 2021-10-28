# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8,9} )
inherit autotools python-r1

DESCRIPTION="C library for interfacing with common SoC peripherals through generic kernel interfaces."
HOMEPAGE="https://github.com/jackmitch/libsoc"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/jackmitch/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/jackmitch/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

IUSE="python"
LICENSE="LGPLv2"
SLOT="0"
KEYWORDS=""

RDEPEND="
	python? (
		${PYTHON_DEPS}
	)"

DEPEND="python? ( ${PYTHON_DEPS} )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

src_prepare() {
	default
	eautoreconf
}


src_configure() {
	python_setup

	econf \
		$(use_enable python)
}
