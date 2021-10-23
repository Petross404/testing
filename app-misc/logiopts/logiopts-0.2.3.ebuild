# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils flag-o-matic

DESCRIPTION="An unofficial userspace driver for HID++ Logitech devices"
HOMEPAGE="https://github.com/PixlOne/logiops"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/PixlOne/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/PixlOne/logiops/archive/refs/tags/v0.2.3.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-${PV}"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
IUSE=""
SLOT="0"
