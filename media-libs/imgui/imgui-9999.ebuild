# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Bloat-free graphical user interface library for C++"
HOMEPAGE="https://github.com/ocornut/imgui.git"

if [[ ${PV} == 9999 ]] ; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/ocornut/imgui.git"
        KEYWORDS=""
else
        SRC_URI="https://github.com/eliasdaler/imgui-sfml/archive/v${PV}.tar.gz -> ${P}.tar.gz"
        KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"

RDEPEND="media-libs/glew:0"
DEPEND="${RDEPEND}"

