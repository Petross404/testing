# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_{4,5,6} )

inherit cmake-multilib eutils python-r1

DESCRIPTION="Tool that generates a compilation database for clang tooling"
HOMEPAGE="https://github.com/rizsotto/Bear"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rizsotto/Bear.git"
else
	SRC_URI="https://github.com/rizsotto/Bear/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	S="${WORKDIR}/Bear-${PV}"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE="lit"

RDEPEND="lit? ( dev-python/lit[${PYTHON_USEDEP}] )
"
