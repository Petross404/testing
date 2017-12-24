# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit qmake-utils

DESCRIPTION="Powerful yet simple to use screenshot software"
HOMEPAGE="https://github.com/lupoDharkael/flameshot"

if [[ ${PV} = 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/lupoDharkael/${PN}.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/lupoDharkael/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="GPL-3"
IUSE=""
SLOT="0"
