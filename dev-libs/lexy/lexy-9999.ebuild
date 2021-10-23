# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3

DESCRIPTION="C++ parser combinator library"
HOMEPAGE="https://github.com/foonathan/lexy.git https://foonathan.net/lexy/reference.html"
EGIT_REPO_URI="https://github.com/foonathan/lexy.git"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	~dev-util/radare2-4.5.1
"

RDEPEND="${DEPEND}"
