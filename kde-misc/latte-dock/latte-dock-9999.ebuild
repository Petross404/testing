# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="Latte is a dock (plasma applet) that provides an elegant experience for your tasks."
HOMEPAGE="https://store.kde.org/p/1169519/
https://github.com/psifidotos/Latte-Dock"

if [[ ${PV} = 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/psifidotos/Latte-Dock.git"
else
	SRC_URI="https://codeload.github.com/psifidotos/${PN}/tar.gz/v${PV} -> ${P}.tar.gz "
fi

LICENSE="GPL-2+"
KEYWORDS="**"
SLOT="5"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( README.md )

BUILD_DIR="${WORKDIR}/${P}/build"

src_prepare(){
	sed -i '/sudo/d' install-global.sh
	chmod +x "${WORKDIR}"/"${P}"/install-global.sh
	"${WORKDIR}"/"${P}"/install-global.sh
	eapply_user
}
