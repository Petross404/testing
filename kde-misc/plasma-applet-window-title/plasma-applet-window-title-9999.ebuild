# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit kde5

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/psifidotos/applet-window-title.git"
else
	SRC_URI="https://codeload.github.com/psifidotos/plasma-${PN}/tar.gz/v${PV}"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Plasma 5 applet that shows the application title and icon for active window"
HOMEPAGE="https://github.com/psifidotos/applet-window-title"

LICENSE="GPL-2+"
SLOT="0"
IUSE=""

DEPEND="
	kde-frameworks/kdeclarative
	kde-frameworks/plasma
"

RDEPEND="${DEPEND}"

DOCS=( CHANGELOG.md README.md )
