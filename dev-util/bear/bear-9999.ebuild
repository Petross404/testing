# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_4,3_5,3_6} )

inherit cmake-utils eutils python-r1

DESCRIPTION="Tool that generates a compilation database for clang tooling"
HOMEPAGE="https://github.com/rizsotto/Bear"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/rizsotto/Bear.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/rizsotto/Bear/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2+"
SLOT="0"
IUSE=""

RDEPEND=""

pkg_setup()
{
	ewarn
	ewarn "Consider installing dev-python/lit as a runtime dependency"
	ewarn "for better LLVM integration"
	ewarn
}

pkg_postinst()
{
		ewarn
	ewarn "Consider installing dev-python/lit as a runtime dependency"
	ewarn "for better LLVM integration"
	ewarn
}
