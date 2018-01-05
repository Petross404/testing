# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils

DESCRIPTION="Replacement for Qt's moc that is using clang libraries"
HOMEPAGE="https://github.com/woboq/moc-ng"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/woboq/${PN}.git"
	KEYWORDS=""
fi

SLOT="0"
