# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit cmake-utils

DESCRIPTION="Dear ImGui binding for use with SFML"
HOMEPAGE="https://github.com/eliasdaler/imgui-sfml"

if [[ ${PV} == 9999 ]] ; then
        inherit git-r3
        EGIT_REPO_URI="https://github.com/eliasdaler/imgui-sfml.git"
        KEYWORDS=""
else
        SRC_URI="https://github.com/eliasdaler/imgui-sfml/archive/v${PV}.tar.gz -> ${P}.tar.gz"
        KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="demo examples"
