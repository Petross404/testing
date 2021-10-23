# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils git-r3

DESCRIPTION="A 'wiring' like library for the Raspberry Pi"
HOMEPAGE="http://wiringpi.com/"
EGIT_REPO_URI="https://github.com/Pi4J/wiringPi.git"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

MAKEDIRS="wiringPi devLib"

src_prepare() {
	epatch "${FILESDIR}/git-Makefile-fix.patch"
	eapply_user
}

src_compile() {
	for d in ${MAKEDIRS}; do
		cd "${WORKDIR}/${P}/${d}"
		emake
	done
}

src_install() {
	for d in ${MAKEDIRS}; do
		cd "${WORKDIR}/${P}/${d}"
		emake DESTDIR="${D}/usr/" PREFIX="" install
	done
}
