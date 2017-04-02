# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils git-r3

DESCRIPTION="Configurable and efficient logging framework for C++"
HOMEPAGE="https://github.com/froglogic/tracetool"

LICENSE="GPL-3+"
IUSE="doc"
SLOT="0"
EGIT_REPO_URI="https://github.com/froglogic/tracetool.git"
KEYWORDS=""

RDEPEND=""
DEPEND=">=dev-util/cmake-3
		
	${RDEPEND}"
